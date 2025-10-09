import "package:esim_open_source/presentation/enums/dialog_icon_type.dart";
import "package:esim_open_source/presentation/setup_dialog_ui.dart";
import "package:esim_open_source/presentation/views/dialog/main_dialog_view.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../helpers/view_helper.dart";
import "../../../helpers/view_model_helper.dart";

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

  group("MainBasicDialog Widget Tests", () {
    testWidgets("renders basic structure with no icon", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "MainDialogView");

      const MainDialogRequest request = MainDialogRequest(
        iconType: DialogIconType.none,
        title: "Test Title",
        description: "Test Description",
      );

      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>(
        data: request,
      );

      void completer(DialogResponse<MainDialogResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          MainBasicDialog(
            requestBase: dialogRequest,
            completer: completer,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MainBasicDialog), findsOneWidget);
      expect(find.text("Test Title"), findsOneWidget);
      expect(find.text("Test Description"), findsOneWidget);
      expect(find.byType(Stack), findsOneWidget);
    });

    testWidgets("renders with warning icon", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "MainDialogView");

      const MainDialogRequest request = MainDialogRequest(
        title: "Warning Title",
      );

      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>(
        data: request,
      );

      void completer(DialogResponse<MainDialogResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          MainBasicDialog(
            requestBase: dialogRequest,
            completer: completer,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.text("Warning Title"), findsOneWidget);
      expect(find.byType(Stack), findsOneWidget);
    });

    testWidgets("renders main button when provided", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "MainDialogView");

      const MainDialogRequest request = MainDialogRequest(
        mainButtonTitle: "Main Button",
        title: "Test Title",
      );

      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>(
        data: request,
      );

      void completer(DialogResponse<MainDialogResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          MainBasicDialog(
            requestBase: dialogRequest,
            completer: completer,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MainButton), findsOneWidget);
      expect(find.text("Main Button"), findsOneWidget);
    });

    testWidgets("renders secondary button when provided", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "MainDialogView");

      const MainDialogRequest request = MainDialogRequest(
        mainButtonTitle: "Main Button",
        secondaryButtonTitle: "Secondary Button",
        title: "Test Title",
      );

      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>(
        data: request,
      );

      void completer(DialogResponse<MainDialogResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          MainBasicDialog(
            requestBase: dialogRequest,
            completer: completer,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MainButton), findsNWidgets(2));
      expect(find.text("Main Button"), findsOneWidget);
      expect(find.text("Secondary Button"), findsOneWidget);
    });

    testWidgets("renders cancel button when showCancelButton is true", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "MainDialogView");

      const MainDialogRequest request = MainDialogRequest(
        cancelText: "Cancel",
        title: "Test Title",
      );

      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>(
        data: request,
      );

      void completer(DialogResponse<MainDialogResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          MainBasicDialog(
            requestBase: dialogRequest,
            completer: completer,
          ),
        ),
      );
      await tester.pump();

      expect(find.text("Cancel"), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets("renders informative button when informativeOnly is true", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "MainDialogView");

      const MainDialogRequest request = MainDialogRequest(
        informativeOnly: true,
        cancelText: "OK",
        title: "Info Title",
      );

      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>(
        data: request,
      );

      void completer(DialogResponse<MainDialogResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          MainBasicDialog(
            requestBase: dialogRequest,
            completer: completer,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MainButton), findsOneWidget);
      expect(find.text("OK"), findsOneWidget);
    });

    testWidgets("renders close button when hideXButton is true", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "MainDialogView");

      const MainDialogRequest request = MainDialogRequest(
        title: "Test Title",
      );

      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>(
        data: request,
      );

      void completer(DialogResponse<MainDialogResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          MainBasicDialog(
            requestBase: dialogRequest,
            completer: completer,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byIcon(Icons.close_sharp), findsOneWidget);
    });

    testWidgets("handles button interactions", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "MainDialogView");

      const MainDialogRequest request = MainDialogRequest(
        mainButtonTitle: "Main Button",
        secondaryButtonTitle: "Secondary Button",
        title: "Test Title",
      );

      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>(
        data: request,
      );

      bool mainButtonPressed = false;
      void completer(DialogResponse<MainDialogResponse> response) {
        mainButtonPressed = true;
      }

      await tester.pumpWidget(
        createTestableWidget(
          MainBasicDialog(
            requestBase: dialogRequest,
            completer: completer,
          ),
        ),
      );
      await tester.pump();

      // Test main button tap
      await tester.tap(find.text("Main Button"));
      await tester.pump();

      expect(mainButtonPressed, isTrue);
    });

    testWidgets("handles null request data", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "MainDialogView");

      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>();

      void completer(DialogResponse<MainDialogResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          MainBasicDialog(
            requestBase: dialogRequest,
            completer: completer,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MainBasicDialog), findsOneWidget);
      expect(find.byType(Stack), findsOneWidget);
    });

    testWidgets("debug properties test", (WidgetTester tester) async {
      const MainDialogRequest request = MainDialogRequest(title: "Test");
      final DialogRequest<MainDialogRequest> dialogRequest = DialogRequest<MainDialogRequest>(data: request);

      void completer(DialogResponse<MainDialogResponse> response) {}

      final MainBasicDialog widget = MainBasicDialog(
        requestBase: dialogRequest,
        completer: completer,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;

      final DiagnosticsProperty<DialogRequest<MainDialogRequest>> requestProp =
          props.firstWhere((DiagnosticsNode p) => p.name == "requestBase")
          as DiagnosticsProperty<DialogRequest<MainDialogRequest>>;

      expect(requestProp.value, isNotNull);
      expect(requestProp.value, equals(dialogRequest));
    });
  });

  group("getImageFromType Function Tests", () {
    test("returns Container for DialogIconType.none", () {
      const Color testColor = Colors.blue;
      final Widget result = getImageFromType(DialogIconType.none, testColor);

      expect(result, isA<Container>());
    });

    test("returns SvgPicture for DialogIconType.warning", () {
      const Color testColor = Colors.orange;
      final Widget result = getImageFromType(DialogIconType.warning, testColor);

      expect(result, isA<SvgPicture>());
    });

    test("returns SvgPicture for DialogIconType.warningRed", () {
      const Color testColor = Colors.blue;
      final Widget result = getImageFromType(DialogIconType.warningRed, testColor);

      expect(result, isA<SvgPicture>());
    });

    test("returns SvgPicture for DialogIconType.check", () {
      const Color testColor = Colors.green;
      final Widget result = getImageFromType(DialogIconType.check, testColor);

      expect(result, isA<SvgPicture>());
    });

    test("returns SvgPicture for DialogIconType.dataSharing", () {
      const Color testColor = Colors.purple;
      final Widget result = getImageFromType(DialogIconType.dataSharing, testColor);

      expect(result, isA<SvgPicture>());
    });
  });
}
