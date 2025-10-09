import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/success_bottom_sheet/success_bottom_sheet.dart";
import "package:esim_open_source/presentation/widgets/bottom_sheet_close_button.dart";
import "package:esim_open_source/presentation/widgets/network_image_cached.dart";
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

  group("SuccessBottomSheet Widget Tests", () {
    testWidgets("displays all UI components", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "SuccessBottomSheet");

      final SuccessBottomRequest testData = SuccessBottomRequest(
        title: "Test Title",
        description: "Test Description",
        imagePath: "assets/images/shared/flags/globalFlag.svg",
      );

      final SheetRequest<SuccessBottomRequest> request =
          SheetRequest<SuccessBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: SuccessBottomSheet(
              request: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
      expect(find.byType(CachedImage), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
    });

    // testWidgets("handles null request data gracefully",
    //     (WidgetTester tester) async {
    //   onViewModelReadyMock(viewName: "SuccessBottomSheet");
    //
    //   final SheetRequest<SuccessBottomRequest> request =
    //       SheetRequest<SuccessBottomRequest>();
    //
    //   void completer(SheetResponse<EmptyBottomSheetResponse> response) {}
    //
    //   await tester.pumpWidget(
    //     createTestableWidget(
    //       Scaffold(
    //         body: SuccessBottomSheet(
    //           request: request,
    //           completer: completer,
    //         ),
    //       ),
    //     ),
    //   );
    //   await tester.pump();
    //
    //   expect(find.byType(SuccessBottomSheet), findsOneWidget);
    // });

    testWidgets("debug properties test", (WidgetTester tester) async {
      final SuccessBottomRequest testData = SuccessBottomRequest(
        title: "Debug",
        description: "Debug test",
      );

      final SheetRequest<SuccessBottomRequest> request =
          SheetRequest<SuccessBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      final SuccessBottomSheet widget = SuccessBottomSheet(
        request: request,
        completer: completer,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;

      final DiagnosticsProperty<SheetRequest<SuccessBottomRequest>>
          requestProp =
          props.firstWhere((DiagnosticsNode p) => p.name == "request")
              as DiagnosticsProperty<SheetRequest<SuccessBottomRequest>>;

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
  });
}
