import "dart:convert";

class OtpResponseModel {
  OtpResponseModel({
    this.otpExpiration,
  });

  // Factory constructor for JSON decoding
  factory OtpResponseModel.fromJson({dynamic json}) {
    return OtpResponseModel(
      otpExpiration: json["otp_expiration"],
    );
  }

  // Factory constructor for JSON decoding
  factory OtpResponseModel.fromAPIJson({dynamic json}) {
    return OtpResponseModel(
      otpExpiration: json["otp_expiration"],
    );
  }

  final int? otpExpiration;

  // Method for JSON encoding
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "otp_expiration": otpExpiration,
    };
  }

  OtpResponseModel copyWith({
    int? otpExpiration,
  }) {
    return OtpResponseModel(
      otpExpiration: otpExpiration ?? this.otpExpiration,
    );
  }

  // Convert JSON string to AuthModel
  static OtpResponseModel fromJsonString(String jsonString) {
    return OtpResponseModel.fromJson(json: jsonDecode(jsonString));
  }

  // Convert AuthModel to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
