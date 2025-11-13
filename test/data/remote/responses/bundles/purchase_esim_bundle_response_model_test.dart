import "package:esim_open_source/data/remote/responses/bundles/bundle_category_response_model.dart";
import "package:esim_open_source/data/remote/responses/bundles/country_response_model.dart";
import "package:esim_open_source/data/remote/responses/bundles/purchase_esim_bundle_response_model.dart";
import "package:esim_open_source/data/remote/responses/bundles/transaction_history_response_model.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for PurchaseEsimBundleResponseModel
/// Tests JSON serialization/deserialization and model methods
void main() {
  group("PurchaseEsimBundleResponseModel Tests", () {
    test("fromJson creates instance with all fields populated", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "is_topup_allowed": true,
        "plan_started": false,
        "bundle_expired": false,
        "label_name": "My eSIM",
        "order_number": "ORD-12345",
        "order_status": "active",
        "qr_code_value": r"LPA:1$test.com$12345",
        "activation_code": "ACT-CODE-123",
        "smdp_address": "smdp.test.com",
        "validity_date": "2024-12-31T23:59:59Z",
        "iccid": "89012345678901234567",
        "payment_date": "2024-01-01T00:00:00Z",
        "shared_with": "user@test.com",
        "display_title": "Europe 5GB",
        "display_subtitle": "5GB Data Plan",
        "bundle_code": "EUR-5GB-001",
        "bundle_category": <String, dynamic>{
          "type": "REGIONAL",
          "code": "reg-001",
          "title": "Regional",
        },
        "bundle_marketing_name": "Europe Premium",
        "bundle_name": "Europe 5GB Bundle",
        "count_countries": 25,
        "currency_code": "USD",
        "gprs_limit_display": "5 GB",
        "price": 49.99,
        "price_display": r"$49.99",
        "unlimited": false,
        "validity": 30,
        "validity_display": "30 Days",
        "plan_type": "Data Only",
        "activity_policy": "Activation on first use",
        "bundle_message": <String>["Message 1", "Message 2"],
        "countries": <Map<String, dynamic>>[
          <String, dynamic>{
            "country": "France",
            "country_code": "FR",
          },
        ],
        "icon": "https://example.com/icon.png",
        "transaction_history": <Map<String, dynamic>>[
          <String, dynamic>{
            "user_order_id": "txn-001",
            "iccid": "89012345",
          },
        ],
      };

      // Act
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel.fromJson(json: json);

      // Assert
      expect(model.isTopupAllowed, true);
      expect(model.planStarted, false);
      expect(model.bundleExpired, false);
      expect(model.labelName, "My eSIM");
      expect(model.orderNumber, "ORD-12345");
      expect(model.orderStatus, "active");
      expect(model.qrCodeValue, r"LPA:1$test.com$12345");
      expect(model.activationCode, "ACT-CODE-123");
      expect(model.smdpAddress, "smdp.test.com");
      expect(model.validityDate, "2024-12-31T23:59:59Z");
      expect(model.iccid, "89012345678901234567");
      expect(model.paymentDate, "2024-01-01T00:00:00Z");
      expect(model.sharedWith, "user@test.com");
      expect(model.displayTitle, "Europe 5GB");
      expect(model.bundleCode, "EUR-5GB-001");
      expect(model.bundleCategory, isNotNull);
      expect(model.price, 49.99);
      expect(model.bundleMessage?.length, 2);
      expect(model.countries?.length, 1);
      expect(model.transactionHistory?.length, 1);
    });

    test("fromJson handles null bundle_message", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "order_number": "ORD-123",
      };

      // Act
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel.fromJson(json: json);

      // Assert
      expect(model.bundleMessage, <String>[]);
    });

    test("fromJson handles null countries", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "order_number": "ORD-123",
      };

      // Act
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel.fromJson(json: json);

      // Assert
      expect(model.countries, isNull);
    });

    test("fromJson handles null transaction_history", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "order_number": "ORD-123",
      };

      // Act
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel.fromJson(json: json);

      // Assert
      expect(model.transactionHistory, isNull);
    });

    test("fromJson handles null bundle_category", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "order_number": "ORD-123",
      };

      // Act
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel.fromJson(json: json);

      // Assert
      expect(model.bundleCategory, isNull);
    });

    test("constructor assigns values correctly", () {
      // Act
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel(
        isTopupAllowed: true,
        planStarted: true,
        bundleExpired: false,
        orderNumber: "TEST-001",
        orderStatus: "active",
        iccid: "123456789",
        displayTitle: "Test Bundle",
        bundleCode: "TEST-CODE",
        price: 25.00,
      );

      // Assert
      expect(model.isTopupAllowed, true);
      expect(model.planStarted, true);
      expect(model.bundleExpired, false);
      expect(model.orderNumber, "TEST-001");
      expect(model.orderStatus, "active");
      expect(model.iccid, "123456789");
      expect(model.displayTitle, "Test Bundle");
      expect(model.price, 25.00);
    });

    test("copyWith creates new instance with updated values", () {
      // Arrange
      final PurchaseEsimBundleResponseModel original =
          PurchaseEsimBundleResponseModel(
        orderNumber: "ORIGINAL",
        iccid: "111111",
        price: 10.00,
      );

      // Act
      final PurchaseEsimBundleResponseModel updated = original.copyWith(
        orderNumber: "UPDATED",
      );

      // Assert
      expect(updated.orderNumber, "UPDATED");
      expect(updated.iccid, "111111");
      expect(updated.price, 10.00);
    });

    test("copyWith preserves original values when no parameters provided", () {
      // Arrange
      final PurchaseEsimBundleResponseModel original =
          PurchaseEsimBundleResponseModel(
        orderNumber: "TEST",
        iccid: "123",
        price: 50.00,
      );

      // Act
      final PurchaseEsimBundleResponseModel copy = original.copyWith();

      // Assert
      expect(copy.orderNumber, "TEST");
      expect(copy.iccid, "123");
      expect(copy.price, 50.00);
    });

    test("copyWith updates multiple fields", () {
      // Arrange
      final PurchaseEsimBundleResponseModel original =
          PurchaseEsimBundleResponseModel(
        orderNumber: "OLD",
        iccid: "OLD_ICCID",
        price: 10.00,
      );

      // Act
      final PurchaseEsimBundleResponseModel updated = original.copyWith(
        orderNumber: "NEW",
        iccid: "NEW_ICCID",
        price: 20.00,
      );

      // Assert
      expect(updated.orderNumber, "NEW");
      expect(updated.iccid, "NEW_ICCID");
      expect(updated.price, 20.00);
    });

    test("toJson returns correct map with all fields", () {
      // Arrange
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel(
        isTopupAllowed: false,
        planStarted: true,
        bundleExpired: false,
        labelName: "Test Label",
        orderNumber: "ORD-999",
        orderStatus: "inactive",
        iccid: "999999",
        displayTitle: "Test Title",
        bundleCode: "TEST-999",
        price: 99.99,
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["is_topup_allowed"], false);
      expect(json["plan_started"], true);
      expect(json["bundle_expired"], false);
      expect(json["label_name"], "Test Label");
      expect(json["order_number"], "ORD-999");
      expect(json["order_status"], "inactive");
      expect(json["iccid"], "999999");
      expect(json["display_title"], "Test Title");
      expect(json["bundle_code"], "TEST-999");
      expect(json["price"], 99.99);
    });

    test("toJson handles null fields", () {
      // Arrange
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel();

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["is_topup_allowed"], isNull);
      expect(json["order_number"], isNull);
      expect(json["bundle_category"], isNull);
    });

    test("toJson includes bundle_category when present", () {
      // Arrange
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel(
        bundleCategory: BundleCategoryResponseModel(
          type: "GLOBAL",
          code: "GLB-001",
          title: "Global",
        ),
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["bundle_category"], isNotNull);
      expect(json["bundle_category"]["type"], "GLOBAL");
    });

    test("toJson includes countries when present", () {
      // Arrange
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel(
        countries: <CountryResponseModel>[
          CountryResponseModel(country: "USA", countryCode: "US"),
        ],
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["countries"], isNotNull);
      expect((json["countries"] as List<dynamic>).length, 1);
    });

    test("toJson includes transaction_history when present", () {
      // Arrange
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel(
        transactionHistory: <TransactionHistoryResponseModel>[
          TransactionHistoryResponseModel(userOrderId: "TXN-001"),
        ],
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["transaction_history"], isNotNull);
      expect((json["transaction_history"] as List<dynamic>).length, 1);
    });

    test("fromJsonList creates list from json array", () {
      // Arrange
      final List<Map<String, dynamic>> jsonList = <Map<String, dynamic>>[
        <String, dynamic>{
          "order_number": "ORD-1",
          "iccid": "111",
        },
        <String, dynamic>{
          "order_number": "ORD-2",
          "iccid": "222",
        },
      ];

      // Act
      final List<PurchaseEsimBundleResponseModel> models =
          PurchaseEsimBundleResponseModel.fromJsonList(json: jsonList);

      // Assert
      expect(models.length, 2);
      expect(models[0].orderNumber, "ORD-1");
      expect(models[1].orderNumber, "ORD-2");
    });

    test("fromJsonList handles empty list", () {
      // Arrange
      final List<dynamic> jsonList = <dynamic>[];

      // Act
      final List<PurchaseEsimBundleResponseModel> models =
          PurchaseEsimBundleResponseModel.fromJsonList(json: jsonList);

      // Assert
      expect(models, isEmpty);
    });

    test("mockItems returns list of mock bundles", () {
      // Act
      final List<PurchaseEsimBundleResponseModel> mockItems =
          PurchaseEsimBundleResponseModel.mockItems();

      // Assert
      expect(mockItems, isNotEmpty);
      expect(mockItems.length, 3);
    });

    test("mockItems all items have required fields", () {
      // Act
      final List<PurchaseEsimBundleResponseModel> mockItems =
          PurchaseEsimBundleResponseModel.mockItems();

      // Assert
      for (final PurchaseEsimBundleResponseModel item in mockItems) {
        expect(item.iccid, "123123");
        expect(item.orderStatus, "active");
        expect(item.bundleExpired, false);
        expect(item.countries, isNotNull);
      }
    });

    test("getters return correct values", () {
      // Arrange
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel(
        isTopupAllowed: true,
        planStarted: false,
        orderNumber: "TEST-ORD",
        iccid: "TEST-ICCID",
      );

      // Assert
      expect(model.isTopupAllowed, true);
      expect(model.planStarted, false);
      expect(model.orderNumber, "TEST-ORD");
      expect(model.iccid, "TEST-ICCID");
    });

    test("roundtrip fromJson and toJson preserves basic data", () {
      // Arrange
      final Map<String, dynamic> originalJson = <String, dynamic>{
        "order_number": "ORD-TEST",
        "iccid": "TEST-ICCID",
        "is_topup_allowed": true,
        "plan_started": false,
        "bundle_expired": true,
      };

      // Act
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel.fromJson(json: originalJson);
      final Map<String, dynamic> resultJson = model.toJson();

      // Assert
      expect(resultJson["order_number"], originalJson["order_number"]);
      expect(resultJson["iccid"], originalJson["iccid"]);
      expect(resultJson["is_topup_allowed"], originalJson["is_topup_allowed"]);
      expect(resultJson["plan_started"], originalJson["plan_started"]);
      expect(resultJson["bundle_expired"], originalJson["bundle_expired"]);
    });

    test("fromJson parses countries array", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "countries": <Map<String, dynamic>>[
          <String, dynamic>{"country": "France", "country_code": "FR"},
          <String, dynamic>{"country": "Germany", "country_code": "DE"},
        ],
      };

      // Act
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel.fromJson(json: json);

      // Assert
      expect(model.countries?.length, 2);
      expect(model.countries?[0].country, "France");
      expect(model.countries?[1].country, "Germany");
    });

    test("fromJson parses transaction_history array", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "transaction_history": <Map<String, dynamic>>[
          <String, dynamic>{"user_order_id": "TXN-1"},
          <String, dynamic>{"user_order_id": "TXN-2"},
        ],
      };

      // Act
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel.fromJson(json: json);

      // Assert
      expect(model.transactionHistory?.length, 2);
      expect(model.transactionHistory?[0].userOrderId, "TXN-1");
      expect(model.transactionHistory?[1].userOrderId, "TXN-2");
    });

    test("copyWith handles bundle_category", () {
      // Arrange
      final BundleCategoryResponseModel category = BundleCategoryResponseModel(
        type: "GLOBAL",
        code: "GLB-001",
        title: "Global",
      );
      final PurchaseEsimBundleResponseModel original =
          PurchaseEsimBundleResponseModel(
        orderNumber: "TEST",
      );

      // Act
      final PurchaseEsimBundleResponseModel updated = original.copyWith(
        bundleCategory: category,
      );

      // Assert
      expect(updated.bundleCategory, category);
    });

    test("copyWith handles countries list", () {
      // Arrange
      final List<CountryResponseModel> countries = <CountryResponseModel>[
        CountryResponseModel(country: "USA"),
      ];
      final PurchaseEsimBundleResponseModel original =
          PurchaseEsimBundleResponseModel();

      // Act
      final PurchaseEsimBundleResponseModel updated = original.copyWith(
        countries: countries,
      );

      // Assert
      expect(updated.countries, countries);
    });

    test("fromJson handles bundle_message with multiple items", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "bundle_message": <String>["Message 1", "Message 2", "Message 3"],
      };

      // Act
      final PurchaseEsimBundleResponseModel model =
          PurchaseEsimBundleResponseModel.fromJson(json: json);

      // Assert
      expect(model.bundleMessage?.length, 3);
      expect(model.bundleMessage?[0], "Message 1");
      expect(model.bundleMessage?[2], "Message 3");
    });
  });
}
