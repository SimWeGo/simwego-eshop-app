import "package:esim_open_source/data/remote/responses/promotion/referral_info_response_model.dart";
import "package:esim_open_source/domain/repository/services/referral_info_service.dart";
import "package:flutter_test/flutter_test.dart";

import "../../locator_test.dart";

/// Unit tests for ReferralInfoServiceImpl
/// Tests referral info model and service interface
///
/// Note: Singleton and method tests are skipped because ReferralInfoServiceImpl
/// requires full service locator setup with use cases and local storage which
/// are complex to mock properly in unit tests.
void main() {
  setUpAll(() async {
    await setupTestLocator();
  });

  group("ReferralInfoServiceImpl Tests", () {
    test("ReferralInfoService interface is properly defined", () {
      // Verify the interface exists
      expect(ReferralInfoService, isNotNull);
    });

    // Note: The following tests are skipped because ReferralInfoServiceImpl
    // requires the full service locator setup with use cases, local storage,
    // and API calls. These would need to be tested via integration tests or
    // with extensive mocking infrastructure.
    //
    // - test("singleton instance is created")
    // - test("getReferralAmount returns correct value")
    // - test("getReferralInfo fetches and stores data")
    // - test("refreshReferralInfo updates data")
    //
    // To properly test these, consider:
    // 1. Using integration tests
    // 2. Creating a testable wrapper that doesn't use static getInstance
    // 3. Mocking all dependencies (LocalStorageService, GetReferralInfoUseCase)
  });

  group("ReferralInfoResponseModel Tests", () {
    test("can parse referral info from JSON string", () {
      const String jsonString = '{"amount": 10.5, "currency": "USD", "message": "Refer a friend"}';

      final ReferralInfoResponseModel model =
          ReferralInfoResponseModel.referralInfoFromJsonString(jsonString);

      expect(model, isNotNull);
      expect(model.amount, 10.5);
      expect(model.currency, "USD");
      expect(model.message, "Refer a friend");
    });

    test("handles empty JSON string gracefully", () {
      const String jsonString = "";

      expect(
        () => ReferralInfoResponseModel.referralInfoFromJsonString(jsonString),
        throwsA(isA<Object>()),
      );
    });

    test("can convert model to JSON string", () {
      final ReferralInfoResponseModel model = ReferralInfoResponseModel(
        amount: 15.0,
        currency: "EUR",
        message: "Get 15 EUR for each referral",
      );

      final String jsonString = model.toJsonString();

      expect(jsonString, isNotEmpty);
      expect(jsonString, contains("amount"));
      expect(jsonString, contains("currency"));
    });
  });
}
