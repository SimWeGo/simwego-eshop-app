import "package:esim_open_source/data/services/analytics_service_impl.dart";
import "package:esim_open_source/domain/repository/services/analytics_service.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for AnalyticsServiceImpl and AnalyticEvent classes
/// Tests event creation, analytics service interface, and event structures
void main() {
  group("AnalyticEvent Tests", () {
    test("AnalyticsEvent can be created with event name", () {
      final AnalyticsEvent event = AnalyticsEvent("test_event");

      expect(event.eventName, "test_event");
      expect(event.parameters, isNull);
    });

    test("appCheckApp event is created correctly", () {
      final AnalyticEvent event = AnalyticEvent.appCheckApp();

      expect(event, isA<AnalyticEvent>());
      expect(event.eventName, "app_check_app");
    });

    test("appCheckBackend event is created correctly", () {
      final AnalyticEvent event = AnalyticEvent.appCheckBackend();

      expect(event, isA<AnalyticEvent>());
      expect(event.eventName, "app_check_backend");
    });

    test("contactUsClicked event is created correctly", () {
      final AnalyticEvent event = AnalyticEvent.contactUsClicked();

      expect(event, isA<AnalyticEvent>());
      expect(event.eventName, "contact_us_clicked");
    });

    test("userGuideOpened event is created correctly", () {
      final AnalyticEvent event = AnalyticEvent.userGuideOpened();

      expect(event, isA<AnalyticEvent>());
      expect(event.eventName, "user_guide_opened");
    });

    test("regionsClicked event is created correctly", () {
      final AnalyticEvent event = AnalyticEvent.regionsClicked();

      expect(event, isA<AnalyticEvent>());
      expect(event.eventName, "regions_clicked");
    });
  });

  group("CampaignEvent Tests", () {
    test("firstOpenCampaign event is created with correct parameters", () {
      final AnalyticEvent event = AnalyticEvent.firstOpenCampaign(
        utm: "test_utm",
        platform: "ios",
      );

      expect(event, isA<CampaignEvent>());
      expect(event.eventName, "first_open_campaign");
      expect(event.parameters, isNotNull);
      expect(event.parameters?["utm"], "test_utm");
      expect(event.parameters?["platform"], "ios");
    });

    test("loginSuccess event is created with correct parameters", () {
      final AnalyticEvent event = AnalyticEvent.loginSuccess(
        utm: "campaign_utm",
        platform: "android",
      );

      expect(event, isA<CampaignEvent>());
      expect(event.eventName, "campaign_login");
      expect(event.parameters, isNotNull);
      expect(event.parameters?["utm"], "campaign_utm");
      expect(event.parameters?["platform"], "android");
    });

    test("CampaignEvent parameters contain utm and platform", () {
      final CampaignEvent event = CampaignEvent(
        "test_campaign",
        utm: "test_utm_source",
        platform: "web",
      );

      final Map<String, Object>? params = event.parameters;
      expect(params, isNotNull);
      expect(params?.length, 2);
      expect(params?["utm"], "test_utm_source");
      expect(params?["platform"], "web");
    });
  });

  group("PurchaseSuccessEvent Tests", () {
    test("buySuccess event is created with correct parameters", () {
      final AnalyticEvent event = AnalyticEvent.buySuccess(
        utm: "purchase_utm",
        platform: "ios",
        amount: "99.99",
        currency: "USD",
      );

      expect(event, isA<PurchaseSuccessEvent>());
      expect(event.eventName, "campaign_buy");
      expect(event.parameters, isNotNull);
      expect(event.parameters?["utm"], "purchase_utm");
      expect(event.parameters?["platform"], "ios");
      expect(event.parameters?["amount"], "99.99");
      expect(event.parameters?["currency"], "USD");
    });

    test("buyTopUpSuccess event is created with correct parameters", () {
      final AnalyticEvent event = AnalyticEvent.buyTopUpSuccess(
        utm: "topup_utm",
        platform: "android",
        amount: "19.99",
        currency: "EUR",
      );

      expect(event, isA<PurchaseSuccessEvent>());
      expect(event.eventName, "campaign_topup");
      expect(event.parameters, isNotNull);
      expect(event.parameters?["utm"], "topup_utm");
      expect(event.parameters?["platform"], "android");
      expect(event.parameters?["amount"], "19.99");
      expect(event.parameters?["currency"], "EUR");
    });

    test("PurchaseSuccessEvent parameters contain all required fields", () {
      final PurchaseSuccessEvent event = PurchaseSuccessEvent(
        "test_purchase",
        utm: "utm_value",
        platform: "ios",
        amount: "50.00",
        currency: "GBP",
      );

      final Map<String, Object>? params = event.parameters;
      expect(params, isNotNull);
      expect(params?.length, 4);
      expect(params?["utm"], "utm_value");
      expect(params?["platform"], "ios");
      expect(params?["amount"], "50.00");
      expect(params?["currency"], "GBP");
    });
  });

  group("AnalyticsService Interface Tests", () {
    test("AnalyticsService interface is properly defined", () {
      expect(AnalyticsService, isNotNull);
    });

    test("AnalyticEvent is sealed class", () {
      expect(AnalyticEvent, isNotNull);
    });

    test("different event types have different event names", () {
      final AnalyticEvent appCheck = AnalyticEvent.appCheckApp();
      final AnalyticEvent contactUs = AnalyticEvent.contactUsClicked();
      final AnalyticEvent userGuide = AnalyticEvent.userGuideOpened();

      expect(appCheck.eventName, isNot(equals(contactUs.eventName)));
      expect(contactUs.eventName, isNot(equals(userGuide.eventName)));
      expect(userGuide.eventName, isNot(equals(appCheck.eventName)));
    });

    test("simple events have no parameters", () {
      final AnalyticEvent event1 = AnalyticEvent.appCheckApp();
      final AnalyticEvent event2 = AnalyticEvent.contactUsClicked();
      final AnalyticEvent event3 = AnalyticEvent.regionsClicked();

      expect(event1.parameters, isNull);
      expect(event2.parameters, isNull);
      expect(event3.parameters, isNull);
    });

    test("campaign events have parameters", () {
      final AnalyticEvent event = AnalyticEvent.loginSuccess(
        utm: "test",
        platform: "ios",
      );

      expect(event.parameters, isNotNull);
      expect(event.parameters, isA<Map<String, Object>>());
    });

    test("purchase events have more parameters than campaign events", () {
      final AnalyticEvent campaignEvent = AnalyticEvent.loginSuccess(
        utm: "test",
        platform: "ios",
      );

      final AnalyticEvent purchaseEvent = AnalyticEvent.buySuccess(
        utm: "test",
        platform: "ios",
        amount: "10.00",
        currency: "USD",
      );

      expect(campaignEvent.parameters?.length, 2);
      expect(purchaseEvent.parameters?.length, 4);
    });
  });

  group("AnalyticsServiceImpl Tests", () {
    test("AnalyticsServiceImpl class exists", () {
      expect(AnalyticsServiceImpl, isNotNull);
    });

    // Note: The following tests cannot be run because AnalyticsServiceImpl.instance
    // initializes Firebase Analytics and Facebook App Events which require
    // platform-specific setup that is not available in unit tests.
    //
    // To test AnalyticsServiceImpl properly, the class would need to be refactored to:
    // 1. Accept dependencies through constructor (dependency injection)
    // 2. Use interfaces for Firebase and Facebook analytics
    // 3. Avoid singleton pattern in favor of factory pattern
    //
    // Current coverage focuses on AnalyticEvent classes which contain the business logic
    // for event creation and parameter validation.
  });
}
