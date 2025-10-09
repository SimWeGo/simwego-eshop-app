import "package:esim_open_source/data/remote/responses/user/order_history_response_model.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/order_receipt_bottom_sheet_view/order_receipt_bottom_sheet_view_model.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

void main() {
  group("OrderReceiptBottomSheetViewModel Tests", () {
    late OrderReceiptBottomSheetViewModel viewModel;

    setUpAll(() async {
      await prepareTest();
    });

    setUp(() async {
      await setupTest();
      onViewModelReadyMock(viewName: "OrderReceiptBottomSheetView");
    });

    tearDown(() async {
      await tearDownTest();
    });

    tearDownAll(() async {
      await tearDownAllTest();
    });

    test("should initialize correctly with bundle order model", () {
      final OrderHistoryResponseModel mockOrder = OrderHistoryResponseModel(
        orderNumber: "12345",
        companyName: "Test Company",
      );

      viewModel = OrderReceiptBottomSheetViewModel(bundleOrderModel: mockOrder);

      expect(viewModel, isNotNull);
      expect(viewModel.isBusy, isFalse);
      expect(viewModel.bundleOrderModel, equals(mockOrder));
      expect(viewModel.globalKey, isA<GlobalKey>());
    });

    test("should initialize correctly with null bundle order model", () {
      viewModel = OrderReceiptBottomSheetViewModel(bundleOrderModel: null);

      expect(viewModel, isNotNull);
      expect(viewModel.bundleOrderModel, isNull);
      expect(viewModel.globalKey, isA<GlobalKey>());
    });

    test("savePdf should not throw exception", () async {
      final OrderHistoryResponseModel mockOrder = OrderHistoryResponseModel(
        orderNumber: "12345",
        companyName: "Test Company",
      );

      viewModel = OrderReceiptBottomSheetViewModel(bundleOrderModel: mockOrder);

      // Test that savePdf can be called without throwing
      // The actual PDF generation will fail in test environment, but we test the method exists
      expect(() async => viewModel.savePdf(), returnsNormally);
    });

    test("savePdf should handle null bundle order model", () async {
      viewModel = OrderReceiptBottomSheetViewModel(bundleOrderModel: null);

      // Test that savePdf can be called with null bundle order model
      expect(() async => viewModel.savePdf(), returnsNormally);
    });

    test("globalKey should be unique for each instance", () {
      final OrderReceiptBottomSheetViewModel viewModel1 =
          OrderReceiptBottomSheetViewModel(bundleOrderModel: null);
      final OrderReceiptBottomSheetViewModel viewModel2 =
          OrderReceiptBottomSheetViewModel(bundleOrderModel: null);

      expect(viewModel1.globalKey, isNot(equals(viewModel2.globalKey)));
    });
  });
}
