import "package:esim_open_source/data/remote/responses/auth/user_info_response_model.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for UserInfoResponseModel
/// Tests JSON serialization/deserialization and model methods
void main() {
  group("UserInfoResponseModel Tests", () {
    test("fromJson creates instance with all fields populated", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "is_verified": true,
        "referral_code": "REF123456",
        "should_notify": true,
        "user_token": "token_abc123",
        "role_name": "premium_user",
        "balance": 150.75,
        "currency_code": "USD",
        "is_newsletter_subscribed": false,
        "msisdn": "+1234567890",
        "first_name": "John",
        "last_name": "Doe",
        "language": "en",
        "country": "United States",
        "country_code": "US",
        "email": "john.doe@example.com",
      };

      // Act
      final UserInfoResponseModel model = UserInfoResponseModel.fromJson(json);

      // Assert
      expect(model.isVerified, true);
      expect(model.referralCode, "REF123456");
      expect(model.shouldNotify, true);
      expect(model.userToken, "token_abc123");
      expect(model.roleName, "premium_user");
      expect(model.balance, 150.75);
      expect(model.currencyCode, "USD");
      expect(model.isNewsletterSubscribed, false);
      expect(model.msisdn, "+1234567890");
      expect(model.firstName, "John");
      expect(model.lastName, "Doe");
      expect(model.language, "en");
      expect(model.country, "United States");
      expect(model.countryCode, "US");
      expect(model.email, "john.doe@example.com");
    });

    test("fromJson handles null fields", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "email": "test@example.com",
      };

      // Act
      final UserInfoResponseModel model = UserInfoResponseModel.fromJson(json);

      // Assert
      expect(model.email, "test@example.com");
      expect(model.isVerified, isNull);
      expect(model.referralCode, isNull);
      expect(model.shouldNotify, isNull);
      expect(model.userToken, isNull);
      expect(model.roleName, isNull);
      expect(model.currencyCode, isNull);
      expect(model.isNewsletterSubscribed, isNull);
      expect(model.msisdn, isNull);
      expect(model.firstName, isNull);
      expect(model.lastName, isNull);
      expect(model.language, isNull);
      expect(model.country, isNull);
      expect(model.countryCode, isNull);
    });

    test("fromJson handles balance as integer", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "balance": 100,
      };

      // Act
      final UserInfoResponseModel model = UserInfoResponseModel.fromJson(json);

      // Assert
      expect(model.balance, 100.0);
      expect(model.balance, isA<double>());
    });

    test("fromJson handles balance as double", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "balance": 99.99,
      };

      // Act
      final UserInfoResponseModel model = UserInfoResponseModel.fromJson(json);

      // Assert
      expect(model.balance, 99.99);
      expect(model.balance, isA<double>());
    });

    test("fromJson defaults balance to 0.0 when null", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "email": "test@example.com",
      };

      // Act
      final UserInfoResponseModel model = UserInfoResponseModel.fromJson(json);

      // Assert
      expect(model.balance, 0.0);
    });

    test("constructor assigns values correctly", () {
      // Act
      final UserInfoResponseModel model = UserInfoResponseModel(
        isVerified: true,
        referralCode: "REF789",
        shouldNotify: false,
        userToken: "user_token_xyz",
        roleName: "admin",
        balance: 250.50,
        currencyCode: "EUR",
        isNewsletterSubscribed: true,
        msisdn: "+9876543210",
        firstName: "Jane",
        lastName: "Smith",
        language: "fr",
        country: "France",
        countryCode: "FR",
        email: "jane.smith@example.com",
      );

      // Assert
      expect(model.isVerified, true);
      expect(model.referralCode, "REF789");
      expect(model.shouldNotify, false);
      expect(model.userToken, "user_token_xyz");
      expect(model.roleName, "admin");
      expect(model.balance, 250.50);
      expect(model.currencyCode, "EUR");
      expect(model.isNewsletterSubscribed, true);
      expect(model.msisdn, "+9876543210");
      expect(model.firstName, "Jane");
      expect(model.lastName, "Smith");
      expect(model.language, "fr");
      expect(model.country, "France");
      expect(model.countryCode, "FR");
      expect(model.email, "jane.smith@example.com");
    });

    test("toJson returns correct map with all fields", () {
      // Arrange
      final UserInfoResponseModel model = UserInfoResponseModel(
        isVerified: true,
        referralCode: "REF456",
        shouldNotify: true,
        userToken: "token_123",
        roleName: "user",
        balance: 75.25,
        currencyCode: "GBP",
        isNewsletterSubscribed: true,
        msisdn: "+4412345678",
        firstName: "Alice",
        lastName: "Johnson",
        language: "en",
        country: "United Kingdom",
        countryCode: "GB",
        email: "alice.j@example.com",
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["is_verified"], true);
      expect(json["referral_code"], "REF456");
      expect(json["should_notify"], true);
      expect(json["user_token"], "token_123");
      expect(json["role_name"], "user");
      expect(json["balance"], 75.25);
      expect(json["currency_code"], "GBP");
      expect(json["is_newsletter_subscribed"], true);
      expect(json["msisdn"], "+4412345678");
      expect(json["first_name"], "Alice");
      expect(json["last_name"], "Johnson");
      expect(json["language"], "en");
      expect(json["country"], "United Kingdom");
      expect(json["country_code"], "GB");
      expect(json["email"], "alice.j@example.com");
    });

    test("toJson handles null fields", () {
      // Arrange
      final UserInfoResponseModel model = UserInfoResponseModel();

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["is_verified"], isNull);
      expect(json["referral_code"], isNull);
      expect(json["should_notify"], isNull);
      expect(json["user_token"], isNull);
      expect(json["role_name"], isNull);
      expect(json["balance"], isNull);
      expect(json["currency_code"], isNull);
      expect(json["is_newsletter_subscribed"], isNull);
      expect(json["msisdn"], isNull);
      expect(json["first_name"], isNull);
      expect(json["last_name"], isNull);
      expect(json["language"], isNull);
      expect(json["country"], isNull);
      expect(json["country_code"], isNull);
      expect(json["email"], isNull);
    });

    test("roundtrip fromJson and toJson preserves data", () {
      // Arrange
      final Map<String, dynamic> originalJson = <String, dynamic>{
        "is_verified": false,
        "referral_code": "REF999",
        "email": "test@test.com",
        "balance": 42.42,
        "currency_code": "CAD",
        "first_name": "Test",
        "last_name": "User",
      };

      // Act
      final UserInfoResponseModel model =
          UserInfoResponseModel.fromJson(originalJson);
      final Map<String, dynamic> resultJson = model.toJson();

      // Assert
      expect(resultJson["is_verified"], originalJson["is_verified"]);
      expect(resultJson["referral_code"], originalJson["referral_code"]);
      expect(resultJson["email"], originalJson["email"]);
      expect(resultJson["balance"], originalJson["balance"]);
      expect(resultJson["currency_code"], originalJson["currency_code"]);
      expect(resultJson["first_name"], originalJson["first_name"]);
      expect(resultJson["last_name"], originalJson["last_name"]);
    });

    test("fromJson handles empty string values", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "email": "",
        "first_name": "",
        "referral_code": "",
      };

      // Act
      final UserInfoResponseModel model = UserInfoResponseModel.fromJson(json);

      // Assert
      expect(model.email, "");
      expect(model.firstName, "");
      expect(model.referralCode, "");
    });

    test("fromJson with boolean flags", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "is_verified": false,
        "should_notify": false,
        "is_newsletter_subscribed": true,
      };

      // Act
      final UserInfoResponseModel model = UserInfoResponseModel.fromJson(json);

      // Assert
      expect(model.isVerified, false);
      expect(model.shouldNotify, false);
      expect(model.isNewsletterSubscribed, true);
    });

    test("fromJson handles negative balance", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "balance": -50.25,
      };

      // Act
      final UserInfoResponseModel model = UserInfoResponseModel.fromJson(json);

      // Assert
      expect(model.balance, -50.25);
    });

    test("toJson preserves balance precision", () {
      // Arrange
      final UserInfoResponseModel model = UserInfoResponseModel(
        balance: 123.456789,
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["balance"], 123.456789);
    });

    test("constructor with minimal fields", () {
      // Act
      final UserInfoResponseModel model = UserInfoResponseModel(
        email: "minimal@test.com",
      );

      // Assert
      expect(model.email, "minimal@test.com");
      expect(model.isVerified, isNull);
      expect(model.balance, isNull);
      expect(model.firstName, isNull);
    });

    test("fromJson with special characters in strings", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "first_name": "José",
        "last_name": "O'Brien",
        "email": "josé.o'brien@example.com",
        "referral_code": "REF-2024-ÄÖÜ",
      };

      // Act
      final UserInfoResponseModel model = UserInfoResponseModel.fromJson(json);

      // Assert
      expect(model.firstName, "José");
      expect(model.lastName, "O'Brien");
      expect(model.email, "josé.o'brien@example.com");
      expect(model.referralCode, "REF-2024-ÄÖÜ");
    });

    test("fromJson handles phone numbers with various formats", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "msisdn": "+1 (555) 123-4567",
      };

      // Act
      final UserInfoResponseModel model = UserInfoResponseModel.fromJson(json);

      // Assert
      expect(model.msisdn, "+1 (555) 123-4567");
    });

    test("all fields are nullable", () {
      // Act
      final UserInfoResponseModel model = UserInfoResponseModel();

      // Assert
      expect(model.isVerified, isNull);
      expect(model.referralCode, isNull);
      expect(model.shouldNotify, isNull);
      expect(model.userToken, isNull);
      expect(model.roleName, isNull);
      expect(model.balance, isNull);
      expect(model.currencyCode, isNull);
      expect(model.isNewsletterSubscribed, isNull);
      expect(model.msisdn, isNull);
      expect(model.firstName, isNull);
      expect(model.lastName, isNull);
      expect(model.language, isNull);
      expect(model.country, isNull);
      expect(model.countryCode, isNull);
      expect(model.email, isNull);
    });
  });
}
