import "package:esim_open_source/app/environment/app_environment.dart";
import "package:esim_open_source/data/remote/api_end_point.dart";
import "package:esim_open_source/data/remote/apis/device_apis/device_apis.dart";
import "package:esim_open_source/data/remote/http_methods.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../../helpers/app_enviroment_helper.dart";

/// Unit tests for DeviceApis enum
/// Tests API endpoint paths, HTTP methods, baseURL, headers, and authorization flags
void main() {
  setUpAll(() {
    // Initialize AppEnvironment for tests that require environment configuration
    AppEnvironment.isFromAppClip = false;
    AppEnvironment.appEnvironmentHelper = createTestEnvironmentHelper();
  });

  group("DeviceApis Tests", () {
    test("registerDevice has correct path", () {
      expect(DeviceApis.registerDevice.path, "/notification/api/v1/Subscriber/register");
    });

    test("registerDevice uses POST method", () {
      expect(DeviceApis.registerDevice.method, HttpMethod.POST);
    });

    test("registerDevice does not require authorization", () {
      expect(DeviceApis.registerDevice.hasAuthorization, false);
    });

    test("registerDevice is not a refresh token endpoint", () {
      expect(DeviceApis.registerDevice.isRefreshToken, false);
    });

    test("registerDevice has environment-based baseURL", () {
      final String expectedBaseURL = AppEnvironment.appEnvironmentHelper.omniConfigBaseUrl;
      expect(DeviceApis.registerDevice.baseURL, expectedBaseURL);
    });

    test("registerDevice has custom headers with LanguageCode, Tenant, and api-key", () {
      final Map<String, String> headers = DeviceApis.registerDevice.headers;
      expect(headers.containsKey("LanguageCode"), true);
      expect(headers["LanguageCode"], "en");
      expect(headers.containsKey("Tenant"), true);
      expect(headers["Tenant"], AppEnvironment.appEnvironmentHelper.omniConfigTenant);
      expect(headers.containsKey("api-key"), true);
      expect(headers["api-key"], AppEnvironment.appEnvironmentHelper.omniConfigApiKey);
    });

    test("all enum values are defined", () {
      expect(DeviceApis.values.length, 1);
      expect(DeviceApis.values, contains(DeviceApis.registerDevice));
    });

    test("all endpoints do not require authorization", () {
      for (final DeviceApis api in DeviceApis.values) {
        expect(api.hasAuthorization, false, reason: "${api.name} should not require authorization");
      }
    });

    test("no endpoint is a refresh token endpoint", () {
      for (final DeviceApis api in DeviceApis.values) {
        expect(api.isRefreshToken, false, reason: "${api.name} should not be a refresh token endpoint");
      }
    });

    test("all endpoints use POST method", () {
      for (final DeviceApis api in DeviceApis.values) {
        expect(api.method, HttpMethod.POST, reason: "${api.name} should use POST method");
      }
    });

    test("all endpoints have environment-based baseURL", () {
      final String expectedBaseURL = AppEnvironment.appEnvironmentHelper.omniConfigBaseUrl;
      for (final DeviceApis api in DeviceApis.values) {
        expect(api.baseURL, expectedBaseURL, reason: "${api.name} should have environment-based baseURL");
      }
    });

    test("all endpoints have custom headers", () {
      for (final DeviceApis api in DeviceApis.values) {
        final Map<String, String> headers = api.headers;
        expect(headers.isNotEmpty, true, reason: "${api.name} should have custom headers");
        expect(headers.length, 3, reason: "${api.name} should have exactly 3 headers");
      }
    });

    test("enum implements URlRequestBuilder", () {
      expect(DeviceApis.registerDevice, isA<URlRequestBuilder>());
    });
  });
}
