import "package:esim_open_source/data/remote/api_end_point.dart";
import "package:esim_open_source/data/remote/apis/notifications/notifications_apis.dart";
import "package:esim_open_source/data/remote/http_methods.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for NotificationsApis enum
/// Tests API endpoint paths, HTTP methods, and authorization flags
void main() {
  group("NotificationsApis Tests", () {
    test("consumptionLimit has correct path", () {
      expect(NotificationsApis.consumptionLimit.path, "/api/v1/notifications/consumption-limit");
    });

    test("consumptionLimit uses POST method", () {
      expect(NotificationsApis.consumptionLimit.method, HttpMethod.POST);
    });

    test("consumptionLimit requires authorization", () {
      expect(NotificationsApis.consumptionLimit.hasAuthorization, true);
    });

    test("consumptionLimit is not a refresh token endpoint", () {
      expect(NotificationsApis.consumptionLimit.isRefreshToken, false);
    });

    test("baseURL is empty string for all endpoints", () {
      for (final NotificationsApis api in NotificationsApis.values) {
        expect(api.baseURL, "");
      }
    });

    test("headers is empty map for all endpoints", () {
      for (final NotificationsApis api in NotificationsApis.values) {
        expect(api.headers, const <String, String>{});
      }
    });

    test("all enum values are defined", () {
      expect(NotificationsApis.values.length, 1);
      expect(NotificationsApis.values, contains(NotificationsApis.consumptionLimit));
    });

    test("all endpoints require authorization", () {
      for (final NotificationsApis api in NotificationsApis.values) {
        expect(api.hasAuthorization, true, reason: "${api.name} should require authorization");
      }
    });

    test("no endpoint is a refresh token endpoint", () {
      for (final NotificationsApis api in NotificationsApis.values) {
        expect(api.isRefreshToken, false, reason: "${api.name} should not be a refresh token endpoint");
      }
    });

    test("all endpoints use POST method", () {
      for (final NotificationsApis api in NotificationsApis.values) {
        expect(api.method, HttpMethod.POST, reason: "${api.name} should use POST method");
      }
    });

    test("all paths start with /api/v1/notifications", () {
      for (final NotificationsApis api in NotificationsApis.values) {
        expect(api.path.startsWith("/api/v1/notifications"), true, reason: "${api.name} path should start with /api/v1/notifications");
      }
    });

    test("enum implements URlRequestBuilder", () {
      expect(NotificationsApis.consumptionLimit, isA<URlRequestBuilder>());
    });
  });
}
