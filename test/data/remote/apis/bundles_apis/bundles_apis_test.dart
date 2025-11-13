import "package:esim_open_source/data/remote/api_end_point.dart";
import "package:esim_open_source/data/remote/apis/bundles_apis/bundles_apis.dart";
import "package:esim_open_source/data/remote/http_methods.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for BundlesApis enum
/// Tests API endpoint paths, HTTP methods, and authorization flags
void main() {
  group("BundlesApis Tests", () {
    test("getAllData has correct path", () {
      expect(BundlesApis.getAllData.path, "/api/v1/home/");
    });

    test("getAllData uses GET method", () {
      expect(BundlesApis.getAllData.method, HttpMethod.GET);
    });

    test("getAllData requires authorization", () {
      expect(BundlesApis.getAllData.hasAuthorization, true);
    });

    test("getAllData is not a refresh token endpoint", () {
      expect(BundlesApis.getAllData.isRefreshToken, false);
    });

    test("getBundle has correct path", () {
      expect(BundlesApis.getBundle.path, "/api/v1/bundles");
    });

    test("getBundle uses GET method", () {
      expect(BundlesApis.getBundle.method, HttpMethod.GET);
    });

    test("getBundle requires authorization", () {
      expect(BundlesApis.getBundle.hasAuthorization, true);
    });

    test("getBundle is not a refresh token endpoint", () {
      expect(BundlesApis.getBundle.isRefreshToken, false);
    });

    test("getBundles has correct path", () {
      expect(BundlesApis.getBundles.path, "/api/v1/bundles");
    });

    test("getBundles uses GET method", () {
      expect(BundlesApis.getBundles.method, HttpMethod.GET);
    });

    test("getBundles requires authorization", () {
      expect(BundlesApis.getBundles.hasAuthorization, true);
    });

    test("getBundles is not a refresh token endpoint", () {
      expect(BundlesApis.getBundles.isRefreshToken, false);
    });

    test("getBundlesByRegion has correct path", () {
      expect(BundlesApis.getBundlesByRegion.path, "/api/v1/bundles/by-region");
    });

    test("getBundlesByRegion uses GET method", () {
      expect(BundlesApis.getBundlesByRegion.method, HttpMethod.GET);
    });

    test("getBundlesByRegion requires authorization", () {
      expect(BundlesApis.getBundlesByRegion.hasAuthorization, true);
    });

    test("getBundlesByRegion is not a refresh token endpoint", () {
      expect(BundlesApis.getBundlesByRegion.isRefreshToken, false);
    });

    test("getBundleConsumption has correct path", () {
      expect(BundlesApis.getBundleConsumption.path, "/api/v1/bundles/consumption");
    });

    test("getBundleConsumption uses GET method", () {
      expect(BundlesApis.getBundleConsumption.method, HttpMethod.GET);
    });

    test("getBundleConsumption requires authorization", () {
      expect(BundlesApis.getBundleConsumption.hasAuthorization, true);
    });

    test("getBundleConsumption is not a refresh token endpoint", () {
      expect(BundlesApis.getBundleConsumption.isRefreshToken, false);
    });

    test("getBundlesByCountries has correct path", () {
      expect(BundlesApis.getBundlesByCountries.path, "/api/v1/bundles/by-country");
    });

    test("getBundlesByCountries uses GET method", () {
      expect(BundlesApis.getBundlesByCountries.method, HttpMethod.GET);
    });

    test("getBundlesByCountries requires authorization", () {
      expect(BundlesApis.getBundlesByCountries.hasAuthorization, true);
    });

    test("getBundlesByCountries is not a refresh token endpoint", () {
      expect(BundlesApis.getBundlesByCountries.isRefreshToken, false);
    });

    test("baseURL is empty string for all endpoints", () {
      for (final BundlesApis api in BundlesApis.values) {
        expect(api.baseURL, "");
      }
    });

    test("headers is empty map for all endpoints", () {
      for (final BundlesApis api in BundlesApis.values) {
        expect(api.headers, const <String, String>{});
      }
    });

    test("all enum values are defined", () {
      expect(BundlesApis.values.length, 6);
      expect(BundlesApis.values, contains(BundlesApis.getAllData));
      expect(BundlesApis.values, contains(BundlesApis.getBundle));
      expect(BundlesApis.values, contains(BundlesApis.getBundles));
      expect(BundlesApis.values, contains(BundlesApis.getBundlesByRegion));
      expect(BundlesApis.values, contains(BundlesApis.getBundleConsumption));
      expect(BundlesApis.values, contains(BundlesApis.getBundlesByCountries));
    });

    test("all endpoints require authorization", () {
      for (final BundlesApis api in BundlesApis.values) {
        expect(api.hasAuthorization, true, reason: "${api.name} should require authorization");
      }
    });

    test("no endpoint is a refresh token endpoint", () {
      for (final BundlesApis api in BundlesApis.values) {
        expect(api.isRefreshToken, false, reason: "${api.name} should not be a refresh token endpoint");
      }
    });

    test("all endpoints use GET method", () {
      for (final BundlesApis api in BundlesApis.values) {
        expect(api.method, HttpMethod.GET, reason: "${api.name} should use GET method");
      }
    });

    test("all paths start with /api/v1", () {
      for (final BundlesApis api in BundlesApis.values) {
        expect(api.path.startsWith("/api/v1"), true, reason: "${api.name} path should start with /api/v1");
      }
    });

    test("enum implements URlRequestBuilder", () {
      expect(BundlesApis.getAllData, isA<URlRequestBuilder>());
    });
  });
}
