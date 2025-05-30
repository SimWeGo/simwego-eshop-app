import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class TopIndicator extends Decoration {
  const TopIndicator({
    required this.color,
    this.additionalWidth = 0,
    this.strokeWidth = 4,
  });
  final Color color;
  final double additionalWidth;
  final double strokeWidth;
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TopIndicatorBox(
      color: color,
      additionalWidth: additionalWidth,
      strokeWidth: strokeWidth,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty("color", color))
      ..add(DoubleProperty("additionalWidth", additionalWidth))
      ..add(DoubleProperty("strokeWidth", strokeWidth));
  }
}

class _TopIndicatorBox extends BoxPainter {
  _TopIndicatorBox({
    required this.color,
    required this.additionalWidth,
    required this.strokeWidth,
  });
  final Color color;
  final double additionalWidth;
  final double strokeWidth;
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    canvas.drawLine(
      Offset(offset.dx - additionalWidth, offset.dy),
      Offset(cfg.size!.width + offset.dx + additionalWidth, 0),
      paint,
    );
  }
}
