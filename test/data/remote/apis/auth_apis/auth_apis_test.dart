import "package:esim_open_source/data/remote/api_end_point.dart";
import "package:esim_open_source/data/remote/apis/auth_apis/auth_apis.dart";
import "package:esim_open_source/data/remote/http_methods.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for AuthApis enum
/// Tests API endpoint paths, HTTP methods, and authorization flags
void main() {
  group("AuthApis Tests", () {
    test("login has correct path", () {
      expect(AuthApis.login.path, "/api/v1/auth/login");
    });

    test("login uses POST method", () {
      expect(AuthApis.login.method, HttpMethod.POST);
    });

    test("login does not require authorization", () {
      expect(AuthApis.login.hasAuthorization, false);
    });

    test("login is not a refresh token endpoint", () {
      expect(AuthApis.login.isRefreshToken, false);
    });

    test("tmpLogin has correct path", () {
      expect(AuthApis.tmpLogin.path, "/api/v1/auth/tmp-login");
    });

    test("tmpLogin uses POST method", () {
      expect(AuthApis.tmpLogin.method, HttpMethod.POST);
    });

    test("tmpLogin does not require authorization", () {
      expect(AuthApis.tmpLogin.hasAuthorization, false);
    });

    test("logout has correct path", () {
      expect(AuthApis.logout.path, "/api/v1/auth/logout");
    });

    test("logout uses POST method", () {
      expect(AuthApis.logout.method, HttpMethod.POST);
    });

    test("logout requires authorization", () {
      expect(AuthApis.logout.hasAuthorization, true);
    });

    test("logout is not a refresh token endpoint", () {
      expect(AuthApis.logout.isRefreshToken, false);
    });

    test("resendOtp has correct path", () {
      expect(AuthApis.resendOtp.path, "/api/v1/auth/login");
    });

    test("resendOtp uses POST method", () {
      expect(AuthApis.resendOtp.method, HttpMethod.POST);
    });

    test("resendOtp does not require authorization", () {
      expect(AuthApis.resendOtp.hasAuthorization, false);
    });

    test("verifyOtp has correct path", () {
      expect(AuthApis.verifyOtp.path, "/api/v1/auth/verify_otp");
    });

    test("verifyOtp uses POST method", () {
      expect(AuthApis.verifyOtp.method, HttpMethod.POST);
    });

    test("verifyOtp does not require authorization", () {
      expect(AuthApis.verifyOtp.hasAuthorization, false);
    });

    test("refreshToken has correct path", () {
      expect(AuthApis.refreshToken.path, "/api/v1/auth/refresh-token");
    });

    test("refreshToken uses POST method", () {
      expect(AuthApis.refreshToken.method, HttpMethod.POST);
    });

    test("refreshToken does not require authorization", () {
      expect(AuthApis.refreshToken.hasAuthorization, false);
    });

    test("refreshToken is a refresh token endpoint", () {
      expect(AuthApis.refreshToken.isRefreshToken, true);
    });

    test("deleteAccount has correct path", () {
      expect(AuthApis.deleteAccount.path, "/api/v1/auth/delete-account");
    });

    test("deleteAccount uses DELETE method", () {
      expect(AuthApis.deleteAccount.method, HttpMethod.DELETE);
    });

    test("deleteAccount requires authorization", () {
      expect(AuthApis.deleteAccount.hasAuthorization, true);
    });

    test("deleteAccount is not a refresh token endpoint", () {
      expect(AuthApis.deleteAccount.isRefreshToken, false);
    });

    test("userInfo has correct path", () {
      expect(AuthApis.userInfo.path, "/api/v1/auth/user-info");
    });

    test("userInfo uses GET method", () {
      expect(AuthApis.userInfo.method, HttpMethod.GET);
    });

    test("userInfo requires authorization", () {
      expect(AuthApis.userInfo.hasAuthorization, true);
    });

    test("userInfo is not a refresh token endpoint", () {
      expect(AuthApis.userInfo.isRefreshToken, false);
    });

    test("updateUserInfo has correct path", () {
      expect(AuthApis.updateUserInfo.path, "/api/v1/auth/user-info");
    });

    test("updateUserInfo uses POST method", () {
      expect(AuthApis.updateUserInfo.method, HttpMethod.POST);
    });

    test("updateUserInfo requires authorization", () {
      expect(AuthApis.updateUserInfo.hasAuthorization, true);
    });

    test("updateUserInfo is not a refresh token endpoint", () {
      expect(AuthApis.updateUserInfo.isRefreshToken, false);
    });

    test("baseURL is empty string for all endpoints", () {
      for (final AuthApis api in AuthApis.values) {
        expect(api.baseURL, "");
      }
    });

    test("headers is empty map for all endpoints", () {
      for (final AuthApis api in AuthApis.values) {
        expect(api.headers, const <String, String>{});
      }
    });

    test("all enum values are defined", () {
      expect(AuthApis.values.length, 9);
      expect(AuthApis.values, contains(AuthApis.login));
      expect(AuthApis.values, contains(AuthApis.tmpLogin));
      expect(AuthApis.values, contains(AuthApis.logout));
      expect(AuthApis.values, contains(AuthApis.resendOtp));
      expect(AuthApis.values, contains(AuthApis.verifyOtp));
      expect(AuthApis.values, contains(AuthApis.refreshToken));
      expect(AuthApis.values, contains(AuthApis.deleteAccount));
      expect(AuthApis.values, contains(AuthApis.userInfo));
      expect(AuthApis.values, contains(AuthApis.updateUserInfo));
    });

    test("only authorized endpoints require authorization", () {
      final List<AuthApis> authorizedEndpoints = <AuthApis>[
        AuthApis.logout,
        AuthApis.deleteAccount,
        AuthApis.updateUserInfo,
        AuthApis.userInfo,
      ];

      for (final AuthApis api in AuthApis.values) {
        if (authorizedEndpoints.contains(api)) {
          expect(api.hasAuthorization, true, reason: "${api.name} should require authorization");
        } else {
          expect(api.hasAuthorization, false, reason: "${api.name} should not require authorization");
        }
      }
    });

    test("only refreshToken is a refresh token endpoint", () {
      for (final AuthApis api in AuthApis.values) {
        if (api == AuthApis.refreshToken) {
          expect(api.isRefreshToken, true);
        } else {
          expect(api.isRefreshToken, false, reason: "${api.name} should not be a refresh token endpoint");
        }
      }
    });

    test("only deleteAccount uses DELETE method", () {
      for (final AuthApis api in AuthApis.values) {
        if (api == AuthApis.deleteAccount) {
          expect(api.method, HttpMethod.DELETE);
        } else if (api == AuthApis.userInfo) {
          expect(api.method, HttpMethod.GET);
        } else {
          expect(api.method, HttpMethod.POST);
        }
      }
    });

    test("all paths start with /api/v1/auth", () {
      for (final AuthApis api in AuthApis.values) {
        expect(api.path.startsWith("/api/v1/auth"), true, reason: "${api.name} path should start with /api/v1/auth");
      }
    });

    test("enum implements URlRequestBuilder", () {
      expect(AuthApis.login, isA<URlRequestBuilder>());
    });
  });
}
