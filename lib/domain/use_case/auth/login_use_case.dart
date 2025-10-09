import "dart:async";

import "package:esim_open_source/data/remote/responses/auth/otp_response_model.dart";
import "package:esim_open_source/domain/repository/api_auth_repository.dart";
import "package:esim_open_source/domain/use_case/base_use_case.dart";
import "package:esim_open_source/domain/util/resource.dart";

class LoginParams {
  LoginParams({
    required this.email,
    required this.phoneNumber,
  });

  final String? email;
  final String? phoneNumber;
}

class LoginUseCase
    implements UseCase<Resource<OtpResponseModel?>, LoginParams> {
  LoginUseCase(this.repository);

  final ApiAuthRepository repository;

  @override
  FutureOr<Resource<OtpResponseModel?>> execute(LoginParams params) async {
    return await repository.login(
      email: params.email,
      phoneNumber: params.phoneNumber,
    );
  }
}
