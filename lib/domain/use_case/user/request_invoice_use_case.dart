import "dart:async";

import "package:esim_open_source/data/remote/request/user/invoice_request_model.dart";
import "package:esim_open_source/data/remote/responses/empty_response.dart";
import "package:esim_open_source/domain/repository/api_user_repository.dart";
import "package:esim_open_source/domain/use_case/base_use_case.dart";
import "package:esim_open_source/domain/util/resource.dart";

class RequestInvoiceParams {
  RequestInvoiceParams({required this.orderID, required this.body});

  final String orderID;
  final InvoiceRequestModel body;
}

class RequestInvoiceUseCase
    implements UseCase<Resource<EmptyResponse?>, RequestInvoiceParams> {
  RequestInvoiceUseCase(this.repository);

  final ApiUserRepository repository;

  @override
  FutureOr<Resource<EmptyResponse?>> execute(
    RequestInvoiceParams params,
  ) async {
    return await repository.requestInvoice(
      orderID: params.orderID,
      body: params.body,
    );
  }
}
