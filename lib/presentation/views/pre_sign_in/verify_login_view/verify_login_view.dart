import "package:easy_localization/easy_localization.dart" as loc;
import "package:esim_open_source/app/environment/app_environment.dart";
import "package:esim_open_source/app/environment/environment_images.dart";
import "package:esim_open_source/di/locator.dart";
import "package:esim_open_source/presentation/enums/login_type.dart";
import "package:esim_open_source/presentation/extensions/context_extension.dart";
import "package:esim_open_source/presentation/extensions/helper_extensions.dart";
import "package:esim_open_source/presentation/shared/in_app_redirection_heper.dart";
import "package:esim_open_source/presentation/shared/shared_styles.dart";
import "package:esim_open_source/presentation/shared/ui_helpers.dart";
import "package:esim_open_source/presentation/views/base/base_view.dart";
import "package:esim_open_source/presentation/views/pre_sign_in/verify_login_view/verify_login_view_model.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:esim_open_source/presentation/widgets/otp_text_field.dart";
import "package:esim_open_source/presentation/widgets/padding_widget.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:flutter/foundation.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class VerifyLoginViewArgs {
  VerifyLoginViewArgs({
    required this.email,
    required this.phoneNumber,
    required this.otpExpiration,
    this.redirection,
    this.localLoginType,
  });

  final String? email;
  final String? phoneNumber;
  final int? otpExpiration;
  final InAppRedirection? redirection;
  final LoginType? localLoginType;
}

class VerifyLoginView extends StatelessWidget {
  const VerifyLoginView({
    required this.email,
    required this.phoneNumber,
    this.redirection,
    LoginType? localLoginType,
    super.key,
  }) : _localLoginType = localLoginType;

  final String? email;
  final String? phoneNumber;
  static const String routeName = "VerifyLoginView";
  final InAppRedirection? redirection;
  final LoginType? _localLoginType;

  LoginType get localLoginType =>
      _localLoginType ?? AppEnvironment.appEnvironmentHelper.loginType;

  double calculateFieldWidth({
    required BuildContext context,
    double maximumSize = 60,
  }) {
    double availableSpace =
        MediaQuery.of(context).size.width - (2 * 15) - (6 * 10);
    double singleSize = availableSpace / 6;
    if (singleSize > maximumSize) {
      return maximumSize;
    }
    return singleSize;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyLoginViewModel>(
      routeName: routeName,
      hideAppBar: true,
      viewModel: locator<VerifyLoginViewModel>()
        ..email = email
        ..phoneNumber = phoneNumber
        ..redirection = redirection,
      builder: (
        BuildContext context,
        VerifyLoginViewModel viewModel,
        Widget? childWidget,
        double screenHeight,
      ) =>
          PaddingWidget.applySymmetricPadding(
        horizontal: 15,
        child: SizedBox.expand(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: viewModel.navigationService.back,
                  child: Image.asset(
                    EnvironmentImages.navBackIcon.fullImagePath,
                    width: 25,
                    height: 25,
                  ),
                ).imageSupportsRTL(context).textSupportsRTL(context),
              ),
              verticalSpaceMediumLarge,
              Text(
                getVerifyLoginTitleText(),
                style: headerTwoMediumTextStyle(
                  context: context,
                  fontColor: mainDarkTextColor(context: context),
                ),
              ),
              verticalSpaceSmall,
              Text(
                LocaleKeys.verifyLogin_contentText.tr(),
                textAlign: TextAlign.center,
                style: bodyNormalTextStyle(
                  context: context,
                  fontColor: secondaryTextColor(context: context),
                ),
              ),
              verticalSpaceLarge,
              Column(
                children: <Widget>[
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: OtpTextField(
                      borderWidth: 1,
                      numberOfFields: 6,
                      showFieldAsBox: true,
                      contentPadding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(8),
                      fieldWidth: calculateFieldWidth(context: context),
                      focusedBorderColor: viewModel.errorMessage.isEmpty
                          ? context.appColors.grey_200!
                          : context.appColors.error_500!,
                      enabledBorderColor: viewModel.errorMessage.isEmpty
                          ? context.appColors.grey_200!
                          : context.appColors.error_500!,
                      textStyle:
                          headerZeroMediumTextStyle(context: context).copyWith(
                        color: viewModel.errorMessage.isEmpty
                            ? context.appColors.baseBlack
                            : context.appColors.error_500,
                      ),
                      onCodeChanged: viewModel.otpFieldChanged,
                      onSubmit: (String verificationCode) async {
                        viewModel.otpFieldSubmitted(verificationCode);
                      },
                      initialCode: viewModel.initialVerificationCode,
                    ),
                  ),
                  verticalSpaceSmall,
                  Text(
                    viewModel.errorMessage,
                    style: captionOneNormalTextStyle(
                      context: context,
                      fontColor: errorTextColor(context: context),
                    ),
                  ),
                ],
              ),
              verticalSpaceLarge,
              MainButton(
                title: getVerifyLoginMainButtonText(),
                onPressed: () async {
                  viewModel.verifyButtonTapped();
                },
                themeColor: themeColor,
                height: 53,
                hideShadows: true,
                isEnabled: viewModel.isVerifyButtonEnabled,
                enabledTextColor: enabledMainButtonTextColor(context: context),
                disabledTextColor:
                    disabledMainButtonTextColor(context: context),
                enabledBackgroundColor:
                    enabledMainButtonColor(context: context),
                disabledBackgroundColor:
                    disabledMainButtonColor(context: context),
              ),
              verticalSpaceMediumLarge,
              resendCodeTappableWidget(
                context,
                viewModel,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget resendCodeTappableWidget(
    BuildContext context,
    VerifyLoginViewModel viewModel,
  ) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: getResendCodeText(),
        style: captionOneNormalTextStyle(
          context: context,
          fontColor: secondaryTextColor(context: context),
        ),
        children: <TextSpan>[
          TextSpan(
            text: LocaleKeys.verifyLogin_resendCode.tr(),
            style: captionOneMediumTextStyle(
              context: context,
              fontColor: hyperLinkColor(context: context),
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                viewModel.resendCodeButtonTapped();
              },
          ),
        ],
      ),
    );
  }

  String getResendCodeText() {
    switch (localLoginType) {
      case LoginType.email:
        return LocaleKeys.verifyLogin_checkEmail.tr();
      case LoginType.phoneNumber:
      case LoginType.emailAndPhone:
        return LocaleKeys.verifyLogin_checkPhone.tr();
    }
  }

  String getVerifyLoginTitleText() {
    switch (localLoginType) {
      case LoginType.email:
        return LocaleKeys.verifyLogin_titleText.tr();
      case LoginType.phoneNumber:
      case LoginType.emailAndPhone:
        return LocaleKeys.verifyLogin_titleTextPhone.tr();
    }
  }

  String getVerifyLoginMainButtonText() {
    switch (localLoginType) {
      case LoginType.email:
        return LocaleKeys.verifyLogin_buttonTitleText.tr();
      case LoginType.phoneNumber:
      case LoginType.emailAndPhone:
        return LocaleKeys.verifyLogin_buttonTitleTextPhone.tr();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<InAppRedirection?>("redirection", redirection),
      )
      ..add(StringProperty("email", email))
      ..add(StringProperty("phoneNumber", phoneNumber))
      ..add(EnumProperty<LoginType>("localLoginType", localLoginType));
  }
}
