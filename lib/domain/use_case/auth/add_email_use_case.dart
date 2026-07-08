import "dart:async";

import "package:esim_open_source/app/app.locator.dart";
import "package:esim_open_source/data/remote/responses/auth/auth_response_model.dart";
import "package:esim_open_source/domain/repository/api_auth_repository.dart";
import "package:esim_open_source/domain/use_case/base_use_case.dart";
import "package:esim_open_source/domain/util/resource.dart";
import "package:esim_open_source/presentation/reactive_service/user_authentication_service.dart";

/// Adds a missing email to the current account.
///
/// Unlike [UpdateUserInfoUseCase] — which drops the email for every tenant
/// whose configured LoginType is not phoneNumber — this always sends the
/// email. It is the "add your email" flow for social-login accounts (Sign in
/// with Apple "Hide My Email") that have none, so they can receive their eSIM
/// QR + receipt. The backend persists it and, if the account had no auth
/// email, sets it too. Refreshes the local auth state on success.
class AddEmailUseCase implements UseCase<Resource<AuthResponseModel>, String> {
  AddEmailUseCase(this.repository);

  final ApiAuthRepository repository;

  final UserAuthenticationService userAuthenticationService =
      locator<UserAuthenticationService>();

  @override
  FutureOr<Resource<AuthResponseModel>> execute(String email) async {
    final Resource<AuthResponseModel> response =
        await repository.updateUserInfo(email: email);
    await userAuthenticationService.updateUserResponse(response.data);
    return response;
  }
}
