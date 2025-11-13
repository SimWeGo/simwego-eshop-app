import "package:esim_open_source/data/remote/api_end_point.dart";
import "package:esim_open_source/data/remote/apis/skeleton_apis/skeleton_apis.dart";
import "package:esim_open_source/data/remote/http_methods.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for SkeletonApis enum
/// Tests API endpoint paths, HTTP methods, baseURLs, and authorization flags
void main() {
  group("SkeletonApis Tests", () {
    test("fact has correct path", () {
      expect(SkeletonApis.fact.path, "/fact");
    });

    test("fact uses GET method", () {
      expect(SkeletonApis.fact.method, HttpMethod.GET);
    });

    test("fact has correct baseURL", () {
      expect(
        SkeletonApis.fact.baseURL,
        "https://api.mockfly.dev/mocks/c6baa353-20f5-4af2-8097-3298fcf526b2",
      );
    });

    test("fact requires authorization", () {
      expect(SkeletonApis.fact.hasAuthorization, true);
    });

    test("fact is not a refresh token endpoint", () {
      expect(SkeletonApis.fact.isRefreshToken, false);
    });

    test("coins has correct path", () {
      expect(SkeletonApis.coins.path, "/api/v3/coins/markets");
    });

    test("coins uses GET method", () {
      expect(SkeletonApis.coins.method, HttpMethod.GET);
    });

    test("coins has correct baseURL", () {
      expect(
        SkeletonApis.coins.baseURL,
        "https://api.mockfly.dev/mocks/c6baa353-20f5-4af2-8097-3298fcf526b2",
      );
    });

    test("coins requires authorization", () {
      expect(SkeletonApis.coins.hasAuthorization, true);
    });

    test("coins is not a refresh token endpoint", () {
      expect(SkeletonApis.coins.isRefreshToken, false);
    });

    test("refreshToken has correct path", () {
      expect(SkeletonApis.refreshToken.path, "/refreshToken");
    });

    test("refreshToken uses POST method", () {
      expect(SkeletonApis.refreshToken.method, HttpMethod.POST);
    });

    test("refreshToken has correct baseURL", () {
      expect(
        SkeletonApis.refreshToken.baseURL,
        "https://api.mockfly.dev/mocks/c6baa353-20f5-4af2-8097-3298fcf526b2",
      );
    });

    test("refreshToken requires authorization", () {
      expect(SkeletonApis.refreshToken.hasAuthorization, true);
    });

    test("refreshToken is a refresh token endpoint", () {
      expect(SkeletonApis.refreshToken.isRefreshToken, true);
    });

    test("login has correct path", () {
      expect(SkeletonApis.login.path, "/member/api/v1/auth/login-with-url");
    });

    test("login uses POST method", () {
      expect(SkeletonApis.login.method, HttpMethod.POST);
    });

    test("login has correct baseURL", () {
      expect(
        SkeletonApis.login.baseURL,
        "https://mm-omni-api-software-qa.montylocal.net",
      );
    });

    test("login requires authorization", () {
      expect(SkeletonApis.login.hasAuthorization, true);
    });

    test("login is not a refresh token endpoint", () {
      expect(SkeletonApis.login.isRefreshToken, false);
    });

    test("headers is empty map for all endpoints", () {
      for (final SkeletonApis api in SkeletonApis.values) {
        expect(api.headers, const <String, String>{});
      }
    });

    test("all enum values are defined", () {
      expect(SkeletonApis.values.length, 4);
      expect(SkeletonApis.values, contains(SkeletonApis.fact));
      expect(SkeletonApis.values, contains(SkeletonApis.coins));
      expect(SkeletonApis.values, contains(SkeletonApis.refreshToken));
      expect(SkeletonApis.values, contains(SkeletonApis.login));
    });

    test("all endpoints require authorization", () {
      for (final SkeletonApis api in SkeletonApis.values) {
        expect(api.hasAuthorization, true, reason: "${api.name} should require authorization");
      }
    });

    test("only refreshToken is a refresh token endpoint", () {
      for (final SkeletonApis api in SkeletonApis.values) {
        if (api == SkeletonApis.refreshToken) {
          expect(api.isRefreshToken, true);
        } else {
          expect(api.isRefreshToken, false, reason: "${api.name} should not be a refresh token endpoint");
        }
      }
    });

    test("GET and POST methods are correctly assigned", () {
      expect(SkeletonApis.fact.method, HttpMethod.GET);
      expect(SkeletonApis.coins.method, HttpMethod.GET);
      expect(SkeletonApis.refreshToken.method, HttpMethod.POST);
      expect(SkeletonApis.login.method, HttpMethod.POST);
    });

    test("baseURL is correctly assigned for each endpoint", () {
      const String mockflyBaseURL = "https://api.mockfly.dev/mocks/c6baa353-20f5-4af2-8097-3298fcf526b2";
      const String montyBaseURL = "https://mm-omni-api-software-qa.montylocal.net";

      expect(SkeletonApis.fact.baseURL, mockflyBaseURL);
      expect(SkeletonApis.coins.baseURL, mockflyBaseURL);
      expect(SkeletonApis.refreshToken.baseURL, mockflyBaseURL);
      expect(SkeletonApis.login.baseURL, montyBaseURL);
    });

    test("enum implements URlRequestBuilder", () {
      expect(SkeletonApis.fact, isA<URlRequestBuilder>());
    });
  });
}
