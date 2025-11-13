import "package:esim_open_source/data/services/flutter_channel_handler_service_impl.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for FlutterChannelHandlerServiceImpl
/// Tests platform channel communication for eSIM operations
///
/// Note: Tests are simplified as FlutterChannelHandlerServiceImpl
/// relies on platform channels which cannot be tested in isolation
void main() {
  group("FlutterChannelHandlerServiceImpl Tests", () {
    test("getInstance creates instance", () {
      final FlutterChannelHandlerServiceImpl instance =
          FlutterChannelHandlerServiceImpl.getInstance();

      expect(instance, isNotNull);
      expect(instance, isA<FlutterChannelHandlerServiceImpl>());
    });

    test("multiple getInstance calls return same instance", () {
      final FlutterChannelHandlerServiceImpl instance1 =
          FlutterChannelHandlerServiceImpl.getInstance();
      final FlutterChannelHandlerServiceImpl instance2 =
          FlutterChannelHandlerServiceImpl.getInstance();

      expect(instance1, same(instance2));
    });

    test("errorMessage property has default value", () {
      final FlutterChannelHandlerServiceImpl service =
          FlutterChannelHandlerServiceImpl.getInstance();

      expect(service.errorMessage, isNotEmpty);
      expect(service.errorMessage, contains("Auto eSIM installation"));
    });
  });
}
