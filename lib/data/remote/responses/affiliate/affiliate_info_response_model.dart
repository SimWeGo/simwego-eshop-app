class AffiliateInfoResponseModel {
  AffiliateInfoResponseModel({
    this.id,
    this.name,
    this.companyName,
    this.logoUrl,
    this.customBannerText,
  });

  factory AffiliateInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return AffiliateInfoResponseModel(
      id: json["id"] as String?,
      name: json["name"] as String?,
      companyName: json["company_name"] as String?,
      logoUrl: json["logo_url"] as String?,
      customBannerText: json["custom_banner_text"],
    );
  }

  final String? id;
  final String? name;
  final String? companyName;
  final String? logoUrl;

  /// Either a localized String (when returned by `/promotion/info/{code}`) or
  /// a raw `Map<String,String>` (when returned by affiliate dashboard
  /// endpoints). The UI runs it through BannerTranslationHelper.resolve.
  final dynamic customBannerText;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "company_name": companyName,
      "logo_url": logoUrl,
      "custom_banner_text": customBannerText,
    };
  }
}
