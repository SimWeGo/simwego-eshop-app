import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/payment_method_bottom_sheet/payment_method_bottom_sheet_view.dart";
import "package:esim_open_source/presentation/widgets/payment_methods_list.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

void main() {
  group("PaymentMethodBottomSheetView Tests", () {
    setUpAll(() async {
      await prepareTest();
    });

    setUp(() async {
      await setupTest();
      onViewModelReadyMock(viewName: "PaymentMethodBottomSheetView");
    });

    tearDown(() async {
      await tearDownTest();
    });

    tearDownAll(() async {
      await tearDownAllTest();
    });

    testWidgets("should render payment method bottom sheet correctly",
        (WidgetTester tester) async {
      void mockCompleter(SheetResponse<EmptyBottomSheetResponse?> response) {}

      final PaymentMethodBottomSheetView view = PaymentMethodBottomSheetView(
        completer: mockCompleter,
      );

      await tester.pumpWidget(createTestableWidget(view));
      await tester.pumpAndSettle();

      expect(find.byType(PaymentMethodsList), findsOneWidget);
      expect(find.byType(CloseButton), findsOneWidget);
      expect(find.byType(Padding), findsWidgets);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets("should call completer when close button is pressed",
        (WidgetTester tester) async {
      bool completerCalled = false;
      void testCompleter(SheetResponse<EmptyBottomSheetResponse?> response) {
        completerCalled = true;
      }

      final PaymentMethodBottomSheetView view = PaymentMethodBottomSheetView(
        completer: testCompleter,
      );

      await tester.pumpWidget(createTestableWidget(view));
      await tester.pumpAndSettle();

      final Finder closeButton = find.byType(CloseButton);
      expect(closeButton, findsOneWidget);

      await tester.tap(closeButton);
      await tester.pump();

      expect(completerCalled, isTrue);
    });

    test("debugFillProperties should add properties correctly", () {
      void testCompleter(SheetResponse<EmptyBottomSheetResponse?> response) {}

      final PaymentMethodBottomSheetView view = PaymentMethodBottomSheetView(
        completer: testCompleter,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      view.debugFillProperties(builder);

      final List<DiagnosticsNode> properties = builder.properties;
      expect(properties.any((DiagnosticsNode node) => node.name == "completer"),
          isTrue,);
    });

    test("view should be created with required completer", () {
      void testCompleter(SheetResponse<EmptyBottomSheetResponse?> response) {}

      final PaymentMethodBottomSheetView view = PaymentMethodBottomSheetView(
        completer: testCompleter,
      );

      expect(view.completer, equals(testCompleter));
    });
  });
}
