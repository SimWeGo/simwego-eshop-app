import "dart:developer";

import "package:esim_open_source/data/services/remote_config_service_impl.dart";
import "package:esim_open_source/domain/repository/services/flutter_channel_handler_service.dart";
import "package:flutter/services.dart";
import "package:url_launcher/url_launcher.dart";
import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";

class FlutterChannelHandlerServiceImpl implements FlutterChannelHandlerService {
  FlutterChannelHandlerServiceImpl.initialize();

  // Define the method channel
  static const MethodChannel flutterToNativePlatform =
      MethodChannel("com.luxe.esim/flutter_to_native");

  static FlutterChannelHandlerServiceImpl getInstance() {
    _instance ??= FlutterChannelHandlerServiceImpl.initialize();
    return _instance!;
  }

  String get errorMessage =>
      LocaleKeys.eSim_installation_error_message.tr();

  static FlutterChannelHandlerServiceImpl? _instance;

  @override
  Future<void> openSimProfilesSettings() async {
    try {
      await flutterToNativePlatform.invokeMethod("openSimProfilesSettings");
    } on PlatformException catch (e) {
      log("openSimProfilesSettings Error : ${e.message}");
      throw Exception(errorMessage);
    } on Object catch (e) {
      log("openSimProfilesSettings Error: $e");
      throw Exception(errorMessage);
    }
  }

  @override
  Future<void> openEsimSetupForIOS({
    required String smdpAddress,
    required String activationCode,
  }) async {
    try {
      String cardData = "LPA:1\$$smdpAddress\$$activationCode";
      await flutterToNativePlatform.invokeMethod(
        "openEsimSetup",
        <String, String>{"cardData": cardData},
      );
    } on PlatformException catch (e) {
      log("openEsimSetup Error : ${e.message}");
      throw Exception(errorMessage);
    } on Object catch (e) {
      log("openEsimSetup Error: $e");
      throw Exception(errorMessage);
    }
  }

  @override
  Future<bool> openEsimSetupForAndroid({
    required String smdpAddress,
    required String activationCode,
    bool isSHAExist = true,
  }) async {
    String cardData = "LPA:1\$$smdpAddress\$$activationCode";

    // Feature flag (Remote Config): use the Android eSIM universal link,
    // mirroring the iOS `esimsetup.apple.com` flow. Can be turned off to fall
    // back to the legacy native intent without a new app release.
    final bool directInstall = await RemoteConfigServiceImpl
        .instance.isAndroidDirectEsimInstallEnabled;

    if (directInstall) {
      try {
        // `$` and `:` must stay RAW in `carddata` — build the string and
        // Uri.parse it (do NOT use a query-parameter map, which would encode
        // them to %24/%3A and break the Android eSIM setup handler).
        final Uri uri = Uri.parse(
          "https://esimsetup.android.com/esim_qrcode_provisioning?carddata=$cardData",
        );
        final bool launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (!launched) {
          throw Exception(errorMessage);
        }
        return launched;
      } on Object catch (e) {
        log("openEsimSetupForAndroid (universal link) Error: $e");
        throw Exception(errorMessage);
      }
    }

    // Legacy path: native intent (Android 15+) / privileged eUICC install.
    try {
      bool result = await flutterToNativePlatform.invokeMethod(
        "openEsimSetup",
        <String, String>{
          "cardData": cardData,
          "isSHAExist": "$isSHAExist",
        },
      );
      if (!result) {
        throw Exception(LocaleKeys.esim_installNotSupported.tr());
      }
      return result;
    } on PlatformException catch (e) {
      log("openEsimSetupForAndroid Error : ${e.message}");
      throw Exception(errorMessage);
    } on Object catch (e) {
      log("openEsimSetupForAndroid Error: $e");
      throw Exception(errorMessage);
    }
  }
}
