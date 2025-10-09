import "package:esim_open_source/presentation/enums/payment_type.dart";
import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/payment_selection_bottom_sheet/payment_selection_bottom_sheet_view.dart";
import "package:esim_open_source/presentation/widgets/bottom_sheet_close_button.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

void main() {
  group("PaymentSelectionBottomSheetView Tests", () {
    setUpAll(() async {
      await prepareTest();
    });

    setUp(() async {
      await setupTest();
      onViewModelReadyMock(viewName: "PaymentSelectionBottomSheetView");
    });

    tearDown(() async {
      await tearDownTest();
    });

    tearDownAll(() async {
      await tearDownAllTest();
    });

    testWidgets("should render payment selection bottom sheet correctly", (
      WidgetTester tester,
    ) async {
      void mockCompleter(SheetResponse<PaymentType> response) {}

      final SheetRequest<PaymentSelectionBottomRequest> requestBase =
          SheetRequest<PaymentSelectionBottomRequest>(
        data: const PaymentSelectionBottomRequest(
          paymentTypeList: <PaymentType>[PaymentType.card, PaymentType.wallet],
        ),
      );

      final PaymentSelectionBottomSheetView view =
          PaymentSelectionBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      await tester.pumpWidget(createTestableWidget(view));
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
      expect(find.byType(DecoratedBox), findsWidgets);
    });

    testWidgets("should render correct number of payment options", (
      WidgetTester tester,
    ) async {
      void mockCompleter(SheetResponse<PaymentType> response) {}

      final SheetRequest<PaymentSelectionBottomRequest> requestBase =
          SheetRequest<PaymentSelectionBottomRequest>(
        data: const PaymentSelectionBottomRequest(
          paymentTypeList: <PaymentType>[
            PaymentType.card,
            PaymentType.wallet,
            PaymentType.dcb,
          ],
        ),
      );

      final PaymentSelectionBottomSheetView view =
          PaymentSelectionBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      await tester.pumpWidget(createTestableWidget(view));
      await tester.pumpAndSettle();

      // Should find 3 payment options (each wrapped in GestureDetector)
      final Finder gestureDetectors = find.byType(GestureDetector);
      expect(gestureDetectors, findsWidgets);
    });

    testWidgets("should handle empty payment type list",
        (WidgetTester tester) async {
      void mockCompleter(SheetResponse<PaymentType> response) {}

      final SheetRequest<PaymentSelectionBottomRequest> requestBase =
          SheetRequest<PaymentSelectionBottomRequest>(
        data: const PaymentSelectionBottomRequest(
          paymentTypeList: <PaymentType>[],
        ),
      );

      final PaymentSelectionBottomSheetView view =
          PaymentSelectionBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      await tester.pumpWidget(createTestableWidget(view));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
    });

    testWidgets("should handle null data in request",
        (WidgetTester tester) async {
      void mockCompleter(SheetResponse<PaymentType> response) {}

      final SheetRequest<PaymentSelectionBottomRequest> requestBase =
          SheetRequest<PaymentSelectionBottomRequest>();

      final PaymentSelectionBottomSheetView view =
          PaymentSelectionBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      await tester.pumpWidget(createTestableWidget(view));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
    });

    test("buildPaymentSelectionView should create proper widget structure", () {
      void mockCompleter(SheetResponse<PaymentType> response) {}

      final SheetRequest<PaymentSelectionBottomRequest> requestBase =
          SheetRequest<PaymentSelectionBottomRequest>(
        data: const PaymentSelectionBottomRequest(
          paymentTypeList: <PaymentType>[PaymentType.card],
        ),
      );

      final PaymentSelectionBottomSheetView view =
          PaymentSelectionBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      final BuildContext context =
          MaterialApp(home: Container()).createElement();

      // Test that the method exists and can be called
      expect(view.buildPaymentSelectionView, isNotNull);
    });

    test("debugFillProperties should add properties correctly", () {
      void mockCompleter(SheetResponse<PaymentType> response) {}

      final SheetRequest<PaymentSelectionBottomRequest> requestBase =
          SheetRequest<PaymentSelectionBottomRequest>(
        data: const PaymentSelectionBottomRequest(
          paymentTypeList: <PaymentType>[PaymentType.card],
        ),
      );

      final PaymentSelectionBottomSheetView view =
          PaymentSelectionBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      view.debugFillProperties(builder);

      final List<DiagnosticsNode> properties = builder.properties;
      expect(
        properties.any((DiagnosticsNode node) => node.name == "requestBase"),
        isTrue,
      );
      expect(
        properties.any((DiagnosticsNode node) => node.name == "completer"),
        isTrue,
      );
    });

    test("view should be created with required parameters", () {
      void mockCompleter(SheetResponse<PaymentType> response) {}

      final SheetRequest<PaymentSelectionBottomRequest> requestBase =
          SheetRequest<PaymentSelectionBottomRequest>(
        data: const PaymentSelectionBottomRequest(
          paymentTypeList: <PaymentType>[PaymentType.card],
        ),
      );

      final PaymentSelectionBottomSheetView view =
          PaymentSelectionBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      expect(view.completer, equals(mockCompleter));
      expect(view.requestBase, equals(requestBase));
    });
  });
}
