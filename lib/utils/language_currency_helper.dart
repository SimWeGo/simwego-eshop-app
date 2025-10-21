import "dart:developer";
import "dart:ui";

import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/app/app.locator.dart";
import "package:esim_open_source/domain/repository/services/local_storage_service.dart";
import "package:esim_open_source/domain/repository/services/referral_info_service.dart";
import "package:esim_open_source/domain/use_case/app/get_banner_use_case.dart";
import "package:esim_open_source/presentation/enums/language_enum.dart";
import "package:esim_open_source/presentation/views/home_flow_views/my_esim_view/my_esim_view_model.dart";
import "package:stacked_services/stacked_services.dart";

Future<void> syncLanguageAndCurrencyCode({
  String? languageCode,
  String? currencyCode,
}) async {
  log("syncLanguageAndCurrencyCode >>> languageCode:$languageCode >> currencyCode:$currencyCode");

  bool currencyCodeChanged = hasCurrencyCodeChanged(currencyCode);
  bool languageCodeChanged = hasLanguageCodeChanged(languageCode);

  log("syncLanguageAndCurrencyCode >>> is called >> languageCodeChanged:$languageCodeChanged >> currencyCodeChanged:$currencyCodeChanged");

  if (currencyCodeChanged || languageCodeChanged) {
    if (currencyCodeChanged) {
      await locator<LocalStorageService>()
          .setString(LocalStorageKeys.appCurrency, currencyCode ?? "EUR");
    }

    if (languageCodeChanged) {
      String value = LanguageEnum.fromString(languageCode ?? "en").code;
      await StackedService.navigatorKey?.currentContext!
          .setLocale(Locale(value));
      await locator<LocalStorageService>()
          .setString(LocalStorageKeys.appLanguage, value);
    }

    await locator<MyESimViewModel>().refreshScreen();
    await locator<ReferralInfoService>().refreshReferralInfo();
    GetBannerUseCase(locator()).resetBannerStream();
  }
}

bool hasCurrencyCodeChanged(String? currencyCode) {
  if (currencyCode != null &&
      currencyCode.trim().isNotEmpty &&
      currencyCode !=
          locator<LocalStorageService>()
              .getString(LocalStorageKeys.appCurrency)) {
    return true;
  }
  return false;
}

bool hasLanguageCodeChanged(String? languageCode) {
  if (languageCode != null && languageCode.trim().isNotEmpty) {
    LanguageEnum lang = LanguageEnum.fromString(languageCode);
    if (lang.code !=
        locator<LocalStorageService>()
            .getString(LocalStorageKeys.appLanguage)) {
      return true;
    }
  }
  return false;
}
