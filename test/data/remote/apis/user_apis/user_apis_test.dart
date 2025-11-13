import "package:esim_open_source/data/remote/api_end_point.dart";
import "package:esim_open_source/data/remote/apis/user_apis/user_apis.dart";
import "package:esim_open_source/data/remote/http_methods.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for UserApis enum
/// Tests API endpoint paths, HTTP methods, and authorization flags
void main() {
  group("UserApis Tests", () {
    test("getUserConsumption has correct path", () {
      expect(UserApis.getUserConsumption.path, "/api/v1/user/consumption");
    });

    test("getUserConsumption uses GET method", () {
      expect(UserApis.getUserConsumption.method, HttpMethod.GET);
    });

    test("assignBundle has correct path", () {
      expect(UserApis.assignBundle.path, "/api/v1/user/bundle/assign");
    });

    test("assignBundle uses POST method", () {
      expect(UserApis.assignBundle.method, HttpMethod.POST);
    });

    test("topUpBundle has correct path", () {
      expect(UserApis.topUpBundle.path, "/api/v1/user/bundle/assign-top-up");
    });

    test("topUpBundle uses POST method", () {
      expect(UserApis.topUpBundle.method, HttpMethod.POST);
    });

    test("getUserNotifications has correct path", () {
      expect(UserApis.getUserNotifications.path, "/api/v1/user/user-notification");
    });

    test("getUserNotifications uses GET method", () {
      expect(UserApis.getUserNotifications.method, HttpMethod.GET);
    });

    test("setNotificationsRead has correct path", () {
      expect(UserApis.setNotificationsRead.path, "/api/v1/user/read-user-notification/");
    });

    test("setNotificationsRead uses POST method", () {
      expect(UserApis.setNotificationsRead.method, HttpMethod.POST);
    });

    test("getBundleExists has correct path", () {
      expect(UserApis.getBundleExists.path, "/api/v1/user/bundle-exists");
    });

    test("getBundleExists uses GET method", () {
      expect(UserApis.getBundleExists.method, HttpMethod.GET);
    });

    test("getBundleLabel has correct path", () {
      expect(UserApis.getBundleLabel.path, "/api/v1/user/bundle-label-by-iccid");
    });

    test("getBundleLabel uses POST method", () {
      expect(UserApis.getBundleLabel.method, HttpMethod.POST);
    });

    test("getMyEsims has correct path", () {
      expect(UserApis.getMyEsims.path, "/api/v1/user/my-esim");
    });

    test("getMyEsims uses GET method", () {
      expect(UserApis.getMyEsims.method, HttpMethod.GET);
    });

    test("getMyEsimByIccID has correct path", () {
      expect(UserApis.getMyEsimByIccID.path, "/api/v1/user/my-esim");
    });

    test("getMyEsimByIccID uses GET method", () {
      expect(UserApis.getMyEsimByIccID.method, HttpMethod.GET);
    });

    test("getMyEsimByOrder has correct path", () {
      expect(UserApis.getMyEsimByOrder.path, "/api/v1/user/my-esim-by-order");
    });

    test("getMyEsimByOrder uses GET method", () {
      expect(UserApis.getMyEsimByOrder.method, HttpMethod.GET);
    });

    test("getRelatedTopUp has correct path", () {
      expect(UserApis.getRelatedTopUp.path, "/api/v1/user/related-topup");
    });

    test("getRelatedTopUp uses GET method", () {
      expect(UserApis.getRelatedTopUp.method, HttpMethod.GET);
    });

    test("getOrderHistory has correct path", () {
      expect(UserApis.getOrderHistory.path, "/api/v1/user/order-history");
    });

    test("getOrderHistory uses GET method", () {
      expect(UserApis.getOrderHistory.method, HttpMethod.GET);
    });

    test("getOrderByID has correct path", () {
      expect(UserApis.getOrderByID.path, "/api/v1/user/order-history");
    });

    test("getOrderByID uses GET method", () {
      expect(UserApis.getOrderByID.method, HttpMethod.GET);
    });

    test("topUpWallet has correct path", () {
      expect(UserApis.topUpWallet.path, "/api/v1/wallet/top-up");
    });

    test("topUpWallet uses POST method", () {
      expect(UserApis.topUpWallet.method, HttpMethod.POST);
    });

    test("cancelOrder has correct path", () {
      expect(UserApis.cancelOrder.path, "/api/v1/user/order/cancel");
    });

    test("cancelOrder uses DELETE method", () {
      expect(UserApis.cancelOrder.method, HttpMethod.DELETE);
    });

    test("resendOrderOtp has correct path", () {
      expect(UserApis.resendOrderOtp.path, "/api/v1/user/bundle/resend_order_otp");
    });

    test("resendOrderOtp uses POST method", () {
      expect(UserApis.resendOrderOtp.method, HttpMethod.POST);
    });

    test("verifyOrderOtp has correct path", () {
      expect(UserApis.verifyOrderOtp.path, "/api/v1/user/bundle/verify_order_otp");
    });

    test("verifyOrderOtp uses POST method", () {
      expect(UserApis.verifyOrderOtp.method, HttpMethod.POST);
    });

    test("baseURL is empty string for all endpoints", () {
      for (final UserApis api in UserApis.values) {
        expect(api.baseURL, "");
      }
    });

    test("headers is empty map for all endpoints", () {
      for (final UserApis api in UserApis.values) {
        expect(api.headers, const <String, String>{});
      }
    });

    test("all enum values are defined", () {
      expect(UserApis.values.length, 17);
      expect(UserApis.values, contains(UserApis.getUserConsumption));
      expect(UserApis.values, contains(UserApis.assignBundle));
      expect(UserApis.values, contains(UserApis.topUpBundle));
      expect(UserApis.values, contains(UserApis.getUserNotifications));
      expect(UserApis.values, contains(UserApis.setNotificationsRead));
      expect(UserApis.values, contains(UserApis.getBundleExists));
      expect(UserApis.values, contains(UserApis.getBundleLabel));
      expect(UserApis.values, contains(UserApis.getMyEsims));
      expect(UserApis.values, contains(UserApis.getMyEsimByIccID));
      expect(UserApis.values, contains(UserApis.getMyEsimByOrder));
      expect(UserApis.values, contains(UserApis.getRelatedTopUp));
      expect(UserApis.values, contains(UserApis.getOrderHistory));
      expect(UserApis.values, contains(UserApis.getOrderByID));
      expect(UserApis.values, contains(UserApis.topUpWallet));
      expect(UserApis.values, contains(UserApis.cancelOrder));
      expect(UserApis.values, contains(UserApis.resendOrderOtp));
      expect(UserApis.values, contains(UserApis.verifyOrderOtp));
    });

    test("all endpoints require authorization", () {
      for (final UserApis api in UserApis.values) {
        expect(api.hasAuthorization, true, reason: "${api.name} should require authorization");
      }
    });

    test("no endpoint is a refresh token endpoint", () {
      for (final UserApis api in UserApis.values) {
        expect(api.isRefreshToken, false, reason: "${api.name} should not be a refresh token endpoint");
      }
    });

    test("HTTP methods are correctly assigned", () {
      final List<UserApis> getEndpoints = <UserApis>[
        UserApis.getMyEsims,
        UserApis.getMyEsimByIccID,
        UserApis.getMyEsimByOrder,
        UserApis.getRelatedTopUp,
        UserApis.getUserConsumption,
        UserApis.getUserNotifications,
        UserApis.getBundleExists,
        UserApis.getOrderHistory,
        UserApis.getOrderByID,
      ];

      final List<UserApis> postEndpoints = <UserApis>[
        UserApis.assignBundle,
        UserApis.setNotificationsRead,
        UserApis.topUpBundle,
        UserApis.getBundleLabel,
        UserApis.topUpWallet,
        UserApis.resendOrderOtp,
        UserApis.verifyOrderOtp,
      ];

      final List<UserApis> deleteEndpoints = <UserApis>[
        UserApis.cancelOrder,
      ];

      for (final UserApis api in UserApis.values) {
        if (getEndpoints.contains(api)) {
          expect(api.method, HttpMethod.GET, reason: "${api.name} should use GET method");
        } else if (postEndpoints.contains(api)) {
          expect(api.method, HttpMethod.POST, reason: "${api.name} should use POST method");
        } else if (deleteEndpoints.contains(api)) {
          expect(api.method, HttpMethod.DELETE, reason: "${api.name} should use DELETE method");
        }
      }
    });

    test("all paths start with /api/v1", () {
      for (final UserApis api in UserApis.values) {
        expect(api.path.startsWith("/api/v1"), true, reason: "${api.name} path should start with /api/v1");
      }
    });

    test("only cancelOrder uses DELETE method", () {
      for (final UserApis api in UserApis.values) {
        if (api == UserApis.cancelOrder) {
          expect(api.method, HttpMethod.DELETE);
        } else {
          expect(api.method, isNot(HttpMethod.DELETE), reason: "${api.name} should not use DELETE method");
        }
      }
    });

    test("enum implements URlRequestBuilder", () {
      expect(UserApis.getUserConsumption, isA<URlRequestBuilder>());
    });
  });
}
