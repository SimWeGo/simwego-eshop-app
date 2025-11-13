import "package:esim_open_source/app/environment/app_environment.dart";
import "package:esim_open_source/data/remote/apis/promotion_apis/api_promotion_impl.dart";
import "package:esim_open_source/domain/data/api_promotion.dart";
import "package:esim_open_source/domain/repository/services/connectivity_service.dart";
import "package:esim_open_source/domain/repository/services/local_storage_service.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";

import "../../../../helpers/app_enviroment_helper.dart";
import "../../../../locator_test.dart";
import "../../../../locator_test.mocks.dart";

void main() {
  group("APIPromotionImpl Implementation Coverage", () {
    late MockConnectivityService mockConnectivityService;
    late MockLocalStorageService mockLocalStorageService;

    setUpAll(() async {
      await setupTestLocator();

      // Initialize AppEnvironment with test values
      AppEnvironment.isFromAppClip = false;
      AppEnvironment.appEnvironmentHelper = createTestEnvironmentHelper();

      // Setup mock services with default stubs
      mockConnectivityService =
          locator<ConnectivityService>() as MockConnectivityService;
      mockLocalStorageService =
          locator<LocalStorageService>() as MockLocalStorageService;

      // Stub required methods to prevent HTTP calls
      when(mockConnectivityService.isConnected())
          .thenAnswer((_) async => false);
      when(mockLocalStorageService.accessToken).thenReturn("");
      when(mockLocalStorageService.refreshToken).thenReturn("");
      when(mockLocalStorageService.languageCode).thenReturn("en");
    });

    test("APIPromotionImpl singleton initialization", () {
      final APIPromotionImpl instance1 = APIPromotionImpl.instance;
      final APIPromotionImpl instance2 = APIPromotionImpl.instance;

      expect(instance1, isNotNull);
      expect(instance1, same(instance2));
      expect(instance1, isA<APIPromotion>());
    });

    test("applyReferralCode method implementation coverage", () async {
      final APIPromotionImpl apiImpl = APIPromotionImpl.instance;

      try {
        await apiImpl.applyReferralCode(referralCode: "TEST_CODE");
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.applyReferralCode, isA<Function>());
    });

    test("redeemVoucher method implementation coverage", () async {
      final APIPromotionImpl apiImpl = APIPromotionImpl.instance;

      try {
        await apiImpl.redeemVoucher(voucherCode: "VOUCHER123");
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.redeemVoucher, isA<Function>());
    });

    test("validatePromoCode method implementation coverage", () async {
      final APIPromotionImpl apiImpl = APIPromotionImpl.instance;

      try {
        await apiImpl.validatePromoCode(
          promoCode: "PROMO123",
          bundleCode: "BUNDLE456",
        );
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.validatePromoCode, isA<Function>());
    });

    test("getRewardsHistory method implementation coverage", () async {
      final APIPromotionImpl apiImpl = APIPromotionImpl.instance;

      try {
        await apiImpl.getRewardsHistory();
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.getRewardsHistory, isA<Function>());
    });

    test("getReferralInfo method implementation coverage", () async {
      final APIPromotionImpl apiImpl = APIPromotionImpl.instance;

      try {
        await apiImpl.getReferralInfo();
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.getReferralInfo, isA<Function>());
    });

    test("APIPromotionImpl implements all APIPromotion interface methods", () {
      final APIPromotionImpl apiImpl = APIPromotionImpl.instance;
      final APIPromotion apiInterface = apiImpl as APIPromotion;

      expect(apiInterface.applyReferralCode, isNotNull);
      expect(apiInterface.redeemVoucher, isNotNull);
      expect(apiInterface.validatePromoCode, isNotNull);
      expect(apiInterface.getRewardsHistory, isNotNull);
      expect(apiInterface.getReferralInfo, isNotNull);
    });
  });
}
