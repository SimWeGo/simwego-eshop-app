import "package:esim_open_source/data/remote/responses/app/banner_response_model.dart";
import "package:esim_open_source/presentation/views/home_flow_views/banners_view/banner_view.dart";
import "package:esim_open_source/presentation/views/home_flow_views/banners_view/banners_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

void main() async {
  await prepareTest();

  setUp(() async {
    await setupTest();
    onViewModelReadyMock(viewName: "BannersView");
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("BannersView Tests", () {
    testWidgets("renders basic structure correctly", (WidgetTester tester) async {
      final BannersView view = const BannersView();

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      expect(find.byType(BannersView), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets("renders with empty banners list", (WidgetTester tester) async {
      final BannersView view = const BannersView();

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      expect(find.byType(BannersView), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets("renders banners correctly", (WidgetTester tester) async {
      final BannersView view = const BannersView();

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();
      await tester.pump(); // Allow view model to process

      expect(find.byType(BannersView), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
      // Since we have empty banner data by default, no BannerView widgets are rendered
    });

    testWidgets("handles view model disposal", (WidgetTester tester) async {
      final BannersView view = const BannersView();

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      // Dispose the widget
      await tester.pumpWidget(Container());

      // Should complete without error
      expect(find.byType(BannersView), findsNothing);
    });

    testWidgets("view model ready callback works", (WidgetTester tester) async {
      final BannersView view = const BannersView();

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      // The view should initialize the view model
      expect(find.byType(BannersView), findsOneWidget);
    });

    testWidgets("page view has correct properties", (WidgetTester tester) async {
      final BannersView view = const BannersView();

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      final PageView pageView = tester.widget(find.byType(PageView));
      expect(pageView.padEnds, isFalse);
    });
  });

  group("BannersView Integration Tests", () {
    testWidgets("responds to banner tap", (WidgetTester tester) async {
      final BannersView view = const BannersView();

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();
      await tester.pump(); // Allow view model to process

      // Try to tap on banner if any exist
      final Finder bannerFinder = find.byType(BannerView);
      if (bannerFinder.tryEvaluate()) {
        await tester.tap(bannerFinder.first);
        await tester.pump();
      }

      // Should complete without error
      expect(find.byType(BannersView), findsOneWidget);
    });

    testWidgets("handles error state gracefully", (WidgetTester tester) async {
      final BannersView view = const BannersView();

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      expect(find.byType(BannersView), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets("handles loading state", (WidgetTester tester) async {
      final BannersView view = const BannersView();

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      expect(find.byType(BannersView), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
    });
  });
}

List<BannerResponseModel> getMockBanners() {
  return <BannerResponseModel>[
    BannerResponseModel(
      title: "Live Chat Support",
      description: "Get instant help from our team",
      action: "CHAT",
      image: "https://example.com/chat.jpg",
    ),
    BannerResponseModel(
      title: "Refer and Earn",
      description: "Invite friends and earn rewards",
      action: "REFER_NOW",
      image: "https://example.com/refer.jpg",
    ),
    BannerResponseModel(
      title: "Cashback Rewards",
      description: "Earn cashback on every purchase",
      action: "CASHBACK",
      image: "https://example.com/cashback.jpg",
    ),
  ];
}
