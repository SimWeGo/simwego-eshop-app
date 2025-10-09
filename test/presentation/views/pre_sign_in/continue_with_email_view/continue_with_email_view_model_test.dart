// continue_with_email_view_model_test.dart

import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/data/remote/responses/auth/otp_response_model.dart";
import "package:esim_open_source/domain/repository/api_auth_repository.dart";
import "package:esim_open_source/domain/repository/services/app_configuration_service.dart";
import "package:esim_open_source/domain/util/resource.dart";
import "package:esim_open_source/presentation/enums/bottomsheet_type.dart";
import "package:esim_open_source/presentation/enums/login_type.dart";
import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/pre_sign_in/continue_with_email_view/continue_with_email_view_model.dart";
import "package:esim_open_source/presentation/views/pre_sign_in/verify_login_view/verify_login_view.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";
import "../../../../locator_test.dart";

Future<void> main() async {
  // ensure system up
  await prepareTest();
  late ContinueWithEmailViewModel viewModel;

  setUp(() async {
    await setupTest();
    viewModel = ContinueWithEmailViewModel();
  });

  group("View Model Testing", () {
    test("Back button tapped", () {
      when(locator<NavigationService>().back()).thenReturn(true);
      viewModel.backButtonTapped();
      verify(locator<NavigationService>().back()).called(1);
    });

    test("Update terms selection tapped", () {
      viewModel.state?.isTermsChecked = false;
      viewModel.updateTermsSelections();
      expect(viewModel.state?.isTermsChecked, true);
    });

    test("Email address validation error", () {
      viewModel.state?.emailController.text = "raed.com";
      String result = viewModel
          .validateEmailAddress(viewModel.state?.emailController.text ?? "");
      expect(result, LocaleKeys.enter_a_valid_email_address.tr());
    });

    test("Initial state is correct", () {
      expect(viewModel.state?.isLoginEnabled, false);
      expect(viewModel.state?.isTermsChecked, false);
      expect(viewModel.state?.emailErrorMessage, isNull);
    });

    test("validateEmailAddress returns required field error when empty", () {
      expect(viewModel.validateEmailAddress(""), isNotEmpty);
    });

    test("validateEmailAddress returns valid for proper email", () {
      expect(viewModel.validateEmailAddress("test@example.com"), "");
    });

    test("validateForm enables login only with valid email and terms checked",
        () async {
      onViewModelReadyMock();
      viewModel.onViewModelReady();

      viewModel.state?.isTermsChecked = true;
      viewModel.state?.emailController.text = "test@example.com";

      expect(viewModel.state?.isLoginEnabled, true);
      expect(viewModel.state?.emailErrorMessage, "");
    });

    test("loginWithEmail navigates to verify view on success", () async {
      when(locator<AppConfigurationService>().getLoginType)
          .thenReturn(LoginType.email);
      viewModel.state?.isTermsChecked = true;
      viewModel.state?.emailController.text = "test@example.com";
      viewModel.state?.emailErrorMessage = "";
      when(
        locator<ApiAuthRepository>().login(
          email: "test@example.com",
          phoneNumber: null,
        ),
      ).thenAnswer(
        (_) async => Resource<OtpResponseModel?>.success(OtpResponseModel(),
            message: ""),
      );

      when(
        locator<NavigationService>().navigateTo(
          "VerifyLoginView",
          arguments: argThat(
            isA<VerifyLoginViewArgs>()
                .having(
                  (VerifyLoginViewArgs args) => args.email,
                  "email",
                  "test@example.com",
                )
                .having(
                  (VerifyLoginViewArgs args) => args.redirection,
                  "redirection",
                  null,
                ),
            named: "arguments",
          ),
        ),
      ).thenAnswer((_) async => true);

      await viewModel.loginButtonTapped();

      verify(
        locator<NavigationService>().navigateTo(
          "VerifyLoginView",
          arguments: argThat(
            isA<VerifyLoginViewArgs>()
                .having(
                  (VerifyLoginViewArgs args) => args.email,
                  "email",
                  "test@example.com",
                )
                .having(
                  (VerifyLoginViewArgs args) => args.redirection,
                  "redirection",
                  null,
                ),
            named: "arguments",
          ),
        ),
      ).called(1);
    });

    test("showTermsSheet sets isTermsChecked to true when confirmed", () async {
      when(
        locator<BottomSheetService>().showCustomSheet(
          variant: BottomSheetType.termsCondition,
          isScrollControlled: true,
          enableDrag: false,
        ),
      ).thenAnswer(
        (_) async => SheetResponse<EmptyBottomSheetResponse>(confirmed: true),
      );

      await viewModel.showTermsSheet();

      expect(viewModel.state?.isTermsChecked, true);
    });

    test("validateNumber called", () {
      viewModel.validateNumber(code: "1", number: "123", isValid: true);
    });

    test("Update terms selection tapped cover lines", () {
      when(locator<AppConfigurationService>().getLoginType)
          .thenReturn(LoginType.phoneNumber);
      viewModel.state?.isTermsChecked = false;
      viewModel.updateTermsSelections();
      expect(viewModel.state?.isTermsChecked, true);
    });
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });
}
