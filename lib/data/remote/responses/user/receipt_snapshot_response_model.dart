/// Frozen receipt snapshot returned by GET /api/v1/user/order-history/{id}/receipt.
///
/// Mirrors the backend snapshot built by ReceiptService.build_receipt_snapshot.
/// The receipt is always rendered from this immutable snapshot (never from live
/// order/account data) so a later account change only affects future orders.
class ReceiptSnapshotResponseModel {
  ReceiptSnapshotResponseModel({
    this.documentType,
    this.emittedAt,
    this.vendor,
    this.customer,
    this.order,
    this.product,
    this.quantity,
    this.unitPriceHt,
    this.amounts,
    this.eurConversion,
    this.payment,
  });

  factory ReceiptSnapshotResponseModel.fromJson({dynamic json}) {
    final Map<String, dynamic> map =
        (json as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
    return ReceiptSnapshotResponseModel(
      documentType: map["document_type"] as String?,
      emittedAt: map["emitted_at"] as String?,
      vendor: map["vendor"] != null
          ? ReceiptVendorModel.fromJson(map["vendor"])
          : null,
      customer: map["customer"] != null
          ? ReceiptCustomerModel.fromJson(map["customer"])
          : null,
      order:
          map["order"] != null ? ReceiptOrderModel.fromJson(map["order"]) : null,
      product: map["product"] != null
          ? ReceiptProductModel.fromJson(map["product"])
          : null,
      quantity: (map["quantity"] as num?)?.toInt(),
      unitPriceHt: (map["unit_price_ht"] as num?)?.toDouble(),
      amounts: map["amounts"] != null
          ? ReceiptAmountsModel.fromJson(map["amounts"])
          : null,
      eurConversion: map["eur_conversion"] != null
          ? ReceiptEurConversionModel.fromJson(map["eur_conversion"])
          : null,
      payment: map["payment"] != null
          ? ReceiptPaymentModel.fromJson(map["payment"])
          : null,
    );
  }

  final String? documentType;
  final String? emittedAt;
  final ReceiptVendorModel? vendor;
  final ReceiptCustomerModel? customer;
  final ReceiptOrderModel? order;
  final ReceiptProductModel? product;
  final int? quantity;
  final double? unitPriceHt;
  final ReceiptAmountsModel? amounts;
  final ReceiptEurConversionModel? eurConversion;
  final ReceiptPaymentModel? payment;
}

class ReceiptVendorModel {
  ReceiptVendorModel({
    this.legalName,
    this.address,
    this.siren,
    this.vatNumber,
    this.email,
  });

  factory ReceiptVendorModel.fromJson(dynamic json) {
    final Map<String, dynamic> map =
        (json as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
    return ReceiptVendorModel(
      legalName: map["legal_name"] as String?,
      address: map["address"] as String?,
      siren: map["siren"] as String?,
      vatNumber: map["vat_number"] as String?,
      email: map["email"] as String?,
    );
  }

  final String? legalName;
  final String? address;
  final String? siren;
  final String? vatNumber;
  final String? email;
}

class ReceiptCustomerModel {
  ReceiptCustomerModel({this.name, this.email});

  factory ReceiptCustomerModel.fromJson(dynamic json) {
    final Map<String, dynamic> map =
        (json as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
    return ReceiptCustomerModel(
      name: map["name"] as String?,
      email: map["email"] as String?,
    );
  }

  final String? name;
  final String? email;
}

class ReceiptOrderModel {
  ReceiptOrderModel({this.id, this.date, this.paymentType});

  factory ReceiptOrderModel.fromJson(dynamic json) {
    final Map<String, dynamic> map =
        (json as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
    return ReceiptOrderModel(
      id: map["id"]?.toString(),
      date: map["date"]?.toString(),
      paymentType: map["payment_type"] as String?,
    );
  }

  final String? id;
  final String? date;
  final String? paymentType;
}

class ReceiptProductModel {
  ReceiptProductModel({
    this.designation,
    this.bundleCode,
    this.dataDisplay,
    this.validityDisplay,
    this.countries,
  });

  factory ReceiptProductModel.fromJson(dynamic json) {
    final Map<String, dynamic> map =
        (json as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
    return ReceiptProductModel(
      designation: map["designation"] as String?,
      bundleCode: map["bundle_code"] as String?,
      dataDisplay: map["data_display"] as String?,
      validityDisplay: map["validity_display"] as String?,
      countries: (map["countries"] as List<dynamic>?)
          ?.map((dynamic e) => e.toString())
          .toList(),
    );
  }

  final String? designation;
  final String? bundleCode;
  final String? dataDisplay;
  final String? validityDisplay;
  final List<String>? countries;
}

class ReceiptAmountsModel {
  ReceiptAmountsModel({
    this.currency,
    this.totalHt,
    this.taxRate,
    this.taxAmount,
    this.totalTtc,
  });

  factory ReceiptAmountsModel.fromJson(dynamic json) {
    final Map<String, dynamic> map =
        (json as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
    return ReceiptAmountsModel(
      currency: map["currency"] as String?,
      totalHt: (map["total_ht"] as num?)?.toDouble(),
      taxRate: (map["tax_rate"] as num?)?.toDouble(),
      taxAmount: (map["tax_amount"] as num?)?.toDouble(),
      totalTtc: (map["total_ttc"] as num?)?.toDouble(),
    );
  }

  final String? currency;
  final double? totalHt;
  final double? taxRate;
  final double? taxAmount;
  final double? totalTtc;
}

class ReceiptEurConversionModel {
  ReceiptEurConversionModel({this.rate, this.rateDate, this.totalTtcEur});

  factory ReceiptEurConversionModel.fromJson(dynamic json) {
    final Map<String, dynamic> map =
        (json as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
    return ReceiptEurConversionModel(
      rate: (map["rate"] as num?)?.toDouble(),
      rateDate: map["rate_date"] as String?,
      totalTtcEur: (map["total_ttc_eur"] as num?)?.toDouble(),
    );
  }

  final double? rate;
  final String? rateDate;
  final double? totalTtcEur;
}

class ReceiptPaymentModel {
  ReceiptPaymentModel({this.method, this.brand, this.last4, this.display});

  factory ReceiptPaymentModel.fromJson(dynamic json) {
    final Map<String, dynamic> map =
        (json as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
    return ReceiptPaymentModel(
      method: map["method"] as String?,
      brand: map["brand"] as String?,
      last4: map["last4"] as String?,
      display: map["display"] as String?,
    );
  }

  final String? method;
  final String? brand;
  final String? last4;
  final String? display;
}
