import "dart:async";

import "package:esim_open_source/data/remote/responses/app/dynamic_page_response.dart";
import "package:esim_open_source/di/locator.dart";
import "package:esim_open_source/domain/repository/api_app_repository.dart";
import "package:esim_open_source/domain/repository/services/local_storage_service.dart";
import "package:esim_open_source/domain/use_case/base_use_case.dart";
import "package:esim_open_source/domain/util/resource.dart";
import "package:esim_open_source/presentation/helpers/language_response_wrapper.dart";

class GetAboutUsUseCase
    implements UseCase<Resource<DynamicPageResponse?>, NoParams> {
  GetAboutUsUseCase(this.repository);
  final ApiAppRepository repository;
  static LanguageResponseWrapper<Resource<DynamicPageResponse?>>?
      previousResponse;

  @override
  FutureOr<Resource<DynamicPageResponse?>> execute(NoParams? params) async {
    if (previousResponse != null &&
        previousResponse!.code == locator<LocalStorageService>().languageCode) {
      return previousResponse!.data;
    }

    Resource<DynamicPageResponse?> response = await repository.getAboutUs();
    switch (response.resourceType) {
      case ResourceType.success:
        previousResponse =
            LanguageResponseWrapper<Resource<DynamicPageResponse?>>(
          data: response,
          code: locator<LocalStorageService>().languageCode,
        );
      case ResourceType.error:
      case ResourceType.loading:
    }
    return response;
  }
}
