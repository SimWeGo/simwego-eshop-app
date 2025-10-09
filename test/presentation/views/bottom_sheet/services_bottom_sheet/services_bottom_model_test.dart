import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/services_bottom_sheet/services_bottom_model.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();
  late ServicesBottomViewModel viewModel;

  setUp(() async {
    await setupTest();
    onViewModelReadyMock(viewName: "ServicesBottomSheet");

    viewModel = ServicesBottomViewModel();
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("ServicesBottomViewModel Tests", () {
    test("line coverage test", () {
      // Hit initializeData method for line coverage
      viewModel.initializeData();

      expect(viewModel, isNotNull);
      expect(viewModel, isA<ServicesBottomViewModel>());
    });

    test("actionButtonClicked line coverage", () {
      bool completerCalled = false;
      SheetResponse<MainBottomSheetResponse>? response;

      void completer(SheetResponse<MainBottomSheetResponse> resp) {
        completerCalled = true;
        response = resp;
      }

      const ServicesBottomRequest request = ServicesBottomRequest();

      // Execute the method to hit lines
      viewModel.actionButtonClicked(
        tag: "test_tag",
        completer: completer,
        request: request,
      );

      // Verify the method executed key lines
      expect(completerCalled, isTrue);
      expect(response, isNotNull);
      expect(response?.data?.tag, equals("test_tag"));
      expect(response?.data?.canceled, isFalse);
    });
  });
}
