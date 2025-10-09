import "package:esim_open_source/presentation/enums/login_type.dart";
import "package:esim_open_source/presentation/enums/payment_type.dart";

abstract class AppConfigurationService {
  Future<void> getAppConfigurations();

  Future<String> get getSupabaseUrl;
  Future<String> get getSupabaseAnon;
  Future<String> get getWhatsAppNumber;
  Future<String> get getCatalogVersion;
  String get getDefaultCurrency;
  List<PaymentType>? get getPaymentTypes;
  LoginType?  get getLoginType;
  String get getCashbackDiscount;
}
