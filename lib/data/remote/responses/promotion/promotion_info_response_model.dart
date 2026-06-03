import "package:esim_open_source/data/remote/responses/affiliate/affiliate_info_response_model.dart";

class PromotionInfoResponseModel {
  PromotionInfoResponseModel({
    this.code,
    this.type,
    this.amount,
    this.affiliate,
  });

  factory PromotionInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return PromotionInfoResponseModel(
      code: json["code"] as String?,
      type: json["type"] as String?,
      amount: (json["amount"] as num?)?.toDouble(),
      affiliate: json["affiliate"] != null
          ? AffiliateInfoResponseModel.fromJson(
              Map<String, dynamic>.from(json["affiliate"] as Map<dynamic, dynamic>),
            )
          : null,
    );
  }

  final String? code;
  final String? type;
  final double? amount;
  final AffiliateInfoResponseModel? affiliate;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "code": code,
      "type": type,
      "amount": amount,
      "affiliate": affiliate?.toJson(),
    };
  }
}
