import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/presentation/extensions/helper_extensions.dart";
import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/base/base_model.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:flutter/cupertino.dart";
import "package:stacked_services/stacked_services.dart";

class AddEmailBottomSheetViewModel extends BaseModel {
  final TextEditingController controller = TextEditingController();

  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  late SheetRequest<AddEmailRequest> request;
  late Function(SheetResponse<MainBottomSheetResponse>) completer;

  @override
  void onViewModelReady() {
    controller.addListener(_inputTextListener);
  }

  void closeBottomSheet() {
    completer(SheetResponse<MainBottomSheetResponse>());
  }

  void _inputTextListener() {
    final String text = controller.text.trim();
    if (text.isEmpty) {
      _errorMessage = "";
      _isButtonEnabled = false;
    } else if (text.isValidEmail()) {
      _errorMessage = "";
      _isButtonEnabled = true;
    } else {
      _errorMessage = LocaleKeys.enter_a_valid_email_address.tr();
      _isButtonEnabled = false;
    }
    notifyListeners();
  }

  void onSaveClick() {
    final String text = controller.text.trim();
    if (!text.isValidEmail()) {
      return;
    }
    completer(
      SheetResponse<MainBottomSheetResponse>(
        data: MainBottomSheetResponse(tag: text, canceled: false),
      ),
    );
  }
}
