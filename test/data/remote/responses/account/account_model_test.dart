import "dart:convert";

import "package:esim_open_source/data/remote/responses/account/account_model.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for AccountModel
/// Tests JSON serialization/deserialization, enum handling, and model methods
void main() {
  group("AccountModel Tests", () {
    test("constructor assigns values correctly", () {
      // Act
      final AccountModel model = AccountModel(
        recordGuid: "record-guid-123",
        accountNumber: "ACC-001",
        currentBalance: 500.50,
        previousBalance: 400.25,
        lockedBalance: 50.00,
        previousLockedBalance: 25.00,
        currencyCode: "USD",
        accountTypeTag: "PREPAID",
        isPrimary: true,
      );

      // Assert
      expect(model.recordGuid, "record-guid-123");
      expect(model.accountNumber, "ACC-001");
      expect(model.currentBalance, 500.50);
      expect(model.previousBalance, 400.25);
      expect(model.lockedBalance, 50.00);
      expect(model.previousLockedBalance, 25.00);
      expect(model.currencyCode, "USD");
      expect(model.accountTypeTag, "PREPAID");
      expect(model.isPrimary, true);
    });

    test("fromJson creates instance with all fields populated", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "recordGuid": "guid-456",
        "accountNumber": "ACC-002",
        "currentBalance": 1000.75,
        "previousBalance": 900.50,
        "lockedBalance": 100.00,
        "previousLockedBalance": 50.00,
        "currencyCode": "EUR",
        "accountTypeTag": "POSTPAID",
        "isPrimary": false,
      };

      // Act
      final AccountModel model = AccountModel.fromJson(json: json);

      // Assert
      expect(model.recordGuid, "guid-456");
      expect(model.accountNumber, "ACC-002");
      expect(model.currentBalance, 1000.75);
      expect(model.previousBalance, 900.50);
      expect(model.lockedBalance, 100.00);
      expect(model.previousLockedBalance, 50.00);
      expect(model.currencyCode, "EUR");
      expect(model.accountTypeTag, "POSTPAID");
      expect(model.isPrimary, false);
    });

    test("fromJson handles null fields", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{};

      // Act
      final AccountModel model = AccountModel.fromJson(json: json);

      // Assert
      expect(model.recordGuid, isNull);
      expect(model.accountNumber, isNull);
      expect(model.currentBalance, isNull);
      expect(model.previousBalance, isNull);
      expect(model.lockedBalance, isNull);
      expect(model.previousLockedBalance, isNull);
      expect(model.currencyCode, isNull);
      expect(model.accountTypeTag, isNull);
      expect(model.isPrimary, isNull);
    });

    test("fromJson handles integer balances", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "currentBalance": 100,
        "previousBalance": 200,
        "lockedBalance": 50,
        "previousLockedBalance": 25,
      };

      // Act
      final AccountModel model = AccountModel.fromJson(json: json);

      // Assert
      expect(model.currentBalance, 100);
      expect(model.previousBalance, 200);
      expect(model.lockedBalance, 50);
      expect(model.previousLockedBalance, 25);
    });

    test("fromJson handles double balances", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "currentBalance": 100.99,
        "previousBalance": 200.50,
        "lockedBalance": 50.25,
        "previousLockedBalance": 25.75,
      };

      // Act
      final AccountModel model = AccountModel.fromJson(json: json);

      // Assert
      expect(model.currentBalance, 100.99);
      expect(model.previousBalance, 200.50);
      expect(model.lockedBalance, 50.25);
      expect(model.previousLockedBalance, 25.75);
    });

    test("toJson returns correct map with all fields", () {
      // Arrange
      final AccountModel model = AccountModel(
        recordGuid: "guid-789",
        accountNumber: "ACC-003",
        currentBalance: 750.25,
        previousBalance: 650.75,
        lockedBalance: 75.00,
        previousLockedBalance: 50.00,
        currencyCode: "GBP",
        accountTypeTag: "PREPAID",
        isPrimary: true,
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["recordGuid"], "guid-789");
      expect(json["accountNumber"], "ACC-003");
      expect(json["currentBalance"], 750.25);
      expect(json["previousBalance"], 650.75);
      expect(json["lockedBalance"], 75.00);
      expect(json["previousLockedBalance"], 50.00);
      expect(json["currencyCode"], "GBP");
      expect(json["accountTypeTag"], "PREPAID");
      expect(json["isPrimary"], true);
    });

    test("toJson handles null fields", () {
      // Arrange
      final AccountModel model = AccountModel();

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["recordGuid"], isNull);
      expect(json["accountNumber"], isNull);
      expect(json["currentBalance"], isNull);
      expect(json["previousBalance"], isNull);
      expect(json["lockedBalance"], isNull);
      expect(json["previousLockedBalance"], isNull);
      expect(json["currencyCode"], isNull);
      expect(json["accountTypeTag"], isNull);
      expect(json["isPrimary"], isNull);
    });

    test("copyWith creates new instance with updated values", () {
      // Arrange
      final AccountModel original = AccountModel(
        recordGuid: "original-guid",
        accountNumber: "ACC-001",
        currentBalance: 500.00,
        currencyCode: "USD",
        isPrimary: false,
      );

      // Act
      final AccountModel updated = original.copyWith(
        currentBalance: 600.00,
        isPrimary: true,
      );

      // Assert
      expect(updated.recordGuid, "original-guid");
      expect(updated.accountNumber, "ACC-001");
      expect(updated.currentBalance, 600.00);
      expect(updated.currencyCode, "USD");
      expect(updated.isPrimary, true);
      // Original should be unchanged
      expect(original.currentBalance, 500.00);
      expect(original.isPrimary, false);
    });

    test("copyWith without parameters preserves original values", () {
      // Arrange
      final AccountModel original = AccountModel(
        recordGuid: "guid",
        accountNumber: "ACC-999",
        currentBalance: 1000.00,
        isPrimary: true,
      );

      // Act
      final AccountModel copied = original.copyWith();

      // Assert
      expect(copied.recordGuid, original.recordGuid);
      expect(copied.accountNumber, original.accountNumber);
      expect(copied.currentBalance, original.currentBalance);
      expect(copied.isPrimary, original.isPrimary);
    });

    test("roundtrip fromJson and toJson preserves data", () {
      // Arrange
      final Map<String, dynamic> originalJson = <String, dynamic>{
        "recordGuid": "roundtrip-guid",
        "accountNumber": "ACC-999",
        "currentBalance": 555.55,
        "previousBalance": 444.44,
        "lockedBalance": 111.11,
        "previousLockedBalance": 88.88,
        "currencyCode": "CAD",
        "accountTypeTag": "PREPAID",
        "isPrimary": true,
      };

      // Act
      final AccountModel model = AccountModel.fromJson(json: originalJson);
      final Map<String, dynamic> resultJson = model.toJson();

      // Assert
      expect(resultJson["recordGuid"], originalJson["recordGuid"]);
      expect(resultJson["accountNumber"], originalJson["accountNumber"]);
      expect(resultJson["currentBalance"], originalJson["currentBalance"]);
      expect(resultJson["previousBalance"], originalJson["previousBalance"]);
      expect(resultJson["lockedBalance"], originalJson["lockedBalance"]);
      expect(
        resultJson["previousLockedBalance"],
        originalJson["previousLockedBalance"],
      );
      expect(resultJson["currencyCode"], originalJson["currencyCode"]);
      expect(resultJson["accountTypeTag"], originalJson["accountTypeTag"]);
      expect(resultJson["isPrimary"], originalJson["isPrimary"]);
    });

    test("accountType returns prepaid for PREPAID tag", () {
      // Arrange
      final AccountModel model = AccountModel(
        accountTypeTag: "PREPAID",
      );

      // Act & Assert
      expect(model.accountType, AccountsType.prepaid);
    });

    test("accountType returns prepaid for lowercase prepaid tag", () {
      // Arrange
      final AccountModel model = AccountModel(
        accountTypeTag: "prepaid",
      );

      // Act & Assert
      expect(model.accountType, AccountsType.prepaid);
    });

    test("accountType returns postpaid for POSTPAID tag", () {
      // Arrange
      final AccountModel model = AccountModel(
        accountTypeTag: "POSTPAID",
      );

      // Act & Assert
      expect(model.accountType, AccountsType.postpaid);
    });

    test("accountType returns postpaid for lowercase postpaid tag", () {
      // Arrange
      final AccountModel model = AccountModel(
        accountTypeTag: "postpaid",
      );

      // Act & Assert
      expect(model.accountType, AccountsType.postpaid);
    });

    test("accountType returns unknown for invalid tag", () {
      // Arrange
      final AccountModel model = AccountModel(
        accountTypeTag: "INVALID",
      );

      // Act & Assert
      expect(model.accountType, AccountsType.unknown);
    });

    test("accountType returns unknown for null tag", () {
      // Arrange
      final AccountModel model = AccountModel();

      // Act & Assert
      expect(model.accountType, AccountsType.unknown);
    });

    test("accountType returns unknown for empty tag", () {
      // Arrange
      final AccountModel model = AccountModel(
        accountTypeTag: "",
      );

      // Act & Assert
      expect(model.accountType, AccountsType.unknown);
    });

    test("fromJsonList creates list from json array", () {
      // Arrange
      final List<Map<String, dynamic>> jsonList = <Map<String, dynamic>>[
        <String, dynamic>{
          "recordGuid": "guid-1",
          "accountNumber": "ACC-001",
          "currentBalance": 100.00,
        },
        <String, dynamic>{
          "recordGuid": "guid-2",
          "accountNumber": "ACC-002",
          "currentBalance": 200.00,
        },
      ];

      // Act
      final List<AccountModel> models =
          AccountModel.fromJsonList(json: jsonList);

      // Assert
      expect(models.length, 2);
      expect(models[0].recordGuid, "guid-1");
      expect(models[0].accountNumber, "ACC-001");
      expect(models[0].currentBalance, 100.00);
      expect(models[1].recordGuid, "guid-2");
      expect(models[1].accountNumber, "ACC-002");
      expect(models[1].currentBalance, 200.00);
    });

    test("fromJsonList handles empty list", () {
      // Arrange
      final List<dynamic> jsonList = <dynamic>[];

      // Act
      final List<AccountModel> models =
          AccountModel.fromJsonList(json: jsonList);

      // Assert
      expect(models, isEmpty);
    });

    test("accountModelFromJson helper parses JSON string", () {
      // Arrange
      final String jsonString = """
      {
        "recordGuid": "helper-guid",
        "accountNumber": "ACC-HELPER",
        "currentBalance": 888.88,
        "currencyCode": "USD",
        "accountTypeTag": "PREPAID",
        "isPrimary": true
      }
      """;

      // Act
      final AccountModel model = accountModelFromJson(jsonString);

      // Assert
      expect(model.recordGuid, "helper-guid");
      expect(model.accountNumber, "ACC-HELPER");
      expect(model.currentBalance, 888.88);
      expect(model.currencyCode, "USD");
      expect(model.accountTypeTag, "PREPAID");
      expect(model.isPrimary, true);
    });

    test("accountModelToJson helper converts model to JSON string", () {
      // Arrange
      final AccountModel model = AccountModel(
        recordGuid: "to-json-guid",
        accountNumber: "ACC-JSON",
        currentBalance: 999.99,
        currencyCode: "EUR",
        accountTypeTag: "POSTPAID",
        isPrimary: false,
      );

      // Act
      final String jsonString = accountModelToJson(model);
      final Map<String, dynamic> decoded = jsonDecode(jsonString);

      // Assert
      expect(decoded["recordGuid"], "to-json-guid");
      expect(decoded["accountNumber"], "ACC-JSON");
      expect(decoded["currentBalance"], 999.99);
      expect(decoded["currencyCode"], "EUR");
      expect(decoded["accountTypeTag"], "POSTPAID");
      expect(decoded["isPrimary"], false);
    });

    test("roundtrip accountModelFromJson and accountModelToJson preserves data",
        () {
      // Arrange
      final AccountModel original = AccountModel(
        recordGuid: "roundtrip-string-guid",
        accountNumber: "ACC-RT",
        currentBalance: 333.33,
        isPrimary: true,
      );

      // Act
      final String jsonString = accountModelToJson(original);
      final AccountModel parsed = accountModelFromJson(jsonString);

      // Assert
      expect(parsed.recordGuid, original.recordGuid);
      expect(parsed.accountNumber, original.accountNumber);
      expect(parsed.currentBalance, original.currentBalance);
      expect(parsed.isPrimary, original.isPrimary);
    });

    test("handles negative balances", () {
      // Arrange
      final AccountModel model = AccountModel(
        currentBalance: -50.00,
        previousBalance: -25.00,
        lockedBalance: -10.00,
      );

      // Act & Assert
      expect(model.currentBalance, -50.00);
      expect(model.previousBalance, -25.00);
      expect(model.lockedBalance, -10.00);
    });

    test("handles zero balances", () {
      // Arrange
      final AccountModel model = AccountModel(
        currentBalance: 0,
        previousBalance: 0,
        lockedBalance: 0,
        previousLockedBalance: 0,
      );

      // Act & Assert
      expect(model.currentBalance, 0);
      expect(model.previousBalance, 0);
      expect(model.lockedBalance, 0);
      expect(model.previousLockedBalance, 0);
    });

    test("handles large balance values", () {
      // Arrange
      final AccountModel model = AccountModel(
        currentBalance: 9999999.99,
        previousBalance: 8888888.88,
      );

      // Act & Assert
      expect(model.currentBalance, 9999999.99);
      expect(model.previousBalance, 8888888.88);
    });

    test("all getters return correct values", () {
      // Arrange
      final AccountModel model = AccountModel(
        recordGuid: "getter-guid",
        accountNumber: "ACC-GET",
        currentBalance: 100.00,
        previousBalance: 90.00,
        lockedBalance: 10.00,
        previousLockedBalance: 5.00,
        currencyCode: "USD",
        accountTypeTag: "PREPAID",
        isPrimary: true,
      );

      // Act & Assert
      expect(model.recordGuid, "getter-guid");
      expect(model.accountNumber, "ACC-GET");
      expect(model.currentBalance, 100.00);
      expect(model.previousBalance, 90.00);
      expect(model.lockedBalance, 10.00);
      expect(model.previousLockedBalance, 5.00);
      expect(model.currencyCode, "USD");
      expect(model.accountTypeTag, "PREPAID");
      expect(model.isPrimary, true);
      expect(model.accountType, AccountsType.prepaid);
    });

    test("copyWith updates all fields individually", () {
      // Arrange
      final AccountModel original = AccountModel();

      // Act & Assert
      expect(original.copyWith(recordGuid: "new-guid").recordGuid, "new-guid");
      expect(
        original.copyWith(accountNumber: "ACC-NEW").accountNumber,
        "ACC-NEW",
      );
      expect(
        original.copyWith(currentBalance: 100).currentBalance,
        100,
      );
      expect(
        original.copyWith(previousBalance: 90).previousBalance,
        90,
      );
      expect(original.copyWith(lockedBalance: 10).lockedBalance, 10);
      expect(
        original.copyWith(previousLockedBalance: 5).previousLockedBalance,
        5,
      );
      expect(
        original.copyWith(currencyCode: "EUR").currencyCode,
        "EUR",
      );
      expect(
        original.copyWith(accountTypeTag: "POSTPAID").accountTypeTag,
        "POSTPAID",
      );
      expect(original.copyWith(isPrimary: true).isPrimary, true);
    });

    test("AccountsType enum has correct values", () {
      // Assert
      expect(AccountsType.unknown.value, "");
      expect(AccountsType.prepaid.value, "PREPAID");
      expect(AccountsType.postpaid.value, "POSTPAID");
    });

    test("AccountsType enum contains all expected values", () {
      // Assert
      expect(AccountsType.values.length, 3);
      expect(AccountsType.values, contains(AccountsType.unknown));
      expect(AccountsType.values, contains(AccountsType.prepaid));
      expect(AccountsType.values, contains(AccountsType.postpaid));
    });

    test("fromJson handles mixed case account type tags", () {
      // Test various case combinations
      final Map<String, AccountsType> testCases = <String, AccountsType>{
        "PREPAID": AccountsType.prepaid,
        "prepaid": AccountsType.prepaid,
        "Prepaid": AccountsType.prepaid,
        "PrePaid": AccountsType.prepaid,
        "POSTPAID": AccountsType.postpaid,
        "postpaid": AccountsType.postpaid,
        "Postpaid": AccountsType.postpaid,
        "PostPaid": AccountsType.postpaid,
      };

      for (final MapEntry<String, AccountsType> entry in testCases.entries) {
        final AccountModel model = AccountModel(
          accountTypeTag: entry.key,
        );
        expect(
          model.accountType,
          entry.value,
          reason: "Failed for tag: ${entry.key}",
        );
      }
    });

    test("constructor with minimal fields", () {
      // Act
      final AccountModel model = AccountModel(
        accountNumber: "MINIMAL",
      );

      // Assert
      expect(model.accountNumber, "MINIMAL");
      expect(model.recordGuid, isNull);
      expect(model.currentBalance, isNull);
      expect(model.isPrimary, isNull);
    });

    test("all fields are nullable", () {
      // Act
      final AccountModel model = AccountModel();

      // Assert
      expect(model.recordGuid, isNull);
      expect(model.accountNumber, isNull);
      expect(model.currentBalance, isNull);
      expect(model.previousBalance, isNull);
      expect(model.lockedBalance, isNull);
      expect(model.previousLockedBalance, isNull);
      expect(model.currencyCode, isNull);
      expect(model.accountTypeTag, isNull);
      expect(model.isPrimary, isNull);
    });

    test("fromJson handles explicit null values", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "recordGuid": null,
        "accountNumber": null,
        "currentBalance": null,
        "isPrimary": null,
      };

      // Act
      final AccountModel model = AccountModel.fromJson(json: json);

      // Assert
      expect(model.recordGuid, isNull);
      expect(model.accountNumber, isNull);
      expect(model.currentBalance, isNull);
      expect(model.isPrimary, isNull);
    });

    test("multiple instances are independent", () {
      // Act
      final AccountModel model1 = AccountModel(
        accountNumber: "ACC-001",
        currentBalance: 100,
      );
      final AccountModel model2 = AccountModel(
        accountNumber: "ACC-002",
        currentBalance: 200,
      );

      // Assert
      expect(model1.accountNumber, "ACC-001");
      expect(model1.currentBalance, 100);
      expect(model2.accountNumber, "ACC-002");
      expect(model2.currentBalance, 200);
    });

    test("balance precision is preserved", () {
      // Arrange
      final AccountModel model = AccountModel(
        currentBalance: 123.456789,
        lockedBalance: 987.654321,
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["currentBalance"], 123.456789);
      expect(json["lockedBalance"], 987.654321);
    });
  });
}
