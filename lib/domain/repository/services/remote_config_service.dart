enum RemoteConfigKey {
  promoCodeEnabled,
  androidEsimDirectInstall;
}

abstract class RemoteConfigService {
  Future<bool> get isPromoCodeFieldVisible;

  /// Android eSIM install via the `esimsetup.android.com` universal link
  /// (mirrors the iOS `esimsetup.apple.com` flow). Default ON — set to false
  /// in Remote Config to roll back to the legacy native intent without a
  /// new app release.
  Future<bool> get isAndroidDirectEsimInstallEnabled;
}
