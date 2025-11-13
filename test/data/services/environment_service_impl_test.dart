import "dart:io";

import "package:esim_open_source/data/services/environment_service_impl.dart";
import "package:esim_open_source/domain/repository/services/environment_service.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for EnvironmentServiceImpl
/// Tests singleton pattern, platform detection, and service interface implementation
void main() {
  group("EnvironmentServiceImpl Tests", () {
    test("singleton instance is created and reused", () {
      final EnvironmentServiceImpl instance1 = EnvironmentServiceImpl.instance;
      final EnvironmentServiceImpl instance2 = EnvironmentServiceImpl.instance;

      expect(instance1, same(instance2));
      expect(instance1, isNotNull);
    });

    test("instance implements EnvironmentService interface", () {
      final EnvironmentServiceImpl instance = EnvironmentServiceImpl.instance;

      expect(instance, isA<EnvironmentService>());
    });

    test("isAndroid returns correct platform value", () {
      final EnvironmentServiceImpl instance = EnvironmentServiceImpl.instance;

      expect(instance.isAndroid, Platform.isAndroid);
    });

    test("isAndroid returns true on Android platform", () {
      final EnvironmentServiceImpl instance = EnvironmentServiceImpl.instance;

      // This test will pass on Android and fail on other platforms
      // Testing the actual implementation logic
      if (Platform.isAndroid) {
        expect(instance.isAndroid, true);
      } else {
        expect(instance.isAndroid, false);
      }
    });

    test("isAndroid is consistent across multiple calls", () {
      final EnvironmentServiceImpl instance = EnvironmentServiceImpl.instance;

      final bool firstCall = instance.isAndroid;
      final bool secondCall = instance.isAndroid;
      final bool thirdCall = instance.isAndroid;

      expect(firstCall, secondCall);
      expect(secondCall, thirdCall);
    });

    test("service has no mutable state", () {
      final EnvironmentServiceImpl instance = EnvironmentServiceImpl.instance;

      // Check that the platform value doesn't change
      final bool initialValue = instance.isAndroid;

      // Call multiple times
      for (int i = 0; i < 10; i++) {
        expect(instance.isAndroid, initialValue);
      }
    });
  });
}
