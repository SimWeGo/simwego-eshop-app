// api_promotion_repository_impl_test.dart

import "dart:async";

import "package:esim_open_source/data/remote/responses/base_response_model.dart";
import "package:esim_open_source/data/remote/responses/bundles/bundle_response_model.dart";
import "package:esim_open_source/data/remote/responses/empty_response.dart";
import "package:esim_open_source/data/remote/responses/promotion/referral_info_response_model.dart";
import "package:esim_open_source/data/remote/responses/promotion/reward_history_response_model.dart";
import "package:esim_open_source/data/repository/api_promotion_repository_impl.dart";
import "package:esim_open_source/domain/repository/api_promotion_repository.dart";
import "package:esim_open_source/domain/util/resource.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";

import "../../locator_test.mocks.dart";

/// Unit tests for ApiPromotionRepositoryImpl
/// Tests promotion, referral, voucher, and rewards functionality
void main() {
  late ApiPromotionRepository repository;
  late MockAPIPromotion mockApiPromotion;

  setUp(() {
    mockApiPromotion = MockAPIPromotion();
    repository = ApiPromotionRepositoryImpl(apiPromotion: mockApiPromotion);
  });

  group("ApiPromotionRepositoryImpl", () {
    group("validatePromoCode", () {
      const String testPromoCode = "SUMMER2024";
      const String testBundleCode = "EUROPE_5GB";

      test("should return success resource when promo code is valid", () async {
        // Arrange
        final BundleResponseModel expectedBundle = BundleResponseModel(
          bundleCode: testBundleCode,
          displayTitle: "Europe 5GB Plan",
          price: 24.99, // Discounted price
          currencyCode: "USD",
        );

        final ResponseMain<BundleResponseModel> responseMain =
            ResponseMain<BundleResponseModel>.createErrorWithData(
          data: expectedBundle,
          message: "Promo code applied successfully",
          statusCode: 200,
        );

        when(
          mockApiPromotion.validatePromoCode(
            promoCode: testPromoCode,
            bundleCode: testBundleCode,
          ),
        ).thenAnswer((_) async => responseMain);

        // Act
        final Resource<BundleResponseModel?> result =
            await repository.validatePromoCode(
          promoCode: testPromoCode,
          bundleCode: testBundleCode,
        ) as Resource<BundleResponseModel?>;

        // Assert
        expect(result.resourceType, ResourceType.success);
        expect(result.data, expectedBundle);
        expect(result.message, "Promo code applied successfully");
        expect(result.error, isNull);

        verify(
          mockApiPromotion.validatePromoCode(
            promoCode: testPromoCode,
            bundleCode: testBundleCode,
          ),
        ).called(1);
      });

      test("should return error resource when promo code is invalid", () async {
        // Arrange
        final ResponseMain<BundleResponseModel> responseMain =
            ResponseMain<BundleResponseModel>.createErrorWithData(
          statusCode: 400,
          developerMessage: "Invalid promo code",
          title: "Invalid promo code",
        );

        when(
          mockApiPromotion.validatePromoCode(
            promoCode: testPromoCode,
            bundleCode: testBundleCode,
          ),
        ).thenAnswer((_) async => responseMain);

        // Act
        final Resource<BundleResponseModel?> result =
            await repository.validatePromoCode(
          promoCode: testPromoCode,
          bundleCode: testBundleCode,
        ) as Resource<BundleResponseModel?>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        expect(result.message, "Invalid promo code");
        expect(result.data, isNull);
        expect(result.error, isNotNull);
      });

      test("should return error when promo code is expired", () async {
        // Arrange
        final ResponseMain<BundleResponseModel> responseMain =
            ResponseMain<BundleResponseModel>.createErrorWithData(
          statusCode: 400,
          developerMessage: "Promo code has expired",
          title: "Promo code has expired",
        );

        when(
          mockApiPromotion.validatePromoCode(
            promoCode: testPromoCode,
            bundleCode: testBundleCode,
          ),
        ).thenAnswer((_) async => responseMain);

        // Act
        final Resource<BundleResponseModel?> result =
            await repository.validatePromoCode(
          promoCode: testPromoCode,
          bundleCode: testBundleCode,
        ) as Resource<BundleResponseModel?>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        expect(result.message, "Promo code has expired");
      });

      test("should handle empty promo code", () async {
        // Arrange
        const String emptyPromoCode = "";

        final ResponseMain<BundleResponseModel> responseMain =
            ResponseMain<BundleResponseModel>.createErrorWithData(
          statusCode: 400,
          developerMessage: "Promo code is required",
          title: "Promo code is required",
        );

        when(
          mockApiPromotion.validatePromoCode(
            promoCode: emptyPromoCode,
            bundleCode: testBundleCode,
          ),
        ).thenAnswer((_) async => responseMain);

        // Act
        final Resource<BundleResponseModel?> result =
            await repository.validatePromoCode(
          promoCode: emptyPromoCode,
          bundleCode: testBundleCode,
        ) as Resource<BundleResponseModel?>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        verify(
          mockApiPromotion.validatePromoCode(
            promoCode: emptyPromoCode,
            bundleCode: testBundleCode,
          ),
        ).called(1);
      });
    });

    group("applyReferralCode", () {
      const String testReferralCode = "FRIEND123";

      test("should return success resource when referral code is applied",
          () async {
        // Arrange
        final EmptyResponse expectedResponse = EmptyResponse();

        final ResponseMain<EmptyResponse> responseMain =
            ResponseMain<EmptyResponse>.createErrorWithData(
          data: expectedResponse,
          message: "Referral code applied successfully",
          statusCode: 200,
        );

        when(
          mockApiPromotion.applyReferralCode(referralCode: testReferralCode),
        ).thenAnswer((_) async => responseMain);

        // Act
        final Resource<EmptyResponse?> result =
            await repository.applyReferralCode(
          referralCode: testReferralCode,
        ) as Resource<EmptyResponse?>;

        // Assert
        expect(result.resourceType, ResourceType.success);
        expect(result.data, expectedResponse);
        expect(result.message, "Referral code applied successfully");

        verify(
          mockApiPromotion.applyReferralCode(referralCode: testReferralCode),
        ).called(1);
      });

      test("should return error resource when referral code is invalid",
          () async {
        // Arrange
        final ResponseMain<EmptyResponse> responseMain =
            ResponseMain<EmptyResponse>.createErrorWithData(
          statusCode: 400,
          developerMessage: "Invalid referral code",
          title: "Invalid referral code",
        );

        when(
          mockApiPromotion.applyReferralCode(referralCode: testReferralCode),
        ).thenAnswer((_) async => responseMain);

        // Act
        final Resource<EmptyResponse?> result =
            await repository.applyReferralCode(
          referralCode: testReferralCode,
        ) as Resource<EmptyResponse?>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        expect(result.message, "Invalid referral code");
      });

      test("should return error when referral code already used", () async {
        // Arrange
        final ResponseMain<EmptyResponse> responseMain =
            ResponseMain<EmptyResponse>.createErrorWithData(
          statusCode: 400,
          developerMessage: "Referral code already used",
          title: "Referral code already used",
        );

        when(
          mockApiPromotion.applyReferralCode(referralCode: testReferralCode),
        ).thenAnswer((_) async => responseMain);

        // Act
        final Resource<EmptyResponse?> result =
            await repository.applyReferralCode(
          referralCode: testReferralCode,
        ) as Resource<EmptyResponse?>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        expect(result.message, "Referral code already used");
      });

      test("should handle unauthorized access (401)", () async {
        // Arrange
        final ResponseMain<EmptyResponse> responseMain =
            ResponseMain<EmptyResponse>.createErrorWithData(
          statusCode: 401,
          developerMessage: "Unauthorized",
          title: "Unauthorized",
        );

        when(
          mockApiPromotion.applyReferralCode(referralCode: testReferralCode),
        ).thenAnswer((_) async => responseMain);

        // Act
        final Resource<EmptyResponse?> result =
            await repository.applyReferralCode(
          referralCode: testReferralCode,
        ) as Resource<EmptyResponse?>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        expect(result.message, "Unauthorized");
      });
    });

    group("redeemVoucher", () {
      const String testVoucherCode = "VOUCHER2024";

      test("should return success resource when voucher is redeemed", () async {
        // Arrange
        final EmptyResponse expectedResponse = EmptyResponse();

        final ResponseMain<EmptyResponse> responseMain =
            ResponseMain<EmptyResponse>.createErrorWithData(
          data: expectedResponse,
          message: "Voucher redeemed successfully",
          statusCode: 200,
        );

        when(
          mockApiPromotion.redeemVoucher(voucherCode: testVoucherCode),
        ).thenAnswer((_) async => responseMain);

        // Act
        final Resource<EmptyResponse?> result = await repository.redeemVoucher(
          voucherCode: testVoucherCode,
        ) as Resource<EmptyResponse?>;

        // Assert
        expect(result.resourceType, ResourceType.success);
        expect(result.data, expectedResponse);
        expect(result.message, "Voucher redeemed successfully");

        verify(
          mockApiPromotion.redeemVoucher(voucherCode: testVoucherCode),
        ).called(1);
      });

      test("should return error resource when voucher is invalid", () async {
        // Arrange
        final ResponseMain<EmptyResponse> responseMain =
            ResponseMain<EmptyResponse>.createErrorWithData(
          statusCode: 400,
          developerMessage: "Invalid voucher code",
          title: "Invalid voucher code",
        );

        when(
          mockApiPromotion.redeemVoucher(voucherCode: testVoucherCode),
        ).thenAnswer((_) async => responseMain);

        // Act
        final Resource<EmptyResponse?> result = await repository.redeemVoucher(
          voucherCode: testVoucherCode,
        ) as Resource<EmptyResponse?>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        expect(result.message, "Invalid voucher code");
      });

      test("should return error when voucher already redeemed", () async {
        // Arrange
        final ResponseMain<EmptyResponse> responseMain =
            ResponseMain<EmptyResponse>.createErrorWithData(
          statusCode: 400,
          developerMessage: "Voucher already redeemed",
          title: "Voucher already redeemed",
        );

        when(
          mockApiPromotion.redeemVoucher(voucherCode: testVoucherCode),
        ).thenAnswer((_) async => responseMain);

        // Act
        final Resource<EmptyResponse?> result = await repository.redeemVoucher(
          voucherCode: testVoucherCode,
        ) as Resource<EmptyResponse?>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        expect(result.message, "Voucher already redeemed");
      });

      test("should handle server error (500)", () async {
        // Arrange
        final ResponseMain<EmptyResponse> responseMain =
            ResponseMain<EmptyResponse>.createErrorWithData(
          statusCode: 500,
          developerMessage: "Internal server error",
          title: "Internal server error",
        );

        when(
          mockApiPromotion.redeemVoucher(voucherCode: testVoucherCode),
        ).thenAnswer((_) async => responseMain);

        // Act
        final Resource<EmptyResponse?> result = await repository.redeemVoucher(
          voucherCode: testVoucherCode,
        ) as Resource<EmptyResponse?>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        expect(result.message, "Internal server error");
      });
    });

    group("getRewardsHistory", () {
      test("should return success resource with rewards history list",
          () async {
        // Arrange
        final List<RewardHistoryResponseModel> expectedRewards =
            <RewardHistoryResponseModel>[
          RewardHistoryResponseModel(
            isReferral: true,
            amount: r"$5.00",
            name: "friend@email.com",
            promotionName: "",
            date: "1704067200",
          ),
          RewardHistoryResponseModel(
            isReferral: false,
            amount: r"$10.00",
            name: "Europe 5GB",
            promotionName: "10% Cashback",
            date: "1703980800",
          ),
        ];

        final ResponseMain<List<RewardHistoryResponseModel>> responseMain =
            ResponseMain<List<RewardHistoryResponseModel>>.createErrorWithData(
          data: expectedRewards,
          message: "Rewards history retrieved successfully",
          statusCode: 200,
        );

        when(mockApiPromotion.getRewardsHistory())
            .thenAnswer((_) async => responseMain);

        // Act
        final Resource<List<RewardHistoryResponseModel>> result =
            await repository.getRewardsHistory()
                as Resource<List<RewardHistoryResponseModel>>;

        // Assert
        expect(result.resourceType, ResourceType.success);
        expect(result.data, expectedRewards);
        expect(result.data?.length, 2);
        expect(result.message, "Rewards history retrieved successfully");

        verify(mockApiPromotion.getRewardsHistory()).called(1);
      });

      test("should return success with empty list when no rewards", () async {
        // Arrange
        final List<RewardHistoryResponseModel> emptyRewards =
            <RewardHistoryResponseModel>[];

        final ResponseMain<List<RewardHistoryResponseModel>> responseMain =
            ResponseMain<List<RewardHistoryResponseModel>>.createErrorWithData(
          data: emptyRewards,
          message: "No rewards found",
          statusCode: 200,
        );

        when(mockApiPromotion.getRewardsHistory())
            .thenAnswer((_) async => responseMain);

        // Act
        final Resource<List<RewardHistoryResponseModel>> result =
            await repository.getRewardsHistory()
                as Resource<List<RewardHistoryResponseModel>>;

        // Assert
        expect(result.resourceType, ResourceType.success);
        expect(result.data, emptyRewards);
        expect(result.data?.length, 0);
      });

      test("should return error resource when API call fails", () async {
        // Arrange
        final ResponseMain<List<RewardHistoryResponseModel>> responseMain =
            ResponseMain<List<RewardHistoryResponseModel>>.createErrorWithData(
          statusCode: 400,
          developerMessage: "Failed to retrieve rewards history",
          title: "Failed to retrieve rewards history",
        );

        when(mockApiPromotion.getRewardsHistory())
            .thenAnswer((_) async => responseMain);

        // Act
        final Resource<List<RewardHistoryResponseModel>> result =
            await repository.getRewardsHistory()
                as Resource<List<RewardHistoryResponseModel>>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        expect(result.message, "Failed to retrieve rewards history");
      });

      test("should handle unauthorized access (401)", () async {
        // Arrange
        final ResponseMain<List<RewardHistoryResponseModel>> responseMain =
            ResponseMain<List<RewardHistoryResponseModel>>.createErrorWithData(
          statusCode: 401,
          developerMessage: "Unauthorized",
          title: "Unauthorized",
        );

        when(mockApiPromotion.getRewardsHistory())
            .thenAnswer((_) async => responseMain);

        // Act
        final Resource<List<RewardHistoryResponseModel>> result =
            await repository.getRewardsHistory()
                as Resource<List<RewardHistoryResponseModel>>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        expect(result.message, "Unauthorized");
      });
    });

    group("getReferralInfo", () {
      test("should return success resource with referral info", () async {
        // Arrange
        final ReferralInfoResponseModel expectedInfo =
            ReferralInfoResponseModel(
          amount: 5.0,
          currency: "USD",
          type: "credit",
          message: r"Earn $5 for each referral",
        );

        final ResponseMain<ReferralInfoResponseModel> responseMain =
            ResponseMain<ReferralInfoResponseModel>.createErrorWithData(
          data: expectedInfo,
          message: "Referral info retrieved successfully",
          statusCode: 200,
        );

        when(mockApiPromotion.getReferralInfo())
            .thenAnswer((_) async => responseMain);

        // Act
        final Resource<ReferralInfoResponseModel?> result =
            await repository.getReferralInfo()
                as Resource<ReferralInfoResponseModel?>;

        // Assert
        expect(result.resourceType, ResourceType.success);
        expect(result.data, expectedInfo);
        expect(result.data?.amount, 5.0);
        expect(result.data?.currency, "USD");
        expect(result.message, "Referral info retrieved successfully");

        verify(mockApiPromotion.getReferralInfo()).called(1);
      });

      test("should return error resource when API call fails", () async {
        // Arrange
        final ResponseMain<ReferralInfoResponseModel> responseMain =
            ResponseMain<ReferralInfoResponseModel>.createErrorWithData(
          statusCode: 400,
          developerMessage: "Failed to retrieve referral info",
          title: "Failed to retrieve referral info",
        );

        when(mockApiPromotion.getReferralInfo())
            .thenAnswer((_) async => responseMain);

        // Act
        final Resource<ReferralInfoResponseModel?> result =
            await repository.getReferralInfo()
                as Resource<ReferralInfoResponseModel?>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        expect(result.message, "Failed to retrieve referral info");
      });

      test("should handle server error (500)", () async {
        // Arrange
        final ResponseMain<ReferralInfoResponseModel> responseMain =
            ResponseMain<ReferralInfoResponseModel>.createErrorWithData(
          statusCode: 500,
          developerMessage: "Internal server error",
          title: "Internal server error",
        );

        when(mockApiPromotion.getReferralInfo())
            .thenAnswer((_) async => responseMain);

        // Act
        final Resource<ReferralInfoResponseModel?> result =
            await repository.getReferralInfo()
                as Resource<ReferralInfoResponseModel?>;

        // Assert
        expect(result.resourceType, ResourceType.error);
        expect(result.message, "Internal server error");
      });
    });

    group("Repository contract compliance", () {
      test("should implement ApiPromotionRepository interface", () {
        expect(repository, isA<ApiPromotionRepository>());
      });

      test("should return FutureOr<dynamic> as specified in interface",
          () async {
        // Arrange
        const String testCode = "TEST";
        final ResponseMain<EmptyResponse> responseMain =
            ResponseMain<EmptyResponse>.createErrorWithData(
          data: EmptyResponse(),
          message: "Success",
          statusCode: 200,
        );

        when(mockApiPromotion.redeemVoucher(voucherCode: testCode))
            .thenAnswer((_) async => responseMain);

        // Act
        final FutureOr<dynamic> result = repository.redeemVoucher(
          voucherCode: testCode,
        );

        // Assert
        expect(result, isA<FutureOr<dynamic>>());
        expect(result, isA<Future<Resource<EmptyResponse?>>>());
      });
    });
  });
}
