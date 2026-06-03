/// Resolves a backend `custom_banner_text` value, which can come in two
/// shapes depending on the endpoint:
///   - A String already localized by the backend (e.g. `/promotion/info/{code}`
///     resolves it server-side per the request `Accept-Language`).
///   - A `Map<String, String>` of `{lang: text}` (the affiliate dashboard
///     endpoints return the raw JSONB column without resolution).
///
/// Falls back to the current language → English → first available value.
/// Returns `null` only when the input is null or an unsupported type.
class BannerTranslationHelper {
  static String? resolve(dynamic raw, String currentLang) {
    if (raw == null) return null;
    if (raw is String) return raw;
    if (raw is Map) {
      final Map<String, String> map = raw.map<String, String>(
        (dynamic key, dynamic value) =>
            MapEntry<String, String>(key.toString(), value.toString()),
      );
      if (map.isEmpty) return null;
      return map[currentLang] ?? map["en"] ?? map.values.first;
    }
    return null;
  }
}
