import "package:flutter/services.dart";
import "package:flutter_test/flutter_test.dart";

class SharePlusHelper {
  static const MethodChannel channel =
      MethodChannel("dev.fluttercommunity.plus/share");

  static void implementSharePlus() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return null;
    });
  }

  static void deInitSharePlus() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  }
}
