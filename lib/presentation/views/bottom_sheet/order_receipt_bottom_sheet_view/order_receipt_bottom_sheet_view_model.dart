import "dart:async";
import "dart:typed_data";

import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/data/remote/responses/user/order_history_response_model.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:esim_open_source/data/remote/responses/user/receipt_snapshot_response_model.dart";
import "package:esim_open_source/di/locator.dart";
import "package:esim_open_source/domain/repository/api_user_repository.dart";
import "package:esim_open_source/domain/use_case/user/get_order_receipt_use_case.dart";
import "package:esim_open_source/domain/util/resource.dart";
import "package:esim_open_source/presentation/enums/view_state.dart";
import "package:esim_open_source/presentation/views/base/base_model.dart";
import "package:esim_open_source/utils/display_message_helper.dart";
import "package:esim_open_source/utils/file_helper.dart";
import "package:esim_open_source/utils/receipt_pdf_builder.dart";
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

  Future<void> savePdf({Rect? sharePositionOrigin}) async {
    try {
      final ReceiptSnapshotResponseModel? snapshot = receipt;
      // The receipt is generated from the frozen backend snapshot (like the
      // website), not from a screenshot of the widget — so the download can't
      // fail because the receipt is longer than the screen.
      if (snapshot == null) {
        DisplayMessageHelper.toast(LocaleKeys.error_somethingWentWrong.tr());
        return;
      }

      final String fileName = snapshot.product?.designation ??
          bundleOrderModel?.bundleDetails?.bundleName ??
          "receipt";

      final Uint8List bytes = await buildReceiptPdf(snapshot);
      await saveAndSharePdfBytes(
        bytes: bytes,
        fileName: fileName,
        sharePositionOrigin: sharePositionOrigin,
      );
    } on Object catch (e) {
      // TEMP diagnostic: PDF generation (buildReceiptPdf) was not wrapped, so a
      // throw here surfaced as nothing. Show the real error.
      DisplayMessageHelper.toast("Reçu: $e");
    }
  }
}
