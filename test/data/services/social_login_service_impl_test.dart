import "package:esim_open_source/data/services/social_login_service_impl.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for SocialLoginServiceImpl
/// Tests social login service functionality
///
/// Note: Tests are simplified as SocialLoginServiceImpl
/// relies on third-party auth packages which cannot be tested in isolation
void main() {
  group("SocialLoginServiceImpl Tests", () {
    test("singleton instance is created", () {
      final SocialLoginServiceImpl instance = SocialLoginServiceImpl.instance;

      expect(instance, isNotNull);
      expect(instance, isA<SocialLoginServiceImpl>());
    });

    test("multiple calls return same singleton instance", () {
      final SocialLoginServiceImpl instance1 = SocialLoginServiceImpl.instance;
      final SocialLoginServiceImpl instance2 = SocialLoginServiceImpl.instance;

      expect(instance1, same(instance2));
    });

    test("socialLoginResultStream is accessible", () {
      final SocialLoginServiceImpl service = SocialLoginServiceImpl.instance;

      expect(service.socialLoginResultStream, isNotNull);
      expect(service.socialLoginResultStream, isA<Stream<dynamic>>());
    });

    test("onDispose can be called", () async {
      final SocialLoginServiceImpl service = SocialLoginServiceImpl.instance;

      // Should not throw
      await service.onDispose();

      expect(service, isNotNull);
    });
  });
}
