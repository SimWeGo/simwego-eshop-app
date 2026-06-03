import "package:esim_open_source/app/app.locator.dart";
import "package:esim_open_source/domain/repository/services/local_storage_service.dart";
import "package:esim_open_source/utils/generation_helper.dart";

extension StringExtensions on String {
  String get appendAppCurrency => "${this}_${getSelectedCurrencyCode()}";

  String get appendAppLanguage =>
      "${this}_${locator<LocalStorageService>().languageCode}";

  /// Appends the last backend-detected ISO country code so the bundles cache
  /// is invalidated when the user travels to a country with a different VAT
  /// rate. Falls back to an empty segment when nothing has been stored yet
  /// (first launch or pre-backend-deploy), keeping the legacy key shape.
  String get appendAppCountry {
    final String? country = locator<LocalStorageService>()
        .getString(LocalStorageKeys.detectedCountryCode);
    return "${this}_${country ?? ''}";
  }
}
