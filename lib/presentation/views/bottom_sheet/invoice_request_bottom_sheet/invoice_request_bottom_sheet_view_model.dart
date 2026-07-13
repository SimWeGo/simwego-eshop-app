import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/data/remote/request/user/invoice_request_model.dart";
import "package:esim_open_source/data/remote/responses/empty_response.dart";
import "package:esim_open_source/data/remote/responses/user/order_history_response_model.dart";
import "package:esim_open_source/di/locator.dart";
import "package:esim_open_source/domain/repository/api_user_repository.dart";
import "package:esim_open_source/domain/use_case/user/request_invoice_use_case.dart";
import "package:esim_open_source/domain/util/resource.dart";
import "package:esim_open_source/presentation/extensions/helper_extensions.dart";
import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/base/base_model.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:flutter/material.dart";
import "package:stacked_services/stacked_services.dart";

class InvoiceRequestBottomSheetViewModel extends BaseModel {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController legalFormController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController registrationController = TextEditingController();
  final TextEditingController vatController = TextEditingController();
  final TextEditingController billingEmailController = TextEditingController();
  final TextEditingController contactNameController = TextEditingController();

  late OrderHistoryResponseModel order;
  late Function(SheetResponse<EmptyBottomSheetResponse>) completer;

  final RequestInvoiceUseCase _requestInvoiceUseCase =
      RequestInvoiceUseCase(locator<ApiUserRepository>());

  // Per-field validation errors (null = no error). Mirrors backend CDC B.3.
  String? companyNameError;
  String? streetError;
  String? postalCodeError;
  String? cityError;
  String? countryError;
  String? registrationError;
  String? vatError;
  String? billingEmailError;

  bool isSubmitting = false;
  bool submitted = false;

  String get orderReference => order.orderNumber ?? "";

  static const Set<String> _frCountry = <String>{"fr", "france"};
  static final RegExp _vatRegex = RegExp(r"^[A-Z]{2}[0-9A-Z]{2,13}$");
  static final RegExp _frVatRegex = RegExp(r"^FR[0-9A-Z]{2}[0-9]{9}$");

  @override
  void onViewModelReady() {
    super.onViewModelReady();
    // Pre-fill the billing email with the account email (CDC B.1), editable.
    billingEmailController.text = userEmailAddress;
  }

  void closeBottomSheet() {
    hideKeyboard();
    completer(SheetResponse<EmptyBottomSheetResponse>());
  }

  bool _validate() {
    companyNameError =
        companyNameController.text.trim().isEmpty ? _requiredMsg : null;
    streetError = streetController.text.trim().isEmpty ? _requiredMsg : null;
    postalCodeError =
        postalCodeController.text.trim().isEmpty ? _requiredMsg : null;
    cityError = cityController.text.trim().isEmpty ? _requiredMsg : null;
    countryError = countryController.text.trim().isEmpty ? _requiredMsg : null;

    registrationError = _validateRegistration(registrationController.text);
    billingEmailError = _validateEmail(billingEmailController.text);
    vatError = _validateVat(
      vatController.text,
      countryController.text,
    );

    notifyListeners();
    return companyNameError == null &&
        streetError == null &&
        postalCodeError == null &&
        cityError == null &&
        countryError == null &&
        registrationError == null &&
        billingEmailError == null &&
        vatError == null;
  }

  String get _requiredMsg => LocaleKeys.invoiceRequest_requiredField.tr();

  String? _validateRegistration(String value) {
    final String digits = value.replaceAll(RegExp(r"\s"), "");
    if (digits.isEmpty) {
      return _requiredMsg;
    }
    final bool valid =
        RegExp(r"^\d+$").hasMatch(digits) && (digits.length == 9 || digits.length == 14);
    return valid ? null : LocaleKeys.invoiceRequest_invalidRegistration.tr();
  }

  String? _validateEmail(String value) {
    final String email = value.trim();
    if (email.isEmpty) {
      return _requiredMsg;
    }
    return email.isValidEmail()
        ? null
        : LocaleKeys.enter_a_valid_email_address.tr();
  }

  String? _validateVat(String vatValue, String countryValue) {
    final String vat = vatValue.replaceAll(RegExp(r"\s"), "").toUpperCase();
    final String country = countryValue.trim().toLowerCase();
    final bool outsideFrance = country.isNotEmpty && !_frCountry.contains(country);

    if (vat.isEmpty) {
      // Required for customers established outside France (CDC B.1/B.3).
      return outsideFrance
          ? LocaleKeys.invoiceRequest_vatRequiredOutsideFrance.tr()
          : null;
    }
    if (vat.startsWith("FR")) {
      return _frVatRegex.hasMatch(vat)
          ? null
          : LocaleKeys.invoiceRequest_invalidVatFrance.tr();
    }
    return _vatRegex.hasMatch(vat)
        ? null
        : LocaleKeys.invoiceRequest_invalidVat.tr();
  }

  Future<void> onSubmit() async {
    if (isSubmitting) {
      return;
    }
    hideKeyboard();
    if (!_validate()) {
      return;
    }

    final String? vat = vatController.text.trim().isEmpty
        ? null
        : vatController.text.replaceAll(RegExp(r"\s"), "").toUpperCase();

    final InvoiceRequestModel body = InvoiceRequestModel(
      companyName: companyNameController.text.trim(),
      legalForm: _orNull(legalFormController.text),
      addressStreet: streetController.text.trim(),
      addressPostalCode: postalCodeController.text.trim(),
      addressCity: cityController.text.trim(),
      addressCountry: countryController.text.trim(),
      registrationNumber: registrationController.text.replaceAll(RegExp(r"\s"), ""),
      vatNumber: vat,
      billingEmail: billingEmailController.text.trim(),
      contactName: _orNull(contactNameController.text),
    );

    isSubmitting = true;
    notifyListeners();

    final Resource<EmptyResponse?> result =
        await _requestInvoiceUseCase.execute(
      RequestInvoiceParams(orderID: orderReference, body: body),
    );

    isSubmitting = false;
    await handleResponse(
      result,
      onSuccess: (Resource<EmptyResponse?> _) async {
        submitted = true;
        notifyListeners();
      },
      onFailure: (Resource<EmptyResponse?> res) async {
        notifyListeners();
        await handleError(res);
      },
    );
  }

  String? _orNull(String value) {
    final String trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
