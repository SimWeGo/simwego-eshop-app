class BundleAssignResponseModel {
  BundleAssignResponseModel({
    this.publishableKey,
    this.merchantIdentifier,
    this.billingCountryCode,
    this.paymentIntentClientSecret,
    this.customerId,
    this.customerEphemeralKeySecret,
    this.testEnv,
    this.hasTax,
    this.merchantDisplayName,
    this.stripeUrlScheme,
    this.orderId,
    this.paymentStatus,
    this.taxPriceDisplay,
    this.subtotalPriceDisplay,
    this.totalPriceDisplay,
    this.otpExpiration,
    this.originalPriceDisplay,
    this.discountAmountDisplay,
    this.promoCodeApplied,
    this.promoCodeRejected,
    this.promoCodeRejectionReason,
  });

  factory BundleAssignResponseModel.fromJson({dynamic json}) {
    return BundleAssignResponseModel(
      publishableKey: json["publishable_key"],
      merchantIdentifier: json["merchant_identifier"],
      billingCountryCode: json["billing_country_code"],
      paymentIntentClientSecret: json["payment_intent_client_secret"],
      customerId: json["customer_id"],
      customerEphemeralKeySecret: json["customer_ephemeral_key_secret"],
      testEnv: json["test_env"],
      hasTax: json["has_tax"],
      merchantDisplayName: json["merchant_display_name"],
      stripeUrlScheme: json["stripe_url_scheme"],
      orderId: json["order_id"],
      paymentStatus: json["payment_status"],
      taxPriceDisplay: json["tax_price_display"],
      totalPriceDisplay: json["total_price_display"],
      subtotalPriceDisplay: json["subtotal_price_display"],
      otpExpiration: json["otp_expiration"],
      originalPriceDisplay: json["original_price_display"],
      discountAmountDisplay: json["discount_amount_display"],
      promoCodeApplied: json["promo_code_applied"],
      promoCodeRejected: json["promo_code_rejected"],
      promoCodeRejectionReason: json["promo_code_rejection_reason"],
    );
  }

  final String? publishableKey;
  final String? merchantIdentifier;
  final String? billingCountryCode;
  final String? paymentIntentClientSecret;
  final String? customerId;
  final String? customerEphemeralKeySecret;
  final bool? testEnv;
  final bool? hasTax;
  final String? merchantDisplayName;
  final String? stripeUrlScheme;
  final String? orderId;
  final String? paymentStatus;
  final String? subtotalPriceDisplay;
  final String? taxPriceDisplay;
  final String? totalPriceDisplay;
  final int? otpExpiration;
  final String? originalPriceDisplay;
  final String? discountAmountDisplay;
  final String? promoCodeApplied;
  final bool? promoCodeRejected;
  final String? promoCodeRejectionReason;

  bool isTaxExist() {
    return hasTax ?? false;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "publishable_key": publishableKey,
      "merchant_identifier": merchantIdentifier,
      "billing_country_code": billingCountryCode,
      "payment_intent_client_secret": paymentIntentClientSecret,
      "customer_id": customerId,
      "customer_ephemeral_key_secret": customerEphemeralKeySecret,
      "test_env": testEnv,
      "has_tax": hasTax,
      "merchant_display_name": merchantDisplayName,
      "stripe_url_scheme": stripeUrlScheme,
      "order_id": orderId,
      "payment_status": paymentStatus,
      "tax_price_display": taxPriceDisplay,
      "total_price_display": totalPriceDisplay,
      "subtotal_price_display": subtotalPriceDisplay,
      "otp_expiration": otpExpiration,
      "original_price_display": originalPriceDisplay,
      "discount_amount_display": discountAmountDisplay,
      "promo_code_applied": promoCodeApplied,
      "promo_code_rejected": promoCodeRejected,
      "promo_code_rejection_reason": promoCodeRejectionReason,
    };
  }
}
