import "dart:convert";

import "package:esim_open_source/data/remote/responses/auth/otp_response_model.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for OtpResponseModel
/// Tests JSON serialization/deserialization and model methods
void main() {
  group("OtpResponseModel Tests", () {
    test("fromJson creates instance with otp_expiration", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "otp_expiration": 300,
      };

      // Act
      final OtpResponseModel model = OtpResponseModel.fromJson(json: json);

      // Assert
      expect(model.otpExpiration, 300);
    });

    test("fromJson handles null otp_expiration", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{};

      // Act
      final OtpResponseModel model = OtpResponseModel.fromJson(json: json);

      // Assert
      expect(model.otpExpiration, isNull);
    });

    test("fromAPIJson creates instance with otp_expiration", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "otp_expiration": 600,
      };

      // Act
      final OtpResponseModel model =
          OtpResponseModel.fromAPIJson(json: json);

      // Assert
      expect(model.otpExpiration, 600);
    });

    test("fromAPIJson handles null otp_expiration", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{};

      // Act
      final OtpResponseModel model =
          OtpResponseModel.fromAPIJson(json: json);

      // Assert
      expect(model.otpExpiration, isNull);
    });

    test("constructor assigns value correctly", () {
      // Act
      final OtpResponseModel model = OtpResponseModel(
        otpExpiration: 180,
      );

      // Assert
      expect(model.otpExpiration, 180);
    });

    test("constructor handles null value", () {
      // Act
      final OtpResponseModel model = OtpResponseModel();

      // Assert
      expect(model.otpExpiration, isNull);
    });

    test("toJson returns correct map", () {
      // Arrange
      final OtpResponseModel model = OtpResponseModel(
        otpExpiration: 450,
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["otp_expiration"], 450);
    });

    test("toJson handles null value", () {
      // Arrange
      final OtpResponseModel model = OtpResponseModel();

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["otp_expiration"], isNull);
    });

    test("copyWith creates new instance with updated value", () {
      // Arrange
      final OtpResponseModel original = OtpResponseModel(
        otpExpiration: 300,
      );

      // Act
      final OtpResponseModel updated = original.copyWith(
        otpExpiration: 600,
      );

      // Assert
      expect(updated.otpExpiration, 600);
      expect(original.otpExpiration, 300);
    });

    test("copyWith without parameters returns same value", () {
      // Arrange
      final OtpResponseModel original = OtpResponseModel(
        otpExpiration: 500,
      );

      // Act
      final OtpResponseModel copied = original.copyWith();

      // Assert
      expect(copied.otpExpiration, original.otpExpiration);
      expect(copied.otpExpiration, 500);
    });

    test("fromJsonString parses JSON string correctly", () {
      // Arrange
      final String jsonString = """
      {
        "otp_expiration": 720
      }
      """;

      // Act
      final OtpResponseModel model =
          OtpResponseModel.fromJsonString(jsonString);

      // Assert
      expect(model.otpExpiration, 720);
    });

    test("toJsonString converts model to JSON string", () {
      // Arrange
      final OtpResponseModel model = OtpResponseModel(
        otpExpiration: 360,
      );

      // Act
      final String jsonString = model.toJsonString();
      final Map<String, dynamic> decoded = jsonDecode(jsonString);

      // Assert
      expect(decoded["otp_expiration"], 360);
    });

    test("roundtrip fromJson and toJson preserves data", () {
      // Arrange
      final Map<String, dynamic> originalJson = <String, dynamic>{
        "otp_expiration": 900,
      };

      // Act
      final OtpResponseModel model =
          OtpResponseModel.fromJson(json: originalJson);
      final Map<String, dynamic> resultJson = model.toJson();

      // Assert
      expect(resultJson["otp_expiration"], originalJson["otp_expiration"]);
    });

    test("roundtrip fromJsonString and toJsonString preserves data", () {
      // Arrange
      final OtpResponseModel original = OtpResponseModel(
        otpExpiration: 240,
      );

      // Act
      final String jsonString = original.toJsonString();
      final OtpResponseModel parsed =
          OtpResponseModel.fromJsonString(jsonString);

      // Assert
      expect(parsed.otpExpiration, original.otpExpiration);
    });

    test("fromJson and fromAPIJson produce identical results", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "otp_expiration": 480,
      };

      // Act
      final OtpResponseModel fromJsonModel =
          OtpResponseModel.fromJson(json: json);
      final OtpResponseModel fromAPIJsonModel =
          OtpResponseModel.fromAPIJson(json: json);

      // Assert
      expect(fromJsonModel.otpExpiration, fromAPIJsonModel.otpExpiration);
    });

    test("handles various expiration times", () {
      // Test common OTP expiration times
      final List<int> expirationTimes = <int>[
        30, // 30 seconds
        60, // 1 minute
        120, // 2 minutes
        300, // 5 minutes
        600, // 10 minutes
        900, // 15 minutes
      ];

      for (final int expiration in expirationTimes) {
        final OtpResponseModel model = OtpResponseModel(
          otpExpiration: expiration,
        );
        expect(model.otpExpiration, expiration);
      }
    });

    test("handles zero expiration", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "otp_expiration": 0,
      };

      // Act
      final OtpResponseModel model = OtpResponseModel.fromJson(json: json);

      // Assert
      expect(model.otpExpiration, 0);
    });

    test("handles negative expiration", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "otp_expiration": -1,
      };

      // Act
      final OtpResponseModel model = OtpResponseModel.fromJson(json: json);

      // Assert
      expect(model.otpExpiration, -1);
    });

    test("handles large expiration values", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "otp_expiration": 86400, // 24 hours in seconds
      };

      // Act
      final OtpResponseModel model = OtpResponseModel.fromJson(json: json);

      // Assert
      expect(model.otpExpiration, 86400);
    });

    test("toJsonString produces valid JSON", () {
      // Arrange
      final OtpResponseModel model = OtpResponseModel(
        otpExpiration: 300,
      );

      // Act
      final String jsonString = model.toJsonString();

      // Assert - Should not throw
      expect(() => jsonDecode(jsonString), returnsNormally);

      final dynamic decoded = jsonDecode(jsonString);
      expect(decoded, isA<Map<String, dynamic>>());
    });

    test("fromJsonString handles whitespace in JSON", () {
      // Arrange
      final String jsonString = """


      {
        "otp_expiration":    300
      }


      """;

      // Act
      final OtpResponseModel model =
          OtpResponseModel.fromJsonString(jsonString);

      // Assert
      expect(model.otpExpiration, 300);
    });

    test("copyWith preserves original instance", () {
      // Arrange
      final OtpResponseModel original = OtpResponseModel(
        otpExpiration: 200,
      );

      // Act
      final OtpResponseModel updated = original.copyWith(
        otpExpiration: 400,
      );

      // Assert - Original should be unchanged
      expect(original.otpExpiration, 200);
      expect(updated.otpExpiration, 400);
    });

    test("field is nullable", () {
      // Act
      final OtpResponseModel model = OtpResponseModel();

      // Assert
      expect(model.otpExpiration, isNull);
    });

    test("fromJson with explicit null value", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "otp_expiration": null,
      };

      // Act
      final OtpResponseModel model = OtpResponseModel.fromJson(json: json);

      // Assert
      expect(model.otpExpiration, isNull);
    });

    test("multiple instances are independent", () {
      // Act
      final OtpResponseModel model1 = OtpResponseModel(otpExpiration: 100);
      final OtpResponseModel model2 = OtpResponseModel(otpExpiration: 200);

      // Assert
      expect(model1.otpExpiration, 100);
      expect(model2.otpExpiration, 200);
    });
  });
}
