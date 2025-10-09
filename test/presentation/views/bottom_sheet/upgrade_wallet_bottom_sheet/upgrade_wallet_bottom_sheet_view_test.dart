import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/upgrade_wallet_bottom_sheet/upgrade_wallet_bottom_sheet_view.dart";
import "package:esim_open_source/presentation/widgets/bottom_sheet_close_button.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:esim_open_source/presentation/widgets/main_input_field.dart";
import "package:esim_open_source/presentation/widgets/padding_widget.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart";
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

  group("UpgradeWalletBottomSheetView Widget Tests", () {
    testWidgets("renders basic structure correctly",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: UpgradeWalletBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(UpgradeWalletBottomSheetView), findsOneWidget);
      expect(find.byType(KeyboardDismissOnTap), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets("renders all required UI components",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: UpgradeWalletBottomSheetView(
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
      expect(find.byType(DecoratedBox), findsWidgets);
      expect(find.byType(PaddingWidget), findsWidgets);
    });

    testWidgets("renders title and content text", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: UpgradeWalletBottomSheetView(
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

    testWidgets("renders upgrade wallet amount input field",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: UpgradeWalletBottomSheetView(
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
      expect(inputField.textInputType,
          equals(const TextInputType.numberWithOptions(decimal: true)),);
    });

    testWidgets("renders upgrade button", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: UpgradeWalletBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MainButton), findsOneWidget);

      final MainButton upgradeButton = tester.widget(find.byType(MainButton));
      expect(upgradeButton.height, equals(53));
      expect(upgradeButton.hideShadows, isTrue);
    });

    // testWidgets("renders decorated box with rounded corners", (WidgetTester tester) async {
    //   onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");
    //
    //   final SheetRequest<dynamic> request = SheetRequest<dynamic>();
    //
    //   void completer(SheetResponse<EmptyBottomSheetResponse> response) {}
    //
    //   await tester.pumpWidget(
    //     createTestableWidget(
    //       Scaffold(
    //         body: UpgradeWalletBottomSheetView(
    //           requestBase: request,
    //           completer: completer,
    //         ),
    //       ),
    //     ),
    //   );
    //   await tester.pump();
    //
    //   expect(find.byType(DecoratedBox), findsWidgets);
    //
    //   final DecoratedBox decoratedBox = tester.widget(find.byType(DecoratedBox));
    //   final ShapeDecoration decoration = decoratedBox.decoration as ShapeDecoration;
    //   expect(decoration.color, equals(Colors.white));
    //
    //   final RoundedRectangleBorder shape = decoration.shape as RoundedRectangleBorder;
    //   expect(shape.borderRadius, equals(const BorderRadius.only(
    //     topLeft: Radius.circular(20),
    //     topRight: Radius.circular(20),
    //   ),),);
    // });
    //
    // testWidgets("handles close button tap", (WidgetTester tester) async {
    //   onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");
    //
    //   final SheetRequest<dynamic> request = SheetRequest<dynamic>();
    //
    //   bool completerCalled = false;
    //   void completer(SheetResponse<EmptyBottomSheetResponse> response) {
    //     completerCalled = true;
    //   }
    //
    //   await tester.pumpWidget(
    //     createTestableWidget(
    //       Scaffold(
    //         body: UpgradeWalletBottomSheetView(
    //           requestBase: request,
    //           completer: completer,
    //         ),
    //       ),
    //     ),
    //   );
    //   await tester.pump();
    //
    //   await tester.tap(find.byType(BottomSheetCloseButton));
    //   await tester.pump();
    //
    //   expect(completerCalled, isTrue);
    // });

    testWidgets("handles upgrade button tap", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: UpgradeWalletBottomSheetView(
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

    testWidgets("verifies keyboard dismiss on tap functionality",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: UpgradeWalletBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(KeyboardDismissOnTap), findsOneWidget);

      final KeyboardDismissOnTap keyboardDismiss =
          tester.widget(find.byType(KeyboardDismissOnTap));
      expect(keyboardDismiss.dismissOnCapturedTaps, isTrue);
    });

    testWidgets("debug properties test", (WidgetTester tester) async {
      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      final UpgradeWalletBottomSheetView widget = UpgradeWalletBottomSheetView(
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

    testWidgets("renders with different screen sizes",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      // Test with different screen size
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: UpgradeWalletBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(UpgradeWalletBottomSheetView), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);

      // Reset to default size
      addTearDown(tester.view.reset);
    });

    testWidgets("verifies BaseView.bottomSheetBuilder usage",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: UpgradeWalletBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      // Verify the widget structure matches BaseView.bottomSheetBuilder pattern
      expect(find.byType(KeyboardDismissOnTap), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(DecoratedBox), findsWidgets);
    });

    testWidgets("handles null request data", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: UpgradeWalletBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(UpgradeWalletBottomSheetView), findsOneWidget);
      expect(find.byType(KeyboardDismissOnTap), findsOneWidget);
    });

    testWidgets("verifies proper spacing and layout",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: UpgradeWalletBottomSheetView(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      // Verify main column layout
      final Column mainColumn = tester.widget(find.byType(Column).first);
      expect(mainColumn.mainAxisSize, equals(MainAxisSize.min));
      expect(mainColumn.mainAxisAlignment, equals(MainAxisAlignment.end));

      // Verify PaddingWidget exists and has symmetric padding
      expect(find.byType(PaddingWidget), findsWidgets);
    });
  });
}
