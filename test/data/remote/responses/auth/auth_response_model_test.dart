import "dart:convert";

import "package:esim_open_source/data/remote/responses/auth/auth_response_model.dart";
import "package:esim_open_source/data/remote/responses/auth/user_info_response_model.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for AuthResponseModel
/// Tests JSON serialization/deserialization and model methods
void main() {
  group("AuthResponseModel Tests", () {
    test("fromJson creates instance with all fields populated", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
        "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.refresh",
        "user_info": <String, dynamic>{
          "email": "user@example.com",
          "first_name": "John",
          "is_verified": true,
        },
        "user_token": "user_token_abc123",
        "is_verified": true,
      };

      // Act
      final AuthResponseModel model = AuthResponseModel.fromJson(json);

      // Assert
      expect(model.accessToken, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9");
      expect(
        model.refreshToken,
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.refresh",
      );
      expect(model.userInfo, isNotNull);
      expect(model.userInfo?.email, "user@example.com");
      expect(model.userInfo?.firstName, "John");
      expect(model.userInfo?.isVerified, true);
      expect(model.userToken, "user_token_abc123");
      expect(model.isVerified, true);
    });

    test("fromJson handles null user_info", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "access_token": "token123",
        "refresh_token": "refresh123",
      };

      // Act
      final AuthResponseModel model = AuthResponseModel.fromJson(json);

      // Assert
      expect(model.accessToken, "token123");
      expect(model.refreshToken, "refresh123");
      expect(model.userInfo, isNull);
    });

    test("fromJson handles null fields", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{};

      // Act
      final AuthResponseModel model = AuthResponseModel.fromJson(json);

      // Assert
      expect(model.accessToken, isNull);
      expect(model.refreshToken, isNull);
      expect(model.userInfo, isNull);
      expect(model.userToken, isNull);
      expect(model.isVerified, isNull);
    });

    test("fromAPIJson creates instance with all fields populated", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "access_token": "api_access_token",
        "refresh_token": "api_refresh_token",
        "user_info": <String, dynamic>{
          "email": "api@example.com",
          "balance": 100.50,
        },
        "user_token": "api_user_token",
        "is_verified": false,
      };

      // Act
      final AuthResponseModel model =
          AuthResponseModel.fromAPIJson(json: json);

      // Assert
      expect(model.accessToken, "api_access_token");
      expect(model.refreshToken, "api_refresh_token");
      expect(model.userInfo, isNotNull);
      expect(model.userInfo?.email, "api@example.com");
      expect(model.userInfo?.balance, 100.50);
      expect(model.userToken, "api_user_token");
      expect(model.isVerified, false);
    });

    test("fromAPIJson handles null user_info", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "access_token": "token_only",
      };

      // Act
      final AuthResponseModel model =
          AuthResponseModel.fromAPIJson(json: json);

      // Assert
      expect(model.accessToken, "token_only");
      expect(model.userInfo, isNull);
    });

    test("constructor assigns values correctly", () {
      // Arrange
      final UserInfoResponseModel userInfo = UserInfoResponseModel(
        email: "constructor@example.com",
        firstName: "Test",
        lastName: "User",
        isVerified: true,
      );

      // Act
      final AuthResponseModel model = AuthResponseModel(
        accessToken: "constructor_access_token",
        refreshToken: "constructor_refresh_token",
        userInfo: userInfo,
        userToken: "constructor_user_token",
        isVerified: true,
      );

      // Assert
      expect(model.accessToken, "constructor_access_token");
      expect(model.refreshToken, "constructor_refresh_token");
      expect(model.userInfo, userInfo);
      expect(model.userToken, "constructor_user_token");
      expect(model.isVerified, true);
    });

    test("toJson returns correct map with all fields", () {
      // Arrange
      final UserInfoResponseModel userInfo = UserInfoResponseModel(
        email: "tojson@example.com",
        firstName: "Jane",
        lastName: "Doe",
        balance: 250,
        currencyCode: "USD",
      );

      final AuthResponseModel model = AuthResponseModel(
        accessToken: "access_token_123",
        refreshToken: "refresh_token_456",
        userInfo: userInfo,
        userToken: "user_token_789",
        isVerified: true,
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["access_token"], "access_token_123");
      expect(json["refresh_token"], "refresh_token_456");
      expect(json["user_info"], isNotNull);
      expect(json["user_info"]["email"], "tojson@example.com");
      expect(json["user_info"]["first_name"], "Jane");
      expect(json["user_info"]["balance"], 250.00);
      expect(json["user_token"], "user_token_789");
      expect(json["is_verified"], true);
    });

    test("toJson handles null fields", () {
      // Arrange
      final AuthResponseModel model = AuthResponseModel();

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["access_token"], isNull);
      expect(json["refresh_token"], isNull);
      expect(json["user_info"], isNull);
      expect(json["user_token"], isNull);
      expect(json["is_verified"], isNull);
    });

    test("toJson handles null user_info", () {
      // Arrange
      final AuthResponseModel model = AuthResponseModel(
        accessToken: "token",
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["access_token"], "token");
      expect(json["user_info"], isNull);
    });

    test("copyWith creates new instance with updated fields", () {
      // Arrange
      final AuthResponseModel original = AuthResponseModel(
        accessToken: "original_access",
        refreshToken: "original_refresh",
        userToken: "original_user_token",
        isVerified: false,
      );

      // Act
      final AuthResponseModel updated = original.copyWith(
        accessToken: "updated_access",
        isVerified: true,
      );

      // Assert
      expect(updated.accessToken, "updated_access");
      expect(updated.refreshToken, "original_refresh");
      expect(updated.userToken, "original_user_token");
      expect(updated.isVerified, true);
    });

    test("copyWith without parameters returns same values", () {
      // Arrange
      final UserInfoResponseModel userInfo = UserInfoResponseModel(
        email: "same@example.com",
      );

      final AuthResponseModel original = AuthResponseModel(
        accessToken: "access",
        refreshToken: "refresh",
        userInfo: userInfo,
        userToken: "user",
        isVerified: true,
      );

      // Act
      final AuthResponseModel copied = original.copyWith();

      // Assert
      expect(copied.accessToken, original.accessToken);
      expect(copied.refreshToken, original.refreshToken);
      expect(copied.userInfo, original.userInfo);
      expect(copied.userToken, original.userToken);
      expect(copied.isVerified, original.isVerified);
    });

    test("copyWith can update userInfo", () {
      // Arrange
      final UserInfoResponseModel originalUserInfo = UserInfoResponseModel(
        email: "original@example.com",
      );

      final UserInfoResponseModel newUserInfo = UserInfoResponseModel(
        email: "new@example.com",
      );

      final AuthResponseModel original = AuthResponseModel(
        accessToken: "token",
        userInfo: originalUserInfo,
      );

      // Act
      final AuthResponseModel updated = original.copyWith(
        userInfo: newUserInfo,
      );

      // Assert
      expect(updated.userInfo?.email, "new@example.com");
      expect(original.userInfo?.email, "original@example.com");
    });

    test("fromJsonString parses JSON string correctly", () {
      // Arrange
      final String jsonString = """
      {
        "access_token": "string_token",
        "refresh_token": "string_refresh",
        "user_token": "string_user",
        "is_verified": true
      }
      """;

      // Act
      final AuthResponseModel model =
          AuthResponseModel.fromJsonString(jsonString);

      // Assert
      expect(model.accessToken, "string_token");
      expect(model.refreshToken, "string_refresh");
      expect(model.userToken, "string_user");
      expect(model.isVerified, true);
    });

    test("toJsonString converts model to JSON string", () {
      // Arrange
      final AuthResponseModel model = AuthResponseModel(
        accessToken: "json_access",
        refreshToken: "json_refresh",
        userToken: "json_user",
        isVerified: false,
      );

      // Act
      final String jsonString = model.toJsonString();
      final Map<String, dynamic> decoded = jsonDecode(jsonString);

      // Assert
      expect(decoded["access_token"], "json_access");
      expect(decoded["refresh_token"], "json_refresh");
      expect(decoded["user_token"], "json_user");
      expect(decoded["is_verified"], false);
    });

    test("roundtrip fromJson and toJson preserves data", () {
      // Arrange
      final Map<String, dynamic> originalJson = <String, dynamic>{
        "access_token": "roundtrip_access",
        "refresh_token": "roundtrip_refresh",
        "user_info": <String, dynamic>{
          "email": "roundtrip@example.com",
          "balance": 75.50,
        },
        "user_token": "roundtrip_user",
        "is_verified": true,
      };

      // Act
      final AuthResponseModel model = AuthResponseModel.fromJson(originalJson);
      final Map<String, dynamic> resultJson = model.toJson();

      // Assert
      expect(resultJson["access_token"], originalJson["access_token"]);
      expect(resultJson["refresh_token"], originalJson["refresh_token"]);
      expect(resultJson["user_token"], originalJson["user_token"]);
      expect(resultJson["is_verified"], originalJson["is_verified"]);
      expect(resultJson["user_info"]["email"], "roundtrip@example.com");
      expect(resultJson["user_info"]["balance"], 75.50);
    });

    test("roundtrip fromJsonString and toJsonString preserves data", () {
      // Arrange
      final AuthResponseModel original = AuthResponseModel(
        accessToken: "string_roundtrip_access",
        refreshToken: "string_roundtrip_refresh",
        userToken: "string_roundtrip_user",
        isVerified: true,
      );

      // Act
      final String jsonString = original.toJsonString();
      final AuthResponseModel parsed =
          AuthResponseModel.fromJsonString(jsonString);

      // Assert
      expect(parsed.accessToken, original.accessToken);
      expect(parsed.refreshToken, original.refreshToken);
      expect(parsed.userToken, original.userToken);
      expect(parsed.isVerified, original.isVerified);
    });

    test("fromJson and fromAPIJson produce identical results", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "access_token": "identical_token",
        "refresh_token": "identical_refresh",
        "user_info": <String, dynamic>{
          "email": "identical@example.com",
        },
      };

      // Act
      final AuthResponseModel fromJsonModel = AuthResponseModel.fromJson(json);
      final AuthResponseModel fromAPIJsonModel =
          AuthResponseModel.fromAPIJson(json: json);

      // Assert
      expect(fromJsonModel.accessToken, fromAPIJsonModel.accessToken);
      expect(fromJsonModel.refreshToken, fromAPIJsonModel.refreshToken);
      expect(
        fromJsonModel.userInfo?.email,
        fromAPIJsonModel.userInfo?.email,
      );
    });

    test("toJson includes nested user_info correctly", () {
      // Arrange
      final UserInfoResponseModel userInfo = UserInfoResponseModel(
        email: "nested@example.com",
        firstName: "Nested",
        lastName: "Test",
        isVerified: true,
        balance: 500,
        currencyCode: "EUR",
      );

      final AuthResponseModel model = AuthResponseModel(
        accessToken: "nested_token",
        userInfo: userInfo,
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["user_info"], isNotNull);
      expect(json["user_info"]["email"], "nested@example.com");
      expect(json["user_info"]["first_name"], "Nested");
      expect(json["user_info"]["last_name"], "Test");
      expect(json["user_info"]["is_verified"], true);
      expect(json["user_info"]["balance"], 500.00);
      expect(json["user_info"]["currency_code"], "EUR");
    });

    test("constructor with minimal fields", () {
      // Act
      final AuthResponseModel model = AuthResponseModel(
        accessToken: "minimal_token",
      );

      // Assert
      expect(model.accessToken, "minimal_token");
      expect(model.refreshToken, isNull);
      expect(model.userInfo, isNull);
      expect(model.userToken, isNull);
      expect(model.isVerified, isNull);
    });

    test("all fields are nullable", () {
      // Act
      final AuthResponseModel model = AuthResponseModel();

      // Assert
      expect(model.accessToken, isNull);
      expect(model.refreshToken, isNull);
      expect(model.userInfo, isNull);
      expect(model.userToken, isNull);
      expect(model.isVerified, isNull);
    });

    test("fromJson handles long JWT tokens", () {
      // Arrange
      final String longToken =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";

      final Map<String, dynamic> json = <String, dynamic>{
        "access_token": longToken,
      };

      // Act
      final AuthResponseModel model = AuthResponseModel.fromJson(json);

      // Assert
      expect(model.accessToken, longToken);
      expect(model.accessToken?.length, greaterThan(100));
    });

    test("copyWith preserves null values when not specified", () {
      // Arrange
      final AuthResponseModel original = AuthResponseModel(
        accessToken: "token",
      );

      // Act
      final AuthResponseModel updated = original.copyWith(
        refreshToken: "new_refresh",
      );

      // Assert
      expect(updated.accessToken, "token");
      expect(updated.refreshToken, "new_refresh");
      expect(updated.userInfo, isNull);
      expect(updated.userToken, isNull);
      expect(updated.isVerified, isNull);
    });

    test("toJsonString produces valid JSON", () {
      // Arrange
      final AuthResponseModel model = AuthResponseModel(
        accessToken: "valid_token",
        refreshToken: "valid_refresh",
        isVerified: true,
      );

      // Act
      final String jsonString = model.toJsonString();

      // Assert - Should not throw
      expect(() => jsonDecode(jsonString), returnsNormally);

      final dynamic decoded = jsonDecode(jsonString);
      expect(decoded, isA<Map<String, dynamic>>());
    });
  });
}
