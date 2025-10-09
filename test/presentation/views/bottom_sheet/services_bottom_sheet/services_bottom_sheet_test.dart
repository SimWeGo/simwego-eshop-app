import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/services_bottom_sheet/services_bottom_sheet.dart";
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

  group("ServicesBottomSheet Widget Tests", () {
    testWidgets("renders basic structure", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "ServicesBottomSheet");

      final SheetRequest<ServicesBottomRequest> request =
          SheetRequest<ServicesBottomRequest>();

      void completer(SheetResponse<MainBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: ServicesBottomSheet(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(ServicesBottomSheet), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(DecoratedBox), findsWidgets);
    });

    testWidgets("renders with title and subtitle", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "ServicesBottomSheet");

      final SheetRequest<ServicesBottomRequest> request =
          SheetRequest<ServicesBottomRequest>(
        data: const ServicesBottomRequest(
          title: "Test Title",
          subtitle: "Test Subtitle",
        ),
      );

      void completer(SheetResponse<MainBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: ServicesBottomSheet(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text("Test Title"), findsOneWidget);
      expect(find.text("Test Subtitle"), findsOneWidget);
    });

    testWidgets("renders with actions", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "ServicesBottomSheet");

      final SheetRequest<ServicesBottomRequest> request =
          SheetRequest<ServicesBottomRequest>(
        data: const ServicesBottomRequest(
          actions: <ServicesBottomAction>[
            ServicesBottomAction(tag: "action1", title: "Action 1"),
            ServicesBottomAction(tag: "action2", title: "Action 2"),
          ],
        ),
      );

      void completer(SheetResponse<MainBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: ServicesBottomSheet(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets("debug properties", (WidgetTester tester) async {
      final SheetRequest<ServicesBottomRequest> request =
          SheetRequest<ServicesBottomRequest>();

      void completer(SheetResponse<MainBottomSheetResponse> response) {}

      final ServicesBottomSheet widget = ServicesBottomSheet(
        requestBase: request,
        completer: completer,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;

      final DiagnosticsProperty<SheetRequest<ServicesBottomRequest>>
          requestBaseProp =
          props.firstWhere((DiagnosticsNode p) => p.name == "requestBase")
              as DiagnosticsProperty<SheetRequest<ServicesBottomRequest>>;

      expect(requestBaseProp.value, equals(request));
    });
  });
}
