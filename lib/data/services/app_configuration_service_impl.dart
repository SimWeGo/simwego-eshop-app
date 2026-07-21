import "dart:async";
import "dart:developer";

import "package:esim_open_source/app/app.locator.dart";
import "package:esim_open_source/data/remote/responses/app/configuration_response_model.dart";
import "package:esim_open_source/domain/repository/services/app_configuration_service.dart";
import "package:esim_open_source/domain/repository/services/local_storage_service.dart";
import "package:esim_open_source/domain/use_case/app/get_configurations_use_case.dart";
import "package:esim_open_source/domain/use_case/base_use_case.dart";
import "package:esim_open_source/domain/util/resource.dart";
import "package:esim_open_source/presentation/enums/login_type.dart";
import "package:esim_open_source/presentation/enums/payment_type.dart";

class AppConfigurationServiceImpl extends AppConfigurationService {
  AppConfigurationServiceImpl._privateConstructor();

  static AppConfigurationServiceImpl? _instance;

  static AppConfigurationServiceImpl get instance {
    if (_instance == null) {
      _instance = AppConfigurationServiceImpl._privateConstructor();
      log("Initialize App Configuration Service");
      unawaited(_instance?.getAppConfigurations());
    }
    return _instance!;
  }

  Completer<void>? _appConfigCompleter;
  List<ConfigurationResponseModel>? _configData;

  @override
  Future<void> getAppConfigurations() async {
    _appConfigCompleter = Completer<void>();

    String? config = locator<LocalStorageService>().getString(
      LocalStorageKeys.appConfigurations,
    );

    if (config != null) {
      try {
        _configData = ConfigurationResponseModel.fromJsonListString(config);
      } on Object catch (e) {
        log(e.toString());
      }
    }

    try {
      // Retry the remote fetch a few times: on a fresh install the first
      // network call can fail or be slow. The whole app waits on this completer
      // (Supabase login init, catalog version, home data), so a single failed
      // fetch used to leave every awaiter hanging until the app was killed and
      // reopened.
      for (int attempt = 0; attempt < 3; attempt++) {
        try {
          Resource<List<ConfigurationResponseModel>?> response =
              await GetConfigurationsUseCase(locator()).execute(NoParams());

          if (response.resourceType == ResourceType.success &&
              (response.data?.isNotEmpty ?? false)) {
            _configData = response.data;

            locator<LocalStorageService>().setString(
              LocalStorageKeys.appConfigurations,
              ConfigurationResponseModel.toJsonListString(
                _configData ?? <ConfigurationResponseModel>[],
              ),
            );
            break;
          }
        } on Object catch (e) {
          log("getAppConfigurations attempt $attempt failed: $e");
        }

        if (attempt < 2) {
          await Future<void>.delayed(const Duration(seconds: 2));
        }
      }
    } finally {
      // ALWAYS release awaiters, even if every attempt failed, so config
      // dependent code falls back to cached/empty values and can retry instead
      // of hanging the whole app forever.
      if (!(_appConfigCompleter?.isCompleted ?? true)) {
        _appConfigCompleter?.complete();
      }
    }
  }

  @override
  Future<String> get getCatalogVersion async {
    await _appConfigCompleter?.future;
    return _getConfigData(
      key: ConfigurationResponseKeys.catalogBundleCashVersion,
    );
  }

  @override
  String get getDefaultCurrency {
    return _getConfigData(
      key: ConfigurationResponseKeys.defaultCurrency,
    );
  }

  @override
  Future<String> get getSupabaseAnon async {
    String temp =
        _getConfigData(key: ConfigurationResponseKeys.supabaseAnonKey);
    if (temp.isEmpty) {
      await _appConfigCompleter?.future;
      return _getConfigData(key: ConfigurationResponseKeys.supabaseAnonKey);
    }
    return temp;
  }

  @override
  Future<String> get getSupabaseUrl async {
    String temp =
        _getConfigData(key: ConfigurationResponseKeys.supabaseBaseUrl);
    if (temp.isEmpty) {
      await _appConfigCompleter?.future;
      return _getConfigData(key: ConfigurationResponseKeys.supabaseBaseUrl);
    }
    return temp;
  }

  @override
  Future<String> get getWhatsAppNumber async {
    String temp = _getConfigData(key: ConfigurationResponseKeys.whatsAppNumber);
    if (temp.isEmpty) {
      await _appConfigCompleter?.future;
      return _getConfigData(key: ConfigurationResponseKeys.whatsAppNumber);
    }
    return temp;
  }

  @override
  LoginType? get getLoginType {
    String loginTypeString = _getConfigData(
      key: ConfigurationResponseKeys.loginType,
    );
    if (loginTypeString.isNotEmpty) {
      return LoginType.fromValue(value: loginTypeString);
    }
    return null;
  }

  @override
  List<PaymentType>? get getPaymentTypes {
    String paymentTypeString = _getConfigData(
      key: ConfigurationResponseKeys.paymentTypes,
    );
    if (paymentTypeString.isNotEmpty) {
      return PaymentType.getListFromValues(paymentTypeString);
    }
    return null;
  }

  String _getConfigData({required ConfigurationResponseKeys key}) {
    return _configData
            ?.firstWhere(
              (ConfigurationResponseModel element) =>
                  element.key?.toLowerCase() ==
                  key.configurationKeyValue.toLowerCase(),
              orElse: () => ConfigurationResponseModel(key: "", value: ""),
            )
            .value ??
        "";
  }

  @override
  String get getCashbackDiscount {
    String cashbackDiscount = _getConfigData(
      key: ConfigurationResponseKeys.cashbackDiscount,
    );
    return "$cashbackDiscount%";
  }
}
