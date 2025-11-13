import "package:esim_open_source/data/remote/responses/bundles/bundle_category_response_model.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("BundleCategoryResponseModel Tests", () {
    test("fromJson creates instance with all fields populated", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "type": "REGIONAL",
        "code": "reg-001",
        "title": "Regional",
      };

      // Act
      final BundleCategoryResponseModel model =
          BundleCategoryResponseModel.fromJson(json);

      // Assert
      expect(model.type, "REGIONAL");
      expect(model.code, "reg-001");
      expect(model.title, "Regional");
    });

    test("fromJson handles null fields", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{};

      // Act
      final BundleCategoryResponseModel model =
          BundleCategoryResponseModel.fromJson(json);

      // Assert
      expect(model.type, isNull);
      expect(model.code, isNull);
      expect(model.title, isNull);
    });

    test("constructor assigns values correctly", () {
      // Act
      final BundleCategoryResponseModel model = BundleCategoryResponseModel(
        type: "GLOBAL",
        code: "global-001",
        title: "Global",
      );

      // Assert
      expect(model.type, "GLOBAL");
      expect(model.code, "global-001");
      expect(model.title, "Global");
    });

    test("toJson returns correct map with all fields", () {
      // Arrange
      final BundleCategoryResponseModel model = BundleCategoryResponseModel(
        type: "LOCAL",
        code: "local-001",
        title: "Local",
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["type"], "LOCAL");
      expect(json["code"], "local-001");
      expect(json["title"], "Local");
    });

    test("toJson handles null fields", () {
      // Arrange
      final BundleCategoryResponseModel model = BundleCategoryResponseModel();

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["type"], isNull);
      expect(json["code"], isNull);
      expect(json["title"], isNull);
    });
  });
}
