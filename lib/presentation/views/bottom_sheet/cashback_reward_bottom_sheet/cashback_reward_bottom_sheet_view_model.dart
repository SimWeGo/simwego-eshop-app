import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/base/base_model.dart";
import "package:stacked_services/stacked_services.dart";

class CashbackRewardBottomSheetViewModel extends BaseModel {
  // CashbackRewardBottomSheetViewModel(
  //     {required this.request, required this.completer,});

  late SheetRequest<CashbackRewardBottomRequest> request;
  late Function(SheetResponse<EmptyBottomSheetResponse>) completer;
}
