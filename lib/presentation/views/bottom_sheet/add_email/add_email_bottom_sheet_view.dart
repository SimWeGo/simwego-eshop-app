import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/di/locator.dart";
import "package:esim_open_source/presentation/extensions/context_extension.dart";
import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/shared/shared_styles.dart";
import "package:esim_open_source/presentation/views/base/base_view.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/add_email/add_email_bottom_sheet_view_model.dart";
import "package:esim_open_source/presentation/widgets/bottom_sheet_close_button.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:esim_open_source/presentation/widgets/main_input_field.dart";
import "package:esim_open_source/presentation/widgets/padding_widget.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:stacked_services/stacked_services.dart";

class AddEmailBottomSheetView extends StatelessWidget {
  const AddEmailBottomSheetView({
    required this.request,
    required this.completer,
    super.key,
  });

  final SheetRequest<AddEmailRequest> request;
  final Function(SheetResponse<MainBottomSheetResponse>) completer;

  @override
  Widget build(BuildContext context) {
    return BaseView.bottomSheetBuilder(
      viewModel: locator<AddEmailBottomSheetViewModel>()
        ..request = request
        ..completer = completer,
      builder: (
        BuildContext context,
        AddEmailBottomSheetViewModel viewModel,
        Widget? childWidget,
        double screenHeight,
      ) =>
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          PaddingWidget.applySymmetricPadding(
            vertical: 10,
            horizontal: 15,
            child: BottomSheetCloseButton(
              onTap: viewModel.closeBottomSheet,
            ),
          ),
          PaddingWidget.applyPadding(
            start: 16,
            end: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    LocaleKeys.addEmail_titleText.tr(),
                    style: headerThreeMediumTextStyle(
                      context: context,
                      fontColor: mainDarkTextColor(context: context),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  LocaleKeys.addEmail_subtitleText.tr(),
                  style: bodyNormalTextStyle(
                    context: context,
                    fontColor: secondaryTextColor(context: context),
                  ),
                ),
                const SizedBox(height: 24),
                MainInputField.formField(
                  themeColor: themeColor,
                  labelTitleText:
                      LocaleKeys.continueWithEmailView_emailTitleField.tr(),
                  hintText:
                      LocaleKeys.continueWithEmailView_emailPlaceholder.tr(),
                  controller: viewModel.controller,
                  textInputType: TextInputType.emailAddress,
                  errorMessage: viewModel.errorMessage,
                  backGroundColor: context.appColors.baseWhite,
                  labelStyle: bodyNormalTextStyle(
                    context: context,
                    fontColor: secondaryTextColor(context: context),
                  ),
                ),
                const SizedBox(height: 24),
                MainButton(
                  isEnabled: viewModel.isButtonEnabled,
                  title: LocaleKeys.accountInformation_saveText.tr(),
                  onPressed: viewModel.onSaveClick,
                  themeColor: themeColor,
                  hideShadows: true,
                  enabledTextColor: mainWhiteTextColor(context: context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<SheetRequest<AddEmailRequest>>(
          "request",
          request,
        ),
      )
      ..add(
        ObjectFlagProperty<
            Function(SheetResponse<MainBottomSheetResponse> p1)>.has(
          "completer",
          completer,
        ),
      );
  }
}
