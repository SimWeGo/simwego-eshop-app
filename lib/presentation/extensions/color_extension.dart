import "dart:ui";

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final StringBuffer buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write("ff");
    }
    buffer.write(hexString.replaceFirst("#", ""));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${((a * 255) as int).toRadixString(16).padLeft(2, '0')}'
      '${((r * 255) as int).toRadixString(16).padLeft(2, '0')}'
      '${((g * 255) as int).toRadixString(16).padLeft(2, '0')}'
      '${((b * 255) as int).toRadixString(16).padLeft(2, '0')}';
}

/// Darken a color by [percent] amount (100 = black)
// ........................................................
Color darken(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  double f = 1 - percent / 100;
  return Color.fromARGB(
    (c.a * 255) as int,
    ((c.r * 255) * f).round(),
    ((c.g * 255) * f).round(),
    ((c.b * 255) * f).round(),
  );
}

/// Lighten a color by [percent] amount (100 = white)
// ........................................................
Color lighten(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  double p = percent / 100;
  return Color.fromARGB(
    (c.a * 255) as int,
    ((c.r * 255) as int) + ((255 - (c.r * 255) as int) * p).round(),
    ((c.g * 255) as int) + ((255 - ((c.g * 255) as int)) * p).round(),
    ((c.b * 255) as int) + ((255 - ((c.b * 255) as int)) * p).round(),
  );
}
