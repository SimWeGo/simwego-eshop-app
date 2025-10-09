import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/success_bottom_sheet/success_bottom_sheet_view_model.dart";
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

  group("SuccessBottomSheetViewModel Tests", () {
    test("initializes correctly", () {
      onViewModelReadyMock(viewName: "SuccessBottomSheet");

      final SuccessBottomRequest testData = SuccessBottomRequest(
        title: "Success",
        description: "Operation completed",
        imagePath: "assets/success.png",
      );

      final SheetRequest<SuccessBottomRequest> request =
          SheetRequest<SuccessBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      SuccessBottomSheetViewModel(
        request: request,
        completer: completer,
      );

    });

    test("handles null data", () {
      final SheetRequest<SuccessBottomRequest> request =
          SheetRequest<SuccessBottomRequest>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      SuccessBottomSheetViewModel(
        request: request,
        completer: completer,
      );

    });

    test("calls completer", () {
      final SuccessBottomRequest testData = SuccessBottomRequest(
        title: "Test",
        description: "Test desc",
      );

      final SheetRequest<SuccessBottomRequest> request =
          SheetRequest<SuccessBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      final SuccessBottomSheetViewModel viewModel = SuccessBottomSheetViewModel(
        request: request,
        completer: completer,
      );

      viewModel.completer(SheetResponse<EmptyBottomSheetResponse>());
    });

    test("extends BaseModel", () {
      final SuccessBottomRequest testData = SuccessBottomRequest(
        title: "Base",
        description: "Base test",
      );

      final SheetRequest<SuccessBottomRequest> request =
          SheetRequest<SuccessBottomRequest>(data: testData);

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      SuccessBottomSheetViewModel(
        request: request,
        completer: completer,
      );

    });
  });
}
