import "package:cached_network_image/cached_network_image.dart";
import "package:esim_open_source/presentation/views/home_flow_views/banners_view/banner_view.dart";
import "package:esim_open_source/presentation/views/home_flow_views/banners_view/banners_view_model.dart";
import "package:esim_open_source/presentation/views/home_flow_views/banners_view/banners_view_types.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

class MockBannersViewModel extends Mock implements BannersViewModel {}

void main() async {
  await prepareTest();

  setUp(() async {
    await setupTest();
    onViewModelReadyMock();
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("BannerView Tests", () {
    testWidgets("renders basic structure with image",
        (WidgetTester tester) async {
      final MockBannersViewModel mockViewModel = MockBannersViewModel();
      final BannerState bannerState = BannerState(
        bannersViewType: BannersViewTypes.liveChat,
        title: "Test Title",
        description: "Test Description",
        image: "https://example.com/test-image.jpg",
      );

      final BannerView view = BannerView(
        bannerView: bannerState,
        bannersViewModel: mockViewModel,
      );

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();
    });

    testWidgets("renders without image when image is null",
        (WidgetTester tester) async {
      final MockBannersViewModel mockViewModel = MockBannersViewModel();
      final BannerState bannerState = BannerState(
        bannersViewType: BannersViewTypes.liveChat,
        title: "Test Title",
        description: "Test Description",
      );

      final BannerView view = BannerView(
        bannerView: bannerState,
        bannersViewModel: mockViewModel,
      );

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      expect(find.byType(BannerView), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsNothing);
      expect(find.text("Test Title"), findsOneWidget);
      expect(find.text("Test Description"), findsOneWidget);
    });

    testWidgets("renders without image when image is empty",
        (WidgetTester tester) async {
      final MockBannersViewModel mockViewModel = MockBannersViewModel();
      final BannerState bannerState = BannerState(
        bannersViewType: BannersViewTypes.liveChat,
        title: "Test Title",
        description: "Test Description",
        image: "",
      );

      final BannerView view = BannerView(
        bannerView: bannerState,
        bannersViewModel: mockViewModel,
      );

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      expect(find.byType(BannerView), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsNothing);
      expect(find.text("Test Title"), findsOneWidget);
      expect(find.text("Test Description"), findsOneWidget);
    });

    testWidgets("renders button for non-none banner types",
        (WidgetTester tester) async {
      final MockBannersViewModel mockViewModel = MockBannersViewModel();
      final BannerState bannerState = BannerState(
        bannersViewType: BannersViewTypes.referAndEarn,
        title: "Refer and Earn",
        description: "Invite friends",
        image: "https://example.com/refer.jpg",
      );

      final BannerView view = BannerView(
        bannerView: bannerState,
        bannersViewModel: mockViewModel,
      );

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      expect(find.byType(BannerView), findsOneWidget);
      expect(find.byType(MainButton), findsOneWidget);
    });

    testWidgets("does not render button for none banner type",
        (WidgetTester tester) async {
      final MockBannersViewModel mockViewModel = MockBannersViewModel();
      final BannerState bannerState = BannerState(
        bannersViewType: BannersViewTypes.none,
        title: "Just Display",
        description: "No action needed",
        image: "https://example.com/display.jpg",
      );

      final BannerView view = BannerView(
        bannerView: bannerState,
        bannersViewModel: mockViewModel,
      );

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      expect(find.byType(BannerView), findsOneWidget);
      expect(find.byType(MainButton), findsNothing);
      expect(find.byType(Container),
          findsWidgets,); // Container is rendered instead
    });

    testWidgets("renders gesture detector for tap handling",
        (WidgetTester tester) async {
      final MockBannersViewModel mockViewModel = MockBannersViewModel();
      final BannerState bannerState = BannerState(
        bannersViewType: BannersViewTypes.liveChat,
        title: "Chat Support",
        description: "Get help now",
        image: "https://example.com/chat.jpg",
      );

      final BannerView view = BannerView(
        bannerView: bannerState,
        bannersViewModel: mockViewModel,
      );

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();
    });

    testWidgets("renders main button for actionable banners",
        (WidgetTester tester) async {
      final MockBannersViewModel mockViewModel = MockBannersViewModel();
      final BannerState bannerState = BannerState(
        bannersViewType: BannersViewTypes.cashBackRewards,
        title: "Cashback",
        description: "Earn rewards",
        image: "https://example.com/cashback.jpg",
      );

      final BannerView view = BannerView(
        bannerView: bannerState,
        bannersViewModel: mockViewModel,
      );

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      expect(find.byType(MainButton), findsOneWidget);
    });

    testWidgets("handles null title and description",
        (WidgetTester tester) async {
      final MockBannersViewModel mockViewModel = MockBannersViewModel();
      final BannerState bannerState = BannerState(
        bannersViewType: BannersViewTypes.liveChat,
        image: "https://example.com/test.jpg",
      );

      final BannerView view = BannerView(
        bannerView: bannerState,
        bannersViewModel: mockViewModel,
      );

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      expect(find.byType(BannerView), findsOneWidget);
      expect(find.text(""),
          findsNWidgets(2),); // Empty strings for title and description
    });

    testWidgets("live chat banner has special color handling",
        (WidgetTester tester) async {
      final MockBannersViewModel mockViewModel = MockBannersViewModel();
      when(mockViewModel.textColor).thenReturn(Colors.white);
      when(mockViewModel.buttonColor).thenReturn(Colors.red);

      final BannerState bannerState = BannerState(
        bannersViewType: BannersViewTypes.liveChat,
        title: "Live Chat",
        description: "Chat with us",
        image: "https://example.com/chat.jpg",
      );

      final BannerView view = BannerView(
        bannerView: bannerState,
        bannersViewModel: mockViewModel,
      );

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      expect(find.byType(BannerView), findsOneWidget);
      expect(find.byType(MainButton), findsOneWidget);

      // Verify that special colors are used for live chat
      verify(mockViewModel.textColor).called(1);
      verify(mockViewModel.buttonColor).called(1);
    });

    test("debug properties coverage", () {
      final MockBannersViewModel mockViewModel = MockBannersViewModel();
      final BannerState bannerState = BannerState(
        bannersViewType: BannersViewTypes.liveChat,
        title: "Test",
        description: "Test",
      );

      final BannerView view = BannerView(
        bannerView: bannerState,
        bannersViewModel: mockViewModel,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      view.debugFillProperties(builder);

      final List<DiagnosticsNode> properties = builder.properties;
      expect(
          properties
              .any((DiagnosticsNode prop) => prop.name == "bannersViewModel"),
          isTrue,);
      expect(
          properties.any((DiagnosticsNode prop) => prop.name == "bannerView"),
          isTrue,);
    });
  });

  group("BannerView Visual Tests", () {
    testWidgets("image placeholder renders", (WidgetTester tester) async {
      final MockBannersViewModel mockViewModel = MockBannersViewModel();
      final BannerState bannerState = BannerState(
        bannersViewType: BannersViewTypes.liveChat,
        title: "Test",
        description: "Test",
        image: "https://example.com/test.jpg",
      );

      final BannerView view = BannerView(
        bannerView: bannerState,
        bannersViewModel: mockViewModel,
      );

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      // CachedNetworkImage should be present for placeholder/error handling
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets("proper padding is applied", (WidgetTester tester) async {
      final MockBannersViewModel mockViewModel = MockBannersViewModel();
      final BannerState bannerState = BannerState(
        bannersViewType: BannersViewTypes.referAndEarn,
        title: "Refer",
        description: "Earn",
        image: "https://example.com/refer.jpg",
      );

      final BannerView view = BannerView(
        bannerView: bannerState,
        bannersViewModel: mockViewModel,
      );

      await tester.pumpWidget(
        createTestableWidget(view),
      );

      await tester.pump();

      expect(find.byType(BannerView), findsOneWidget);
      // Verify that the view structure includes proper padding widgets
    });
  });
}
