import "package:esim_open_source/data/remote/api_end_point.dart";
import "package:esim_open_source/data/remote/apis/app_apis/app_apis.dart";
import "package:esim_open_source/data/remote/http_methods.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for AppApis enum
/// Tests API endpoint paths, HTTP methods, and authorization flags
void main() {
  group("AppApis Tests", () {
    test("addDevice has correct path", () {
      expect(AppApis.addDevice.path, "/api/v1/app/device");
    });

    test("addDevice uses POST method", () {
      expect(AppApis.addDevice.method, HttpMethod.POST);
    });

    test("addDevice requires authorization", () {
      expect(AppApis.addDevice.hasAuthorization, true);
    });

    test("addDevice is not a refresh token endpoint", () {
      expect(AppApis.addDevice.isRefreshToken, false);
    });

    test("aboutUS has correct path", () {
      expect(AppApis.aboutUS.path, "/api/v1/app/about_us");
    });

    test("aboutUS uses GET method", () {
      expect(AppApis.aboutUS.method, HttpMethod.GET);
    });

    test("aboutUS does not require authorization", () {
      expect(AppApis.aboutUS.hasAuthorization, false);
    });

    test("aboutUS is not a refresh token endpoint", () {
      expect(AppApis.aboutUS.isRefreshToken, false);
    });

    test("termsConditions has correct path", () {
      expect(AppApis.termsConditions.path, "/api/v1/app/terms-and-conditions");
    });

    test("termsConditions uses GET method", () {
      expect(AppApis.termsConditions.method, HttpMethod.GET);
    });

    test("termsConditions does not require authorization", () {
      expect(AppApis.termsConditions.hasAuthorization, false);
    });

    test("termsConditions is not a refresh token endpoint", () {
      expect(AppApis.termsConditions.isRefreshToken, false);
    });

    test("faq has correct path", () {
      expect(AppApis.faq.path, "/api/v1/app/faq");
    });

    test("faq uses GET method", () {
      expect(AppApis.faq.method, HttpMethod.GET);
    });

    test("faq requires authorization", () {
      expect(AppApis.faq.hasAuthorization, true);
    });

    test("faq is not a refresh token endpoint", () {
      expect(AppApis.faq.isRefreshToken, false);
    });

    test("contactUs has correct path", () {
      expect(AppApis.contactUs.path, "/api/v1/app/contact");
    });

    test("contactUs uses POST method", () {
      expect(AppApis.contactUs.method, HttpMethod.POST);
    });

    test("contactUs requires authorization", () {
      expect(AppApis.contactUs.hasAuthorization, true);
    });

    test("contactUs is not a refresh token endpoint", () {
      expect(AppApis.contactUs.isRefreshToken, false);
    });

    test("configurations has correct path", () {
      expect(AppApis.configurations.path, "/api/v1/app/configurations");
    });

    test("configurations uses GET method", () {
      expect(AppApis.configurations.method, HttpMethod.GET);
    });

    test("configurations does not require authorization", () {
      expect(AppApis.configurations.hasAuthorization, false);
    });

    test("configurations is not a refresh token endpoint", () {
      expect(AppApis.configurations.isRefreshToken, false);
    });

    test("getCurrencies has correct path", () {
      expect(AppApis.getCurrencies.path, "/api/v1/app/currency");
    });

    test("getCurrencies uses GET method", () {
      expect(AppApis.getCurrencies.method, HttpMethod.GET);
    });

    test("getCurrencies does not require authorization", () {
      expect(AppApis.getCurrencies.hasAuthorization, false);
    });

    test("getCurrencies is not a refresh token endpoint", () {
      expect(AppApis.getCurrencies.isRefreshToken, false);
    });

    test("getBanner has correct path", () {
      expect(AppApis.getBanner.path, "/api/v1/app/banners");
    });

    test("getBanner uses GET method", () {
      expect(AppApis.getBanner.method, HttpMethod.GET);
    });

    test("getBanner does not require authorization", () {
      expect(AppApis.getBanner.hasAuthorization, false);
    });

    test("getBanner is not a refresh token endpoint", () {
      expect(AppApis.getBanner.isRefreshToken, false);
    });

    test("baseURL is empty string for all endpoints", () {
      for (final AppApis api in AppApis.values) {
        expect(api.baseURL, "");
      }
    });

    test("headers is empty map for all endpoints", () {
      for (final AppApis api in AppApis.values) {
        expect(api.headers, const <String, String>{});
      }
    });

    test("all enum values are defined", () {
      expect(AppApis.values.length, 8);
      expect(AppApis.values, contains(AppApis.addDevice));
      expect(AppApis.values, contains(AppApis.aboutUS));
      expect(AppApis.values, contains(AppApis.termsConditions));
      expect(AppApis.values, contains(AppApis.faq));
      expect(AppApis.values, contains(AppApis.contactUs));
      expect(AppApis.values, contains(AppApis.configurations));
      expect(AppApis.values, contains(AppApis.getCurrencies));
      expect(AppApis.values, contains(AppApis.getBanner));
    });

    test("no endpoint is a refresh token endpoint", () {
      for (final AppApis api in AppApis.values) {
        expect(api.isRefreshToken, false, reason: "${api.name} should not be a refresh token endpoint");
      }
    });

    test("HTTP methods are correctly assigned", () {
      final List<AppApis> postEndpoints = <AppApis>[
        AppApis.addDevice,
        AppApis.contactUs,
      ];

      final List<AppApis> getEndpoints = <AppApis>[
        AppApis.faq,
        AppApis.aboutUS,
        AppApis.termsConditions,
        AppApis.configurations,
        AppApis.getCurrencies,
        AppApis.getBanner,
      ];

      for (final AppApis api in AppApis.values) {
        if (postEndpoints.contains(api)) {
          expect(api.method, HttpMethod.POST, reason: "${api.name} should use POST method");
        } else if (getEndpoints.contains(api)) {
          expect(api.method, HttpMethod.GET, reason: "${api.name} should use GET method");
        }
      }
    });

    test("only authorized endpoints require authorization", () {
      final List<AppApis> authorizedEndpoints = <AppApis>[
        AppApis.addDevice,
        AppApis.faq,
        AppApis.contactUs,
      ];

      for (final AppApis api in AppApis.values) {
        if (authorizedEndpoints.contains(api)) {
          expect(api.hasAuthorization, true, reason: "${api.name} should require authorization");
        } else {
          expect(api.hasAuthorization, false, reason: "${api.name} should not require authorization");
        }
      }
    });

    test("all paths start with /api/v1/app", () {
      for (final AppApis api in AppApis.values) {
        expect(api.path.startsWith("/api/v1/app"), true, reason: "${api.name} path should start with /api/v1/app");
      }
    });

    test("enum implements URlRequestBuilder", () {
      expect(AppApis.addDevice, isA<URlRequestBuilder>());
    });
  });
}
