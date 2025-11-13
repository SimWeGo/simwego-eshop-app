import "package:esim_open_source/data/remote/responses/bundles/bundle_response_model.dart";
import "package:esim_open_source/data/remote/responses/bundles/country_response_model.dart";
import "package:esim_open_source/data/remote/responses/bundles/purchase_esim_bundle_response_model.dart";
import "package:esim_open_source/data/remote/responses/bundles/transaction_history_response_model.dart";
import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/e_sim_bundle/my_e_sim_bundle_bottom_sheet_view.dart";
import "package:esim_open_source/presentation/widgets/bottom_sheet_close_button.dart";
import "package:esim_open_source/presentation/widgets/bundle_header_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();

  setUp(() async {
    await setupTest();
    onViewModelReadyMock(viewName: "MyESimBundle");
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("MyESimBundleBottomSheetView Method Tests", () {
    test("widget instantiation with valid data", () {
      final PurchaseEsimBundleResponseModel testBundle =
          PurchaseEsimBundleResponseModel(
        displayTitle: "Test Bundle",
        unlimited: true,
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(
          data: MyESimBundleRequest(eSimBundleResponseModel: testBundle),
        ),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      expect(widget, isNotNull);
      expect(widget, isA<MyESimBundleBottomSheetView>());
      expect(widget.request.data, isNotNull);
      expect(widget.request.data?.eSimBundleResponseModel, equals(testBundle));
    });

    test("widget instantiation with null bundle", () {
      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(
          data: MyESimBundleRequest(eSimBundleResponseModel: null),
        ),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      expect(widget, isNotNull);
      expect(widget.request.data?.eSimBundleResponseModel, isNull);
    });

    test("widget instantiation with empty request", () {
      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      expect(widget, isNotNull);
    });

    testWidgets("buildTopHeader with complete bundle data",
        (WidgetTester tester) async {
      final PurchaseEsimBundleResponseModel testBundle =
          PurchaseEsimBundleResponseModel(
        displayTitle: "Europe 10GB",
        displaySubtitle: "30 Countries",
        gprsLimitDisplay: "10 GB",
        unlimited: false,
        icon: "https://test.com/icon.png",
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return widget.buildTopHeader(context, testBundle);
            },
          ),
        ),
      );

      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
      expect(find.byType(BundleHeaderView), findsOneWidget);
      expect(find.text("Europe 10GB"), findsOneWidget);
      expect(find.text("30 Countries"), findsOneWidget);
    });

    testWidgets("buildTopHeader with minimal bundle data",
        (WidgetTester tester) async {
      final PurchaseEsimBundleResponseModel testBundle =
          PurchaseEsimBundleResponseModel(
        displayTitle: "",
        displaySubtitle: "",
        gprsLimitDisplay: "",
        unlimited: false,
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return widget.buildTopHeader(context, testBundle);
            },
          ),
        ),
      );

      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
      expect(find.byType(BundleHeaderView), findsOneWidget);
    });

    test("buildTopHeader with unlimited bundle creates widget", () {
      final PurchaseEsimBundleResponseModel testBundle =
          PurchaseEsimBundleResponseModel(
        displayTitle: "Unlimited Plan",
        displaySubtitle: "Global",
        unlimited: true,
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      // Just verify the method doesn't throw an exception
      expect(() {
        final BuildContext context = MaterialApp(home: Container()).createElement();
        widget.buildTopHeader(context, testBundle);
      }, returnsNormally,);
    });

    testWidgets("buildTopHeader with null bundle",
        (WidgetTester tester) async {
      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return widget.buildTopHeader(context, null);
            },
          ),
        ),
      );

      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
      expect(find.byType(BundleHeaderView), findsOneWidget);
    });

    testWidgets("buildAccountInfo with complete data",
        (WidgetTester tester) async {
      final PurchaseEsimBundleResponseModel testBundle =
          PurchaseEsimBundleResponseModel(
        iccid: "892200660703814876",
        orderNumber: "ORD-12345",
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return widget.buildAccountInfo(context, testBundle, "31/12/2025");
            },
          ),
        ),
      );

      expect(find.text("892200660703814876"), findsOneWidget);
      expect(find.text("ORD-12345"), findsOneWidget);
      expect(find.text("31/12/2025"), findsOneWidget);
    });

    testWidgets("buildAccountInfo with null expiry date",
        (WidgetTester tester) async {
      final PurchaseEsimBundleResponseModel testBundle =
          PurchaseEsimBundleResponseModel(
        iccid: "892200660703814876",
        orderNumber: "ORD-12345",
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return widget.buildAccountInfo(context, testBundle, null);
            },
          ),
        ),
      );

      expect(find.text("892200660703814876"), findsOneWidget);
      expect(find.text("ORD-12345"), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets("buildAccountInfo with empty expiry date",
        (WidgetTester tester) async {
      final PurchaseEsimBundleResponseModel testBundle =
          PurchaseEsimBundleResponseModel(
        iccid: "892200660703814876",
        orderNumber: "ORD-12345",
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return widget.buildAccountInfo(context, testBundle, "");
            },
          ),
        ),
      );

      expect(find.text("892200660703814876"), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets("buildAccountInfo with null bundle",
        (WidgetTester tester) async {
      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return widget.buildAccountInfo(context, null, null);
            },
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets("buildPlanHistory with multiple transactions",
        (WidgetTester tester) async {
      final PurchaseEsimBundleResponseModel testBundle =
          PurchaseEsimBundleResponseModel(
        transactionHistory: <TransactionHistoryResponseModel>[
          TransactionHistoryResponseModel(
            userOrderId: "TXN-001",
            bundleType: "Primary",
            createdAt: "1708876762000",
          ),
          TransactionHistoryResponseModel(
            userOrderId: "TXN-002",
            bundleType: "Top-up",
            createdAt: "1708963162000",
          ),
        ],
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          SingleChildScrollView(
            child: Builder(
              builder: (BuildContext context) {
                return widget.buildPlanHistory(context, testBundle);
              },
            ),
          ),
        ),
      );

      expect(find.text("TXN-001"), findsOneWidget);
      expect(find.text("TXN-002"), findsOneWidget);
      expect(find.text("Primary"), findsOneWidget);
      expect(find.text("Top-up"), findsOneWidget);
    });

    testWidgets("buildPlanHistory with empty transaction list",
        (WidgetTester tester) async {
      final PurchaseEsimBundleResponseModel testBundle =
          PurchaseEsimBundleResponseModel(
        transactionHistory: <TransactionHistoryResponseModel>[],
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return widget.buildPlanHistory(context, testBundle);
            },
          ),
        ),
      );

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets("buildPlanHistory with null transaction history",
        (WidgetTester tester) async {
      final PurchaseEsimBundleResponseModel testBundle =
          PurchaseEsimBundleResponseModel(
        
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return widget.buildPlanHistory(context, testBundle);
            },
          ),
        ),
      );

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets("buildPlanHistory with null bundle",
        (WidgetTester tester) async {
      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return widget.buildPlanHistory(context, null);
            },
          ),
        ),
      );

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets("transActionsHistory with limited bundle",
        (WidgetTester tester) async {
      final TransactionHistoryResponseModel transaction =
          TransactionHistoryResponseModel(
        userOrderId: "TXN-004",
        bundleType: "Top-up",
        createdAt: "1708876762000",
      )

      ..bundle = BundleResponseModel(
        unlimited: false,
        priceDisplay: r"$30.00",
        validityDisplay: "7 Days",
        gprsLimitDisplay: "5 GB",
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          SingleChildScrollView(
            child: Builder(
              builder: (BuildContext context) {
                return widget.transActionsHistory(context, transaction);
              },
            ),
          ),
        ),
      );

      expect(find.text("5 GB"), findsOneWidget);
      expect(find.text(r"$30.00"), findsOneWidget);
    });

    testWidgets("transActionsHistory with null transaction bundle",
        (WidgetTester tester) async {
      final TransactionHistoryResponseModel transaction =
          TransactionHistoryResponseModel(
        userOrderId: "TXN-005",
        bundleType: "Primary",
        createdAt: "1708876762000",
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          SingleChildScrollView(
            child: Builder(
              builder: (BuildContext context) {
                return widget.transActionsHistory(context, transaction);
              },
            ),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets("transActionsHistory with null transaction",
        (WidgetTester tester) async {
      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          SingleChildScrollView(
            child: Builder(
              builder: (BuildContext context) {
                return widget.transActionsHistory(context, null);
              },
            ),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets("transActionsHistory displays bundle type correctly",
        (WidgetTester tester) async {
      final TransactionHistoryResponseModel transaction =
          TransactionHistoryResponseModel(
        userOrderId: "TXN-006",
        bundleType: "Renewal",
        createdAt: "1708876762000",
      )

      ..bundle = BundleResponseModel(
        unlimited: false,
        priceDisplay: r"$25.00",
        validityDisplay: "15 Days",
        gprsLimitDisplay: "3 GB",
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          SingleChildScrollView(
            child: Builder(
              builder: (BuildContext context) {
                return widget.transActionsHistory(context, transaction);
              },
            ),
          ),
        ),
      );

      expect(find.text("Renewal"), findsOneWidget);
    });

    testWidgets("transActionsHistory with null bundle type shows N/A",
        (WidgetTester tester) async {
      final TransactionHistoryResponseModel transaction =
          TransactionHistoryResponseModel(
        userOrderId: "TXN-007",
        createdAt: "1708876762000",
      )

      ..bundle = BundleResponseModel(
        unlimited: false,
        priceDisplay: r"$20.00",
        validityDisplay: "10 Days",
        gprsLimitDisplay: "2 GB",
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      await tester.pumpWidget(
        createTestableWidget(
          SingleChildScrollView(
            child: Builder(
              builder: (BuildContext context) {
                return widget.transActionsHistory(context, transaction);
              },
            ),
          ),
        ),
      );

      expect(find.text("N/A"), findsOneWidget);
    });

    test("completer callback is invoked correctly", () {
      bool completerCalled = false;
      SheetResponse<MainBottomSheetResponse>? capturedResponse;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        completerCalled = true;
        capturedResponse = response;
      }

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(),
        completer: testCompleter,
      );

      // Simulate completer call
      widget.completer(SheetResponse<MainBottomSheetResponse>());

      expect(completerCalled, isTrue);
      expect(capturedResponse, isNotNull);
    });

    test("widget with different bundle types", () {
      final List<String> bundleTypes = <String>["Primary", "Top-up", "Renewal"];

      for (final String type in bundleTypes) {
        final PurchaseEsimBundleResponseModel testBundle =
            PurchaseEsimBundleResponseModel(
          displayTitle: "$type Bundle",
          unlimited: false,
        );

        final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
          request: SheetRequest<MyESimBundleRequest>(
            data: MyESimBundleRequest(eSimBundleResponseModel: testBundle),
          ),
          completer: (SheetResponse<MainBottomSheetResponse> response) {},
        );

        expect(widget, isNotNull);
        expect(
          widget.request.data?.eSimBundleResponseModel?.displayTitle,
          equals("$type Bundle"),
        );
      }
    });

    test("widget handles multiple countries in bundle", () {
      final PurchaseEsimBundleResponseModel testBundle =
          PurchaseEsimBundleResponseModel(
        displayTitle: "Multi-Country Bundle",
        countries: <CountryResponseModel>[
          CountryResponseModel(country: "USA", countryCode: "US"),
          CountryResponseModel(country: "Canada", countryCode: "CA"),
          CountryResponseModel(country: "Mexico", countryCode: "MX"),
        ],
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(
          data: MyESimBundleRequest(eSimBundleResponseModel: testBundle),
        ),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      expect(widget, isNotNull);
      expect(
        widget.request.data?.eSimBundleResponseModel?.countries?.length,
        equals(3),
      );
    });

    test("widget with empty countries list", () {
      final PurchaseEsimBundleResponseModel testBundle =
          PurchaseEsimBundleResponseModel(
        displayTitle: "No Countries Bundle",
        countries: <CountryResponseModel>[],
      );

      final MyESimBundleBottomSheetView widget = MyESimBundleBottomSheetView(
        request: SheetRequest<MyESimBundleRequest>(
          data: MyESimBundleRequest(eSimBundleResponseModel: testBundle),
        ),
        completer: (SheetResponse<MainBottomSheetResponse> response) {},
      );

      expect(widget, isNotNull);
      expect(
        widget.request.data?.eSimBundleResponseModel?.countries?.length,
        equals(0),
      );
    });
  });
}
