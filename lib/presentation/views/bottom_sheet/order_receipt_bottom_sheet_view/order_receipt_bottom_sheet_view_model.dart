import "dart:async";

import "package:esim_open_source/data/remote/responses/user/order_history_response_model.dart";
import "package:esim_open_source/data/remote/responses/user/receipt_snapshot_response_model.dart";
import "package:esim_open_source/di/locator.dart";
import "package:esim_open_source/domain/repository/api_user_repository.dart";
import "package:esim_open_source/domain/use_case/user/get_order_receipt_use_case.dart";
import "package:esim_open_source/domain/util/resource.dart";
import "package:esim_open_source/presentation/enums/view_state.dart";
import "package:esim_open_source/presentation/views/base/base_model.dart";
import "package:esim_open_source/utils/file_helper.dart";
import "package:flutter/cupertino.dart";

class OrderReceiptBottomSheetViewModel extends BaseModel {
  late OrderHistoryResponseModel? bundleOrderModel;

  final GlobalKey globalKey = GlobalKey();

  final GetOrderReceiptUseCase _getOrderReceiptUseCase =
      GetOrderReceiptUseCase(locator<ApiUserRepository>());

  // Frozen fiscal snapshot fetched from the backend (source of truth for the
  // receipt — never rebuilt from live order/account data). CDC Partie A.
  ReceiptSnapshotResponseModel? receipt;
  bool loadFailed = false;

  @override
  void onViewModelReady() {
    super.onViewModelReady();
    unawaited(fetchReceipt());
  }

  Future<void> fetchReceipt() async {
    receipt = null;
    loadFailed = false;

    final String orderID = bundleOrderModel?.orderNumber ?? "";
    if (orderID.isEmpty) {
      loadFailed = true;
      notifyListeners();
      return;
    }

    setViewState(ViewState.busy);
    final Resource<ReceiptSnapshotResponseModel?> response =
        await _getOrderReceiptUseCase.execute(
      GetOrderReceiptParams(orderID: orderID),
    );
    await handleResponse(
      response,
      onSuccess: (Resource<ReceiptSnapshotResponseModel?> result) async {
        receipt = result.data;
        loadFailed = receipt == null;
      },
      onFailure: (Resource<ReceiptSnapshotResponseModel?> result) async {
        loadFailed = true;
      },
    );
    setViewState(ViewState.idle);
  }

  Future<void> savePdf() async {
    await capturePdfAndShare(
      globalKey: globalKey,
      pdfFileName: receipt?.product?.designation ??
          bundleOrderModel?.bundleDetails?.bundleName ??
          "",
    );
  }
}
