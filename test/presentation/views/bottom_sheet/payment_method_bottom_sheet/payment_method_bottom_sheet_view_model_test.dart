import "package:esim_open_source/presentation/views/bottom_sheet/payment_method_bottom_sheet/payment_method_bottom_sheet_view_model.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

void main() {
  group("PaymentMethodBottomSheetViewModel Tests", () {
    late PaymentMethodBottomSheetViewModel viewModel;

    setUp(() async {
      await prepareTest();
      await setupTest();
      onViewModelReadyMock(viewName: "PaymentMethodBottomSheetView");
      viewModel = PaymentMethodBottomSheetViewModel();
    });

    tearDown(() async {
      await tearDownTest();
    });

    tearDownAll(() async {
      await tearDownAllTest();
    });

    test("should initialize correctly", () {
      expect(viewModel, isNotNull);
      expect(viewModel.isBusy, isFalse);
    });
  });
}
