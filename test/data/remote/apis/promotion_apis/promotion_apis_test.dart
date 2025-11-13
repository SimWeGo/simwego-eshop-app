import "package:esim_open_source/data/remote/api_end_point.dart";
import "package:esim_open_source/data/remote/apis/promotion_apis/promotion_apis.dart";
import "package:esim_open_source/data/remote/http_methods.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for PromotionApis enum
/// Tests API endpoint paths, HTTP methods, and authorization flags
void main() {
  group("PromotionApis Tests", () {
    test("redeemVoucher has correct path", () {
      expect(PromotionApis.redeemVoucher.path, "/api/v1/voucher/redeem");
    });

    test("redeemVoucher uses POST method", () {
      expect(PromotionApis.redeemVoucher.method, HttpMethod.POST);
    });

    test("redeemVoucher requires authorization", () {
      expect(PromotionApis.redeemVoucher.hasAuthorization, true);
    });

    test("redeemVoucher is not a refresh token endpoint", () {
      expect(PromotionApis.redeemVoucher.isRefreshToken, false);
    });

    test("applyReferralCode has correct path", () {
      expect(PromotionApis.applyReferralCode.path, "/api/v1/promotion/referral_code");
    });

    test("applyReferralCode uses POST method", () {
      expect(PromotionApis.applyReferralCode.method, HttpMethod.POST);
    });

    test("applyReferralCode requires authorization", () {
      expect(PromotionApis.applyReferralCode.hasAuthorization, true);
    });

    test("applyReferralCode is not a refresh token endpoint", () {
      expect(PromotionApis.applyReferralCode.isRefreshToken, false);
    });

    test("validatePromoCode has correct path", () {
      expect(PromotionApis.validatePromoCode.path, "/api/v1/promotion/validation");
    });

    test("validatePromoCode uses POST method", () {
      expect(PromotionApis.validatePromoCode.method, HttpMethod.POST);
    });

    test("validatePromoCode requires authorization", () {
      expect(PromotionApis.validatePromoCode.hasAuthorization, true);
    });

    test("validatePromoCode is not a refresh token endpoint", () {
      expect(PromotionApis.validatePromoCode.isRefreshToken, false);
    });

    test("getRewardsHistory has correct path", () {
      expect(PromotionApis.getRewardsHistory.path, "/api/v1/promotion/history");
    });

    test("getRewardsHistory uses GET method", () {
      expect(PromotionApis.getRewardsHistory.method, HttpMethod.GET);
    });

    test("getRewardsHistory requires authorization", () {
      expect(PromotionApis.getRewardsHistory.hasAuthorization, true);
    });

    test("getRewardsHistory is not a refresh token endpoint", () {
      expect(PromotionApis.getRewardsHistory.isRefreshToken, false);
    });

    test("getReferralInfo has correct path", () {
      expect(PromotionApis.getReferralInfo.path, "/api/v1/promotion/referral-info");
    });

    test("getReferralInfo uses GET method", () {
      expect(PromotionApis.getReferralInfo.method, HttpMethod.GET);
    });

    test("getReferralInfo requires authorization", () {
      expect(PromotionApis.getReferralInfo.hasAuthorization, true);
    });

    test("getReferralInfo is not a refresh token endpoint", () {
      expect(PromotionApis.getReferralInfo.isRefreshToken, false);
    });

    test("baseURL is empty string for all endpoints", () {
      for (final PromotionApis api in PromotionApis.values) {
        expect(api.baseURL, "");
      }
    });

    test("headers is empty map for all endpoints", () {
      for (final PromotionApis api in PromotionApis.values) {
        expect(api.headers, const <String, String>{});
      }
    });

    test("all enum values are defined", () {
      expect(PromotionApis.values.length, 5);
      expect(PromotionApis.values, contains(PromotionApis.redeemVoucher));
      expect(PromotionApis.values, contains(PromotionApis.applyReferralCode));
      expect(PromotionApis.values, contains(PromotionApis.validatePromoCode));
      expect(PromotionApis.values, contains(PromotionApis.getRewardsHistory));
      expect(PromotionApis.values, contains(PromotionApis.getReferralInfo));
    });

    test("all endpoints require authorization", () {
      for (final PromotionApis api in PromotionApis.values) {
        expect(api.hasAuthorization, true, reason: "${api.name} should require authorization");
      }
    });

    test("no endpoint is a refresh token endpoint", () {
      for (final PromotionApis api in PromotionApis.values) {
        expect(api.isRefreshToken, false, reason: "${api.name} should not be a refresh token endpoint");
      }
    });

    test("HTTP methods are correctly assigned", () {
      final List<PromotionApis> postEndpoints = <PromotionApis>[
        PromotionApis.redeemVoucher,
        PromotionApis.applyReferralCode,
        PromotionApis.validatePromoCode,
      ];

      final List<PromotionApis> getEndpoints = <PromotionApis>[
        PromotionApis.getRewardsHistory,
        PromotionApis.getReferralInfo,
      ];

      for (final PromotionApis api in PromotionApis.values) {
        if (postEndpoints.contains(api)) {
          expect(api.method, HttpMethod.POST, reason: "${api.name} should use POST method");
        } else if (getEndpoints.contains(api)) {
          expect(api.method, HttpMethod.GET, reason: "${api.name} should use GET method");
        }
      }
    });

    test("all paths start with /api/v1", () {
      for (final PromotionApis api in PromotionApis.values) {
        expect(api.path.startsWith("/api/v1"), true, reason: "${api.name} path should start with /api/v1");
      }
    });

    test("enum implements URlRequestBuilder", () {
      expect(PromotionApis.redeemVoucher, isA<URlRequestBuilder>());
    });
  });
}
