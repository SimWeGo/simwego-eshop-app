import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/data/remote/responses/user/order_history_response_model.dart";
import "package:esim_open_source/di/locator.dart";
import "package:esim_open_source/presentation/extensions/context_extension.dart";
import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/shared/shared_styles.dart";
import "package:esim_open_source/presentation/shared/ui_helpers.dart";
import "package:esim_open_source/presentation/views/base/base_view.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/invoice_request_bottom_sheet/invoice_request_bottom_sheet_view_model.dart";
import "package:esim_open_source/presentation/widgets/bottom_sheet_close_button.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:esim_open_source/presentation/widgets/main_input_field.dart";
import "package:esim_open_source/presentation/widgets/padding_widget.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:stacked_services/stacked_services.dart";

class InvoiceRequestBottomSheetView extends StatelessWidget {
  const InvoiceRequestBottomSheetView({
    required this.requestBase,
    required this.completer,
    super.key,
  });

  final SheetRequest<OrderHistoryResponseModel> requestBase;
  final Function(SheetResponse<EmptyBottomSheetResponse>) completer;

  @override
  Widget build(BuildContext context) {
    return BaseView.bottomSheetBuilder(
      viewModel: locator<InvoiceRequestBottomSheetViewModel>()
        ..order = requestBase.data as OrderHistoryResponseModel
        ..completer = completer,
      builder: (
        BuildContext context,
        InvoiceRequestBottomSheetViewModel viewModel,
        Widget? childWidget,
        double screenHeight,
      ) =>
          DecoratedBox(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
        child: SizedBox(
          width: screenWidth(context),
          child: PaddingWidget.applySymmetricPadding(
            vertical: 15,
            horizontal: 15,
            child: viewModel.submitted
                ? _buildSuccess(context, viewModel)
                : _buildForm(context, viewModel),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    InvoiceRequestBottomSheetViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        BottomSheetCloseButton(
          onTap: viewModel.closeBottomSheet,
        ),
        Center(
          child: Text(
            LocaleKeys.invoiceRequest_title.tr(),
            style: headerThreeMediumTextStyle(
              context: context,
              fontColor: mainDarkTextColor(context: context),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          LocaleKeys.invoiceRequest_subtitle.tr(),
          style: bodyNormalTextStyle(
            context: context,
            fontColor: secondaryTextColor(context: context),
          ),
        ),
        const SizedBox(height: 16),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Order reference: pre-filled, read-only (links invoice to order).
                _readOnlyReference(context, viewModel.orderReference),
                verticalSpaceSmall,
                _field(
                  context: context,
                  label: LocaleKeys.invoiceRequest_companyName.tr(),
                  controller: viewModel.companyNameController,
                  error: viewModel.companyNameError,
                ),
                _field(
                  context: context,
                  label: LocaleKeys.invoiceRequest_legalForm.tr(),
                  controller: viewModel.legalFormController,
                ),
                _field(
                  context: context,
                  label: LocaleKeys.invoiceRequest_addressStreet.tr(),
                  controller: viewModel.streetController,
                  error: viewModel.streetError,
                ),
                _field(
                  context: context,
                  label: LocaleKeys.invoiceRequest_postalCode.tr(),
                  controller: viewModel.postalCodeController,
                  error: viewModel.postalCodeError,
                ),
                _field(
                  context: context,
                  label: LocaleKeys.invoiceRequest_city.tr(),
                  controller: viewModel.cityController,
                  error: viewModel.cityError,
                ),
                _field(
                  context: context,
                  label: LocaleKeys.invoiceRequest_country.tr(),
                  controller: viewModel.countryController,
                  error: viewModel.countryError,
                ),
                _field(
                  context: context,
                  label: LocaleKeys.invoiceRequest_registrationNumber.tr(),
                  controller: viewModel.registrationController,
                  error: viewModel.registrationError,
                  keyboardType: TextInputType.number,
                ),
                _field(
                  context: context,
                  label: LocaleKeys.invoiceRequest_vatNumber.tr(),
                  controller: viewModel.vatController,
                  error: viewModel.vatError,
                ),
                _field(
                  context: context,
                  label: LocaleKeys.invoiceRequest_billingEmail.tr(),
                  controller: viewModel.billingEmailController,
                  error: viewModel.billingEmailError,
                  keyboardType: TextInputType.emailAddress,
                ),
                _field(
                  context: context,
                  label: LocaleKeys.invoiceRequest_contactName.tr(),
                  controller: viewModel.contactNameController,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        MainButton(
          isEnabled: !viewModel.isSubmitting,
          title: LocaleKeys.invoiceRequest_submit.tr(),
          onPressed: viewModel.onSubmit,
          themeColor: themeColor,
          hideShadows: true,
          enabledTextColor: mainWhiteTextColor(context: context),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSuccess(
    BuildContext context,
    InvoiceRequestBottomSheetViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: BottomSheetCloseButton(
            onTap: viewModel.closeBottomSheet,
          ),
        ),
        const SizedBox(height: 8),
        Icon(
          Icons.check_circle_outline,
          size: 56,
          color: themeColor,
        ),
        const SizedBox(height: 16),
        Text(
          LocaleKeys.invoiceRequest_successTitle.tr(),
          textAlign: TextAlign.center,
          style: headerThreeMediumTextStyle(
            context: context,
            fontColor: mainDarkTextColor(context: context),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          LocaleKeys.invoiceRequest_successMessage.tr(),
          textAlign: TextAlign.center,
          style: bodyNormalTextStyle(
            context: context,
            fontColor: secondaryTextColor(context: context),
          ),
        ),
        const SizedBox(height: 24),
        MainButton(
          title: LocaleKeys.invoiceRequest_close.tr(),
          onPressed: viewModel.closeBottomSheet,
          themeColor: themeColor,
          hideShadows: true,
          enabledTextColor: mainWhiteTextColor(context: context),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _readOnlyReference(BuildContext context, String reference) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          LocaleKeys.invoiceRequest_orderReference.tr(),
          style: bodyNormalTextStyle(
            context: context,
            fontColor: secondaryTextColor(context: context),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          reference,
          style: bodyBoldTextStyle(
            context: context,
            fontColor: mainDarkTextColor(context: context),
          ),
        ),
      ],
    );
  }

  Widget _field({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    String? error,
    TextInputType? keyboardType,
  }) {
    return PaddingWidget.applySymmetricPadding(
      vertical: 6,
      horizontal: 0,
      child: MainInputField.formField(
        themeColor: themeColor,
        labelTitleText: label,
        controller: controller,
        textInputType: keyboardType,
        errorMessage: error,
        backGroundColor: context.appColors.baseWhite,
        labelStyle: bodyNormalTextStyle(
          context: context,
          fontColor: secondaryTextColor(context: context),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<SheetRequest<OrderHistoryResponseModel>>(
          "requestBase",
          requestBase,
        ),
      )
      ..add(
        ObjectFlagProperty<
            Function(SheetResponse<EmptyBottomSheetResponse> p1)>.has(
          "completer",
          completer,
        ),
      );
  }
}
