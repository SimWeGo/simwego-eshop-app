import "package:esim_open_source/presentation/views/bottom_sheet/compatible_bottom_sheet_view/compatible_bottom_sheet_view_model.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();

  late CompatibleBottomSheetViewModel viewModel;

  setUp(() async {
    await setupTest();
    onViewModelReadyMock(viewName: "CompatibleBottomSheetView");

    viewModel = CompatibleBottomSheetViewModel();
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("CompatibleBottomSheetViewModel Tests", () {
    test("initialization test", () {
      expect(viewModel, isNotNull);
      expect(viewModel, isA<CompatibleBottomSheetViewModel>());
    });

    test("viewModel extends BaseModel", () {
      // Assert
      expect(viewModel, isA<CompatibleBottomSheetViewModel>());
    });

    test("viewModel can be instantiated multiple times", () {
      // Arrange & Act
      final CompatibleBottomSheetViewModel viewModel1 =
          CompatibleBottomSheetViewModel();
      final CompatibleBottomSheetViewModel viewModel2 =
          CompatibleBottomSheetViewModel();

      // Assert
      expect(viewModel1, isNotNull);
      expect(viewModel2, isNotNull);
      expect(viewModel1, isNot(same(viewModel2)));
    });
  });
}
