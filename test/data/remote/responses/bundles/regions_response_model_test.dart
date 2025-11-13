import "package:esim_open_source/data/remote/responses/bundles/regions_response_model.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for RegionsResponseModel
/// Tests JSON serialization/deserialization and model methods
void main() {
  group("RegionsResponseModel Tests", () {
    test("fromJson creates instance with all fields populated", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "region_code": "29b0bf21-0861-4222-839c-0da178a6371c",
        "region_name": "GLOBAL",
        "zone_name": "Global Zone",
        "icon": "https://example.com/icon.png",
      };

      // Act
      final RegionsResponseModel model = RegionsResponseModel.fromJson(json);

      // Assert
      expect(model.regionCode, "29b0bf21-0861-4222-839c-0da178a6371c");
      expect(model.regionName, "GLOBAL");
      expect(model.zoneName, "Global Zone");
      expect(model.icon, "https://example.com/icon.png");
    });

    test("fromJson handles missing fields", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{};

      // Act
      final RegionsResponseModel model = RegionsResponseModel.fromJson(json);

      // Assert
      expect(model.regionCode, isNull);
      expect(model.regionName, isNull);
      expect(model.zoneName, isNull);
      expect(model.icon, isNull);
    });

    test("fromJson handles partial data", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "region_name": "EUROPE",
      };

      // Act
      final RegionsResponseModel model = RegionsResponseModel.fromJson(json);

      // Assert
      expect(model.regionName, "EUROPE");
      expect(model.regionCode, isNull);
      expect(model.zoneName, isNull);
      expect(model.icon, isNull);
    });

    test("constructor assigns values correctly", () {
      // Act
      final RegionsResponseModel model = RegionsResponseModel(
        regionCode: "code-123",
        regionName: "ASIA",
        zoneName: "Asia Pacific",
        icon: "https://example.com/asia.png",
      );

      // Assert
      expect(model.regionCode, "code-123");
      expect(model.regionName, "ASIA");
      expect(model.zoneName, "Asia Pacific");
      expect(model.icon, "https://example.com/asia.png");
    });

    test("toJson returns correct map with all fields", () {
      // Arrange
      final RegionsResponseModel model = RegionsResponseModel(
        regionCode: "test-code",
        regionName: "TEST_REGION",
        zoneName: "Test Zone",
        icon: "https://test.com/icon.png",
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["region_code"], "test-code");
      expect(json["region_name"], "TEST_REGION");
      expect(json["zone_name"], "Test Zone");
      expect(json["icon"], "https://test.com/icon.png");
    });

    test("toJson handles null fields", () {
      // Arrange
      final RegionsResponseModel model = RegionsResponseModel();

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["region_code"], isNull);
      expect(json["region_name"], isNull);
      expect(json["zone_name"], isNull);
      expect(json["icon"], isNull);
    });

    test("roundtrip fromJson and toJson preserves data", () {
      // Arrange
      final Map<String, dynamic> originalJson = <String, dynamic>{
        "region_code": "abc-123",
        "region_name": "AFRICA",
        "zone_name": "Africa",
        "icon": "https://example.com/africa.png",
      };

      // Act
      final RegionsResponseModel model =
          RegionsResponseModel.fromJson(originalJson);
      final Map<String, dynamic> resultJson = model.toJson();

      // Assert
      expect(resultJson, originalJson);
    });

    test("getMockRegions returns list of mock regions", () {
      // Act
      final List<RegionsResponseModel> mockRegions =
          RegionsResponseModel.getMockRegions();

      // Assert
      expect(mockRegions, isNotEmpty);
      expect(mockRegions.length, 4);
      expect(mockRegions[0].regionName, "GLOBAL");
      expect(mockRegions[1].regionName, "ZONE_TEST_11");
      expect(mockRegions[2].regionName, "ZONE_TESTTT3");
      expect(mockRegions[3].regionName, "EUROPE");
    });

    test("getMockRegions returns regions with all fields", () {
      // Act
      final List<RegionsResponseModel> mockRegions =
          RegionsResponseModel.getMockRegions();

      // Assert
      for (final RegionsResponseModel region in mockRegions) {
        expect(region.regionName, isNotNull);
        expect(region.zoneName, isNotNull);
        expect(region.regionCode, isNotNull);
        expect(region.icon, isNotNull);
        expect(region.icon, contains("https://placehold.co"));
      }
    });

    test("getMockRegions first item has expected values", () {
      // Act
      final List<RegionsResponseModel> mockRegions =
          RegionsResponseModel.getMockRegions();
      final RegionsResponseModel firstRegion = mockRegions[0];

      // Assert
      expect(firstRegion.regionName, "GLOBAL");
      expect(firstRegion.zoneName, "GLOBAL");
      expect(firstRegion.regionCode, "29b0bf21-0861-4222-839c-0da178a6371c");
      expect(firstRegion.icon, "https://placehold.co/400x400");
    });

    test("getMockRegions last item has expected values", () {
      // Act
      final List<RegionsResponseModel> mockRegions =
          RegionsResponseModel.getMockRegions();
      final RegionsResponseModel lastRegion = mockRegions.last;

      // Assert
      expect(lastRegion.regionName, "EUROPE");
      expect(lastRegion.zoneName, "Europe");
      expect(lastRegion.regionCode, "742bb566-517f-e311-93f4-80ee7353f479");
      expect(lastRegion.icon, "https://placehold.co/400x400");
    });
  });
}
