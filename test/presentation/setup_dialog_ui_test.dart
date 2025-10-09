import "package:esim_open_source/presentation/enums/dialog_icon_type.dart";
import "package:esim_open_source/presentation/enums/dialog_type.dart";
import "package:esim_open_source/presentation/setup_dialog_ui.dart";
import "package:esim_open_source/presentation/views/dialog/main_dialog_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../helpers/view_helper.dart";
import "../helpers/view_model_helper.dart";

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

  group("setupDialogUi Function Tests", () {
    test("setupDialogUi registers dialog builders", () {
      // The function should execute without errors
      expect(setupDialogUi, returnsNormally);
    });
  });

  group("MainDialogRequest Tests", () {
    test("creates instance with default values", () {
      const MainDialogRequest request = MainDialogRequest();

      expect(request.iconType, equals(DialogIconType.warning));
      expect(request.title, isNull);
      expect(request.description, isNull);
      expect(request.showCancelButton, isTrue);
      expect(request.hideXButton, isTrue);
      expect(request.dismissibleDialog, isFalse);
      expect(request.cancelText, isNull);
      expect(request.informativeOnly, isFalse);
      expect(request.mainButtonColor, isNull);
      expect(request.mainButtonTitle, isNull);
      expect(request.mainButtonTag, isNull);
      expect(request.secondaryButtonColor, isNull);
      expect(request.secondaryButtonTitle, isNull);
      expect(request.secondaryButtonTag, isNull);
      expect(request.descriptionTextStyle, isNull);
    });

    test("creates instance with custom values", () {
      const Color testColor = Colors.blue;
      const TextStyle testStyle = TextStyle(fontSize: 16);

      const MainDialogRequest request = MainDialogRequest(
        iconType: DialogIconType.check,
        title: "Custom Title",
        description: "Custom Description",
        showCancelButton: false,
        hideXButton: false,
        dismissibleDialog: true,
        cancelText: "Custom Cancel",
        informativeOnly: true,
        mainButtonColor: testColor,
        mainButtonTitle: "Custom Main Button",
        mainButtonTag: "main_tag",
        secondaryButtonColor: testColor,
        secondaryButtonTitle: "Custom Secondary Button",
        secondaryButtonTag: "secondary_tag",
        descriptionTextStyle: testStyle,
      );

      expect(request.iconType, equals(DialogIconType.check));
      expect(request.title, equals("Custom Title"));
      expect(request.description, equals("Custom Description"));
      expect(request.showCancelButton, isFalse);
      expect(request.hideXButton, isFalse);
      expect(request.dismissibleDialog, isTrue);
      expect(request.cancelText, equals("Custom Cancel"));
      expect(request.informativeOnly, isTrue);
      expect(request.mainButtonColor, equals(testColor));
      expect(request.mainButtonTitle, equals("Custom Main Button"));
      expect(request.mainButtonTag, equals("main_tag"));
      expect(request.secondaryButtonColor, equals(testColor));
      expect(request.secondaryButtonTitle, equals("Custom Secondary Button"));
      expect(request.secondaryButtonTag, equals("secondary_tag"));
      expect(request.descriptionTextStyle, equals(testStyle));
    });
  });

  group("MainDialogResponse Tests", () {
    test("creates instance with default values", () {
      const MainDialogResponse response = MainDialogResponse();

      expect(response.tag, equals(""));
      expect(response.canceled, isTrue);
    });

    test("creates instance with custom values", () {
      const MainDialogResponse response = MainDialogResponse(
        tag: "custom_tag",
        canceled: false,
      );

      expect(response.tag, equals("custom_tag"));
      expect(response.canceled, isFalse);
    });
  });

  group("_MainDialog Widget Tests", () {
    testWidgets("renders with PopScope and Dialog", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "MainDialogView");

      const MainDialogRequest request = MainDialogRequest(
        dismissibleDialog: true,
        title: "Test Dialog",
      );

      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>(
        data: request,
      );

      void completer(DialogResponse<MainDialogResponse> response) {}

      // Access _MainDialog through the builder pattern used in setupDialogUi
      final Map<
          DialogType,
          dynamic Function(
            dynamic context,
            dynamic sheetRequest,
            Function(DialogResponse<MainDialogResponse> p1) completer,
          )> builders = <DialogType,
          dynamic Function(
        dynamic context,
        dynamic sheetRequest,
        Function(DialogResponse<MainDialogResponse> p1) completer,
      )>{
        DialogType.basic: (
          dynamic context,
          dynamic sheetRequest,
          Function(DialogResponse<MainDialogResponse>) completer,
        ) =>
            MainBasicDialog(
              requestBase: sheetRequest,
              completer: completer,
            ),
      };

      final Widget dialogWidget = builders[DialogType.basic]!(
        null,
        dialogRequest,
        completer,
      );

      await tester.pumpWidget(
        createTestableWidget(dialogWidget),
      );
      await tester.pump();

      expect(find.byType(MainBasicDialog), findsOneWidget);
      expect(find.text("Test Dialog"), findsOneWidget);
    });

    testWidgets("handles non-dismissible dialog", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "MainDialogView");

      const MainDialogRequest request = MainDialogRequest(
        title: "Non-Dismissible Dialog",
      );

      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>(
        data: request,
      );

      void completer(DialogResponse<MainDialogResponse> response) {}

      // Create widget directly to test PopScope behavior
      final Widget dialogWidget = MainBasicDialog(
        requestBase: dialogRequest,
        completer: completer,
      );

      await tester.pumpWidget(
        createTestableWidget(dialogWidget),
      );
      await tester.pump();

      expect(find.byType(MainBasicDialog), findsOneWidget);
      expect(find.text("Non-Dismissible Dialog"), findsOneWidget);
    });

    testWidgets("handles null request data", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "MainDialogView");

      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>();

      void completer(DialogResponse<MainDialogResponse> response) {}

      final Widget dialogWidget = MainBasicDialog(
        requestBase: dialogRequest,
        completer: completer,
      );

      await tester.pumpWidget(
        createTestableWidget(dialogWidget),
      );
      await tester.pump();

      expect(find.byType(MainBasicDialog), findsOneWidget);
    });
  });
}
