import "dart:async";

import "package:esim_open_source/data/remote/responses/user/receipt_snapshot_response_model.dart";
import "package:esim_open_source/domain/repository/api_user_repository.dart";
import "package:esim_open_source/domain/use_case/base_use_case.dart";
import "package:esim_open_source/domain/util/resource.dart";

class GetOrderReceiptParams {
  GetOrderReceiptParams({required this.orderID});

  final String orderID;
}

class GetOrderReceiptUseCase
    implements
        UseCase<Resource<ReceiptSnapshotResponseModel?>,
            GetOrderReceiptParams> {
  GetOrderReceiptUseCase(this.repository);

  final ApiUserRepository repository;

  @override
  FutureOr<Resource<ReceiptSnapshotResponseModel?>> execute(
    GetOrderReceiptParams params,
  ) async {
    return await repository.getOrderReceipt(
      orderID: params.orderID,
    );
  }
}
