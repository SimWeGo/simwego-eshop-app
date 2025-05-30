import "dart:async";

import "package:esim_open_source/domain/repository/api_user_repository.dart";
import "package:esim_open_source/domain/use_case/base_use_case.dart";
import "package:esim_open_source/domain/util/resource.dart";

class GetBundleExistsUseCase
    implements UseCase<Resource<bool?>, BundleExistsParams> {
  GetBundleExistsUseCase(this.repository);

  final ApiUserRepository repository;

  @override
  FutureOr<Resource<bool?>> execute(BundleExistsParams params) async {
    return await repository.getBundleExists(
      code: params.code,
    );
  }
}

class BundleExistsParams {
  BundleExistsParams({required this.code});

  final String code;
}
