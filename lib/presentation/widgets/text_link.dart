import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class TextLink extends StatelessWidget {
  const TextLink(this.text, {this.onPressed, super.key});
  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text ?? "",
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty("text", text))
      ..add(ObjectFlagProperty<void Function()?>.has("onPressed", onPressed));
  }
}
