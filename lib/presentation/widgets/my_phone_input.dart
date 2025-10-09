import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/presentation/extensions/context_extension.dart";
import "package:esim_open_source/presentation/shared/shared_styles.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:phone_input/phone_input_package.dart";

class MyPhoneInput extends StatelessWidget {
  const MyPhoneInput({
    required this.onChanged,
    required this.phoneController,
    this.validateRequired = false,
    this.validateEmpty = false,
    this.enabled = true,
    super.key,
  });

  final Function(
    String countryCode,
    String phoneNumber, {
    required bool isValid,
  }) onChanged;

  final PhoneController phoneController;
  final bool validateRequired;
  final bool validateEmpty;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    // Define colors based on enabled state
    final Color? textColor = enabled
        ? context.appColors.grey_900
        : context.appColors
            .grey_400; // Use grey_400 or any lighter grey for disabled state

    final Color? hintColor = enabled
        ? secondaryTextColor(context: context)
        : context.appColors.grey_300; // Even lighter grey for disabled hint

    final Color borderColor = enabled
        ? context.appColors.grey_200!
        : context.appColors.grey_100!; // Lighter border for disabled state

    final PhoneInput phoneInput = PhoneInput(
      enabled: enabled,
      controller: phoneController,
      style: bodyNormalTextStyle(
        context: context,
      ).copyWith(
        color: textColor,
      ),
      countryCodeStyle: bodyNormalTextStyle(context: context).copyWith(
        color: textColor,
      ),
      defaultCountry: IsoCode.LB,
      autovalidateMode:
          enabled ? AutovalidateMode.always : AutovalidateMode.disabled,
      validator: enabled
          ? PhoneValidator.compose(
              <PhoneNumberInputValidator>[
                validateEmpty ? PhoneValidator.required() : PhoneValidator.none,
                validateRequired ? PhoneValidator.valid() : PhoneValidator.none,
              ],
            )
          : null,
      // Disable validation when disabled
      flagShape: BoxShape.rectangle,
      decoration: InputDecoration(
        focusColor: Colors.transparent,
        labelText: "",
        hintText: LocaleKeys.phoneInput_placeHolder.tr(),
        hintStyle: captionOneNormalTextStyle(
          context: context,
          fontColor: hintColor,
        ),
        labelStyle: TextStyle(color: enabled ? Colors.red : Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: enabled ? context.appColors.grey_200! : borderColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: enabled ? context.appColors.grey_200! : borderColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        // Add fill color for disabled state
        fillColor: enabled ? null : context.appColors.grey_50,
        // Light grey background
        filled: !enabled,
      ),
      onChanged: enabled
          ? (PhoneNumber? p) => onChanged(
                p?.countryCode ?? "961",
                p?.nsn ?? "",
                isValid: p?.isValid(type: PhoneNumberType.mobile) ?? false,
              )
          : null,
      // Disable callback when disabled
      countrySelectorNavigator: CountrySelectorNavigator.modalBottomSheet(
        searchInputDecoration: InputDecoration(
          focusColor: Colors.green,
          labelText: LocaleKeys.phoneInput_countryPlaceHolder.tr(),
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.appColors.grey_200!),
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.appColors.grey_200!),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        searchInputTextStyle: const TextStyle(color: Colors.black),
      ),
    );

    // If disabled, wrap with AbsorbPointer to completely block all interactions
    return enabled
        ? phoneInput
        : AbsorbPointer(
            child: phoneInput,
          );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        ObjectFlagProperty<
            Function(
              String countryCode,
              String phoneNumber, {
              required bool isValid,
            })>.has("onChanged", onChanged),
      )
      ..add(
        DiagnosticsProperty<PhoneController>(
          "phoneController",
          phoneController,
        ),
      )
      ..add(DiagnosticsProperty<bool>("validateRequired", validateRequired))
      ..add(DiagnosticsProperty<bool>("validateEmpty", validateEmpty))
      ..add(DiagnosticsProperty<bool>("enabled", enabled));
  }
}
