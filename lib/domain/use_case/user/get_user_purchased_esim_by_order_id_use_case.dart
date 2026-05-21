import "dart:async";

import "package:esim_open_source/data/remote/responses/bundles/purchase_esim_bundle_response_model.dart";
import "package:esim_open_source/domain/repository/api_user_repository.dart";
import "package:esim_open_source/domain/use_case/base_use_case.dart";
import "package:esim_open_source/domain/util/resource.dart";

class GetUserPurchasedEsimByOrderIdUseCase
    implements
        UseCase<Resource<PurchaseEsimBundleResponseModel?>,
            GetUserPurchasedEsimByOrderIdParam> {
  GetUserPurchasedEsimByOrderIdUseCase(this.repository);

  final ApiUserRepository repository;

  @override
  FutureOr<Resource<PurchaseEsimBundleResponseModel?>> execute(
    GetUserPurchasedEsimByOrderIdParam params,
  ) async {
    return await repository.getMyEsimByOrder(
      orderID: params.orderID,
    );
  }
}

class GetUserPurchasedEsimByOrderIdParam {
  GetUserPurchasedEsimByOrderIdParam({
    required this.orderID,
  });

  final String orderID;
}
