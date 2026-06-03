import "package:esim_open_source/domain/repository/services/local_storage_service.dart";

/// Persists the latest affiliate promo code applied at checkout so the same
/// code is re-applied automatically on the next launch, mirroring the web
/// behaviour. The code is kept for 30 days, then purged on next read.
class PromoAffiliateService {
  PromoAffiliateService(this._localStorage);

  final LocalStorageService _localStorage;

  static const Duration _ttl = Duration(days: 30);

  Future<void> store(String code) async {
    final int expiryMs = DateTime.now().add(_ttl).millisecondsSinceEpoch;
    await _localStorage.setString(LocalStorageKeys.promoAffiliateCode, code);
    await _localStorage.setString(
      LocalStorageKeys.promoAffiliateExpiry,
      expiryMs.toString(),
    );
  }

  /// Returns the stored code if still inside the 30-day TTL, otherwise null
  /// (and the entries are purged so the same call is idempotent).
  String? getValid() {
    final String? code =
        _localStorage.getString(LocalStorageKeys.promoAffiliateCode);
    final String? expiryStr =
        _localStorage.getString(LocalStorageKeys.promoAffiliateExpiry);
    if (code == null || code.isEmpty || expiryStr == null) {
      return null;
    }
    final int? expiry = int.tryParse(expiryStr);
    if (expiry == null || DateTime.now().millisecondsSinceEpoch > expiry) {
      clear();
      return null;
    }
    return code;
  }

  Future<void> clear() async {
    await _localStorage.remove(LocalStorageKeys.promoAffiliateCode);
    await _localStorage.remove(LocalStorageKeys.promoAffiliateExpiry);
  }
}
