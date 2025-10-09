import "package:esim_open_source/presentation/enums/payment_type.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/payment_selection_bottom_sheet/payment_selection_bottom_sheet_view_model.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

void main() {
  group("PaymentSelectionBottomSheetViewModel Tests", () {
    late PaymentSelectionBottomSheetViewModel viewModel;
    late List<SheetResponse<PaymentType>> completerCalls;

    setUpAll(() async {
      await prepareTest();
    });

    setUp(() async {
      await setupTest();
      onViewModelReadyMock(viewName: "PaymentSelectionBottomSheetView");

      completerCalls = <SheetResponse<PaymentType>>[];
      void mockCompleter(SheetResponse<PaymentType> response) {
        completerCalls.add(response);
      }

      viewModel =
          PaymentSelectionBottomSheetViewModel(completer: mockCompleter);
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
      expect(viewModel.completer, isNotNull);
    });

    test("onCloseClick should call completer with empty response", () {
      viewModel.onCloseClick();

      expect(completerCalls.length, equals(1));
      expect(completerCalls.first.confirmed, isFalse);
      expect(completerCalls.first.data, isNull);
    });

    test("onPaymentTypeClick should call completer with payment type", () {
      const PaymentType testPaymentType = PaymentType.card;

      viewModel.onPaymentTypeClick(testPaymentType);

      expect(completerCalls.length, equals(1));
      expect(completerCalls.first.confirmed, isTrue);
      expect(completerCalls.first.data, equals(testPaymentType));
    });

    test("onPaymentTypeClick should work with wallet payment type", () {
      const PaymentType testPaymentType = PaymentType.wallet;

      viewModel.onPaymentTypeClick(testPaymentType);

      expect(completerCalls.length, equals(1));
      expect(completerCalls.first.confirmed, isTrue);
      expect(completerCalls.first.data, equals(testPaymentType));
    });

    test("onPaymentTypeClick should work with dcb payment type", () {
      const PaymentType testPaymentType = PaymentType.dcb;

      viewModel.onPaymentTypeClick(testPaymentType);

      expect(completerCalls.length, equals(1));
      expect(completerCalls.first.confirmed, isTrue);
      expect(completerCalls.first.data, equals(testPaymentType));
    });
  });
}
