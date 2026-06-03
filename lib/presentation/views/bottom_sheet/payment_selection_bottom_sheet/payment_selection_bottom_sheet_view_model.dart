import "package:esim_open_source/presentation/enums/payment_type.dart";
import "package:esim_open_source/presentation/views/base/base_model.dart";
import "package:stacked_services/stacked_services.dart";

class PaymentSelectionBottomSheetViewModel extends BaseModel {
  PaymentSelectionBottomSheetViewModel({required this.completer});
  final Function(SheetResponse<PaymentType>) completer;

  /// Formatted available wallet balance, e.g. "10.50 EUR". Empty when the user
  /// is not logged in or has no currency set.
  String get walletBalanceDisplay {
    final double balance = userAuthenticationService.walletAvailableBalance;
    final String currency = userAuthenticationService.walletCurrencyCode;
    if (currency.isEmpty) {
      return "";
    }
    return "${balance.toStringAsFixed(2)} $currency";
  }

  void onCloseClick() {
    completer(
      SheetResponse<PaymentType>(),
    );
  }

  void onPaymentTypeClick(PaymentType paymentType) {
    completer(
      SheetResponse<PaymentType>(
        confirmed: true,
        data: paymentType,
      ),
    );
  }
}
