import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/voucher_code_bottom_sheet/voucher_code_bottom_sheet_view.dart";
import "package:esim_open_source/presentation/widgets/bottom_sheet_close_button.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:esim_open_source/presentation/widgets/main_input_field.dart";
import "package:esim_open_source/presentation/widgets/padding_widget.dart";
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

  group("VoucherCodeBottomSheetView Widget Tests", () {
    testWidgets("renders basic structure correctly",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "VoucherCodeBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: VoucherCodeBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(VoucherCodeBottomSheetView), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(PaddingWidget), findsWidgets);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets("renders all required UI components",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "VoucherCodeBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: VoucherCodeBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(MainInputField), findsOneWidget);
      expect(find.byType(MainButton), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets("renders title and content text", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "VoucherCodeBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: VoucherCodeBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Text), findsWidgets);
      // Text widgets should be present for title and content
      // Note: Specific text content depends on localization keys being properly loaded
    });

    testWidgets("renders voucher code input field",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "VoucherCodeBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: VoucherCodeBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MainInputField), findsOneWidget);

      final MainInputField inputField =
          tester.widget(find.byType(MainInputField));
      expect(inputField.textInputType, equals(TextInputType.emailAddress));
      expect(inputField.suffixIcon, isA<GestureDetector>());
    });

    testWidgets("renders redeem button", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "VoucherCodeBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: VoucherCodeBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MainButton), findsOneWidget);

      final MainButton redeemButton = tester.widget(find.byType(MainButton));
      expect(redeemButton.height, equals(53));
      expect(redeemButton.hideShadows, isTrue);
    });

    testWidgets("handles scan QR code tap", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "VoucherCodeBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: VoucherCodeBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      // Find the GestureDetector inside the MainInputField's suffixIcon
      final Finder suffixIconFinder = find.descendant(
        of: find.byType(MainInputField),
        matching: find.byType(GestureDetector),
      );

      expect(suffixIconFinder, findsOneWidget);

      await tester.tap(suffixIconFinder);
      await tester.pump();

      // Verify no exceptions are thrown during the tap
      expect(tester.takeException(), isNull);
    });

    testWidgets("handles redeem button tap", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "VoucherCodeBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: VoucherCodeBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.byType(MainButton));
      await tester.pump();

      // Verify no exceptions are thrown during the tap
      expect(tester.takeException(), isNull);
    });

    testWidgets("debug properties test", (WidgetTester tester) async {
      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      final VoucherCodeBottomSheetView widget = VoucherCodeBottomSheetView(
        requestBase: request,
        completer: completer,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;

      final DiagnosticsProperty<SheetRequest<dynamic>> requestProp =
          props.firstWhere((DiagnosticsNode p) => p.name == "requestBase")
              as DiagnosticsProperty<SheetRequest<dynamic>>;

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

    testWidgets("render with different screen sizes",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "VoucherCodeBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      // Test with different screen size
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: VoucherCodeBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(VoucherCodeBottomSheetView), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);

      // Reset to default size
      addTearDown(tester.view.reset);
    });

    testWidgets("verifies BaseView.bottomSheetBuilder usage",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "VoucherCodeBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: VoucherCodeBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      // Verify the widget structure matches BaseView.bottomSheetBuilder pattern
      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(PaddingWidget), findsWidgets);
      expect(find.byType(Column), findsWidgets);
    });
  });
}
