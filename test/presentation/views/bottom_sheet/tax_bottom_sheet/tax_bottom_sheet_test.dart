import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/tax_bottom_sheet/tax_bottom_sheet.dart";
import "package:esim_open_source/presentation/widgets/bottom_sheet_container.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:esim_open_source/presentation/widgets/my_card_wrap.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();

  setUp(() async {
    await setupTest();
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("TaxBottomSheet Widget Tests", () {
    testWidgets("renders basic structure correctly",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: r"$25.00",
        estimatedTax: r"$2.50",
        total: r"$27.50",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(TaxBottomSheet), findsOneWidget);
      expect(find.byType(BottomSheetContainer), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets("displays payment summary data correctly",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: r"$50.99",
        estimatedTax: r"$4.25",
        total: r"$55.24",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text(r"$50.99"), findsOneWidget);
      expect(find.text(r"$4.25"), findsOneWidget);
      expect(find.text(r"$55.24"), findsOneWidget);
    });

    testWidgets("handles confirm button tap correctly",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: r"$30.00",
        estimatedTax: r"$3.00",
        total: r"$33.00",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      bool completerCalled = false;
      SheetResponse<EmptyBottomSheetResponse>? response;

      void completer(SheetResponse<EmptyBottomSheetResponse> res) {
        completerCalled = true;
        response = res;
      }

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.byType(MainButton));
      await tester.pump();

      expect(completerCalled, isTrue);
      expect(response, isNotNull);
      expect(response?.confirmed, isTrue);
    });

    testWidgets("renders main button with correct properties",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: r"$20.00",
        estimatedTax: r"$1.80",
        total: r"$21.80",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MainButton), findsOneWidget);

      final MainButton confirmButton = tester.widget(find.byType(MainButton));
      expect(confirmButton.height, equals(53));
      expect(confirmButton.hideShadows, isTrue);
      expect(confirmButton.onPressed, isNotNull);
    });

    testWidgets("handles null request data gracefully",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(TaxBottomSheet), findsOneWidget);
      expect(find.byType(BottomSheetContainer), findsOneWidget);
      expect(find.byType(MainButton), findsOneWidget);
    });

    testWidgets("renders with different screen sizes",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: r"$75.99",
        estimatedTax: r"$6.08",
        total: r"$82.07",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      // Test with different screen size
      tester.view.physicalSize = const Size(600, 1000);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(TaxBottomSheet), findsOneWidget);
      expect(find.byType(BottomSheetContainer), findsOneWidget);

      // Reset to default size
      addTearDown(tester.view.reset);
    });

    testWidgets("rowItem method creates correct widget structure",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: r"$10.00",
        estimatedTax: r"$0.80",
        total: r"$10.80",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      // Verify that Row widgets exist (created by rowItem method)
      expect(find.byType(Row), findsWidgets);
      expect(find.text(r"$10.00"), findsOneWidget);
      expect(find.text(r"$0.80"), findsOneWidget);
      expect(find.text(r"$10.80"), findsOneWidget);
    });

    testWidgets("debug properties test", (WidgetTester tester) async {
      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: r"$15.00",
        estimatedTax: r"$1.20",
        total: r"$16.20",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      final TaxBottomSheet widget = TaxBottomSheet(
        request: request,
        completer: completer,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;

      final DiagnosticsProperty<SheetRequest<TaxBottomRequest>> requestProp =
          props.firstWhere((DiagnosticsNode p) => p.name == "request")
              as DiagnosticsProperty<SheetRequest<TaxBottomRequest>>;

      expect(requestProp.value, isNotNull);
      expect(requestProp.value, equals(request));

      final ObjectFlagProperty<
              Function(SheetResponse<EmptyBottomSheetResponse> p1)>
          completerProp =
          props.firstWhere((DiagnosticsNode p) => p.name == "completer")
              as ObjectFlagProperty<
                  Function(SheetResponse<EmptyBottomSheetResponse> p1)>;

      expect(completerProp.value, isNotNull);
    });

    testWidgets("verifies BaseView.bottomSheetBuilder usage",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: r"$35.50",
        estimatedTax: r"$2.84",
        total: r"$38.34",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      // Verify the widget structure matches BaseView.bottomSheetBuilder pattern
      expect(find.byType(BottomSheetContainer), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets("handles special currency characters",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: "€45.99",
        estimatedTax: "€3.68",
        total: "€49.67",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text("€45.99"), findsOneWidget);
      expect(find.text("€3.68"), findsOneWidget);
      expect(find.text("€49.67"), findsOneWidget);
    });

    testWidgets("verifies column layout properties",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: r"$60.00",
        estimatedTax: r"$4.80",
        total: r"$64.80",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      // Verify columns exist in the layout
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets("verifies MyCardWrap configuration",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: r"$80.00",
        estimatedTax: r"$6.40",
        total: r"$86.40",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MyCardWrap), findsWidgets);
    });

    testWidgets("handles long amount strings", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: r"$1,234,567.89",
        estimatedTax: r"$98,765.43",
        total: r"$1,333,333.32",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text(r"$1,234,567.89"), findsOneWidget);
      expect(find.text(r"$98,765.43"), findsOneWidget);
      expect(find.text(r"$1,333,333.32"), findsOneWidget);
    });

    testWidgets("widget creation and destruction without errors",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "TaxBottomSheet");

      final TaxBottomRequest testData = TaxBottomRequest(
        subTotal: r"$5.00",
        estimatedTax: r"$0.40",
        total: r"$5.40",
      );

      final SheetRequest<TaxBottomRequest> request =
          SheetRequest<TaxBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      // Test widget creation
      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: TaxBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(TaxBottomSheet), findsOneWidget);

      // Test widget destruction
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      expect(find.byType(TaxBottomSheet), findsNothing);
    });
  });
}
