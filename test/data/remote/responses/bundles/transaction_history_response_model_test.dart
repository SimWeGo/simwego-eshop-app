import "package:esim_open_source/data/remote/responses/bundles/bundle_response_model.dart";
import "package:esim_open_source/data/remote/responses/bundles/transaction_history_response_model.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("TransactionHistoryResponseModel Tests", () {
    test("fromJson creates instance with all fields populated", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "user_order_id": "order-123",
        "iccid": "iccid-456",
        "bundle_type": "data",
        "plan_started": true,
        "bundle_expired": false,
        "created_at": "2024-01-01",
        "bundle": <String, dynamic>{
          "bundle_code": "BUNDLE-001",
          "display_title": "Test Bundle",
        },
      };

      // Act
      final TransactionHistoryResponseModel model =
          TransactionHistoryResponseModel.fromJson(json);

      // Assert
      expect(model.userOrderId, "order-123");
      expect(model.iccid, "iccid-456");
      expect(model.bundleType, "data");
      expect(model.planStarted, true);
      expect(model.bundleExpired, false);
      expect(model.createdAt, "2024-01-01");
      expect(model.bundle, isNotNull);
    });

    test("fromJson handles null bundle", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "user_order_id": "order-123",
      };

      // Act
      final TransactionHistoryResponseModel model =
          TransactionHistoryResponseModel.fromJson(json);

      // Assert
      expect(model.userOrderId, "order-123");
      expect(model.bundle, isNull);
    });

    test("constructor assigns values correctly", () {
      // Arrange
      final BundleResponseModel bundle = BundleResponseModel(
        bundleCode: "BUNDLE-001",
      );

      // Act
      final TransactionHistoryResponseModel model =
          TransactionHistoryResponseModel(
        userOrderId: "order-456",
        iccid: "iccid-789",
        bundleType: "voice",
        planStarted: false,
        bundleExpired: true,
        createdAt: "2024-02-01",
        bundle: bundle,
      );

      // Assert
      expect(model.userOrderId, "order-456");
      expect(model.iccid, "iccid-789");
      expect(model.bundleType, "voice");
      expect(model.planStarted, false);
      expect(model.bundleExpired, true);
      expect(model.createdAt, "2024-02-01");
      expect(model.bundle, bundle);
    });

    test("toJson returns correct map with all fields", () {
      // Arrange
      final BundleResponseModel bundle = BundleResponseModel(
        bundleCode: "BUNDLE-001",
      );
      final TransactionHistoryResponseModel model =
          TransactionHistoryResponseModel(
        userOrderId: "order-123",
        iccid: "iccid-456",
        bundleType: "data",
        planStarted: true,
        bundleExpired: false,
        createdAt: "2024-01-01",
        bundle: bundle,
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["user_order_id"], "order-123");
      expect(json["iccid"], "iccid-456");
      expect(json["bundle_type"], "data");
      expect(json["plan_started"], true);
      expect(json["bundle_expired"], false);
      expect(json["created_at"], "2024-01-01");
      expect(json["bundle"], isNotNull);
    });

    test("toJson handles null fields", () {
      // Arrange
      final TransactionHistoryResponseModel model =
          TransactionHistoryResponseModel();

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["user_order_id"], isNull);
      expect(json["iccid"], isNull);
      expect(json["bundle_type"], isNull);
      expect(json["plan_started"], isNull);
      expect(json["bundle_expired"], isNull);
      expect(json["created_at"], isNull);
      expect(json["bundle"], isNull);
    });
  });
}
