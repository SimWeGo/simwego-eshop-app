import "package:esim_open_source/data/remote/responses/bundles/country_response_model.dart";
import "package:flutter_test/flutter_test.dart";

/// Unit tests for CountryResponseModel
/// Tests JSON serialization/deserialization and model methods
void main() {
  group("CountryResponseModel Tests", () {
    test("fromJson creates instance with all fields populated", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "id": "country-001",
        "country": "France",
        "iso3_code": "FRA",
        "zone_name": "Europe",
        "country_code": "FR",
        "alternative_country": "République française",
        "icon": "https://flagsapi.com/FR/flat/64.png",
        "operator_list": <String>["Orange", "SFR", "Bouygues"],
      };

      // Act
      final CountryResponseModel model = CountryResponseModel.fromJson(json);

      // Assert
      expect(model.id, "country-001");
      expect(model.country, "France");
      expect(model.iso3Code, "FRA");
      expect(model.zoneName, "Europe");
      expect(model.countryCode, "FR");
      expect(model.alternativeCountry, "République française");
      expect(model.icon, "https://flagsapi.com/FR/flat/64.png");
      expect(model.operatorList, <String>["Orange", "SFR", "Bouygues"]);
    });

    test("fromJson handles null operator_list", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "country": "Germany",
        "country_code": "DE",
      };

      // Act
      final CountryResponseModel model = CountryResponseModel.fromJson(json);

      // Assert
      expect(model.country, "Germany");
      expect(model.operatorList, <String>[]);
    });

    test("fromJson handles missing fields", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{};

      // Act
      final CountryResponseModel model = CountryResponseModel.fromJson(json);

      // Assert
      expect(model.id, isNull);
      expect(model.country, isNull);
      expect(model.iso3Code, isNull);
      expect(model.zoneName, isNull);
      expect(model.countryCode, isNull);
      expect(model.alternativeCountry, isNull);
      expect(model.icon, isNull);
      expect(model.operatorList, <String>[]);
    });

    test("fromJson handles empty operator_list", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "country": "Spain",
        "operator_list": <String>[],
      };

      // Act
      final CountryResponseModel model = CountryResponseModel.fromJson(json);

      // Assert
      expect(model.country, "Spain");
      expect(model.operatorList, <String>[]);
    });

    test("constructor assigns values correctly", () {
      // Act
      final CountryResponseModel model = CountryResponseModel(
        id: "test-id",
        country: "Italy",
        iso3Code: "ITA",
        zoneName: "Southern Europe",
        countryCode: "IT",
        alternativeCountry: "Italia",
        icon: "https://flagsapi.com/IT/flat/64.png",
        operatorList: <String>["TIM", "Vodafone"],
      );

      // Assert
      expect(model.id, "test-id");
      expect(model.country, "Italy");
      expect(model.iso3Code, "ITA");
      expect(model.zoneName, "Southern Europe");
      expect(model.countryCode, "IT");
      expect(model.alternativeCountry, "Italia");
      expect(model.icon, "https://flagsapi.com/IT/flat/64.png");
      expect(model.operatorList, <String>["TIM", "Vodafone"]);
    });

    test("toJson returns correct map with all fields", () {
      // Arrange
      final CountryResponseModel model = CountryResponseModel(
        id: "uk-001",
        country: "United Kingdom",
        iso3Code: "GBR",
        zoneName: "Western Europe",
        countryCode: "GB",
        alternativeCountry: "UK",
        icon: "https://flagsapi.com/GB/flat/64.png",
        operatorList: <String>["EE", "O2", "Vodafone"],
      );

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["id"], "uk-001");
      expect(json["alternative_country"], "UK");
      expect(json["country"], "United Kingdom");
      expect(json["country_code"], "GB");
      expect(json["iso2_code"], "GBR");
      expect(json["zone_name"], "Western Europe");
      expect(json["icon"], "https://flagsapi.com/GB/flat/64.png");
      expect(json["operator_list"], <String>["EE", "O2", "Vodafone"]);
    });

    test("toJson handles null fields", () {
      // Arrange
      final CountryResponseModel model = CountryResponseModel();

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["id"], isNull);
      expect(json["country"], isNull);
      expect(json["country_code"], isNull);
      expect(json["iso2_code"], isNull);
      expect(json["zone_name"], isNull);
      expect(json["icon"], isNull);
      expect(json["operator_list"], isNull);
    });

    test("getMockCountries returns list of mock countries", () {
      // Act
      final List<CountryResponseModel> mockCountries =
          CountryResponseModel.getMockCountries();

      // Assert
      expect(mockCountries, isNotEmpty);
      expect(mockCountries.length, greaterThan(20));
    });

    test("getMockCountries first country has expected values", () {
      // Act
      final List<CountryResponseModel> mockCountries =
          CountryResponseModel.getMockCountries();
      final CountryResponseModel firstCountry = mockCountries[0];

      // Assert
      expect(firstCountry.country, "Abkhazia");
      expect(firstCountry.countryCode, "GE");
      expect(firstCountry.iso3Code, "KAZ");
      expect(firstCountry.alternativeCountry, "Georgia");
      expect(firstCountry.icon, "https://flagsapi.com/GE/flat/64.png");
    });

    test("getMockCountries contains expected countries", () {
      // Act
      final List<CountryResponseModel> mockCountries =
          CountryResponseModel.getMockCountries();
      final List<String?> countryNames =
          mockCountries.map((CountryResponseModel c) => c.country).toList();

      // Assert
      expect(countryNames, contains("Albania"));
      expect(countryNames, contains("Belgium"));
      expect(countryNames, contains("Argentina"));
    });

    test("getMockCountries all countries have required fields", () {
      // Act
      final List<CountryResponseModel> mockCountries =
          CountryResponseModel.getMockCountries();

      // Assert
      for (final CountryResponseModel country in mockCountries) {
        expect(country.country, isNotNull);
        expect(country.countryCode, isNotNull);
        expect(country.icon, isNotNull);
        expect(country.icon, contains("https://flagsapi.com"));
      }
    });

    test("roundtrip fromJson and toJson handles data correctly", () {
      // Arrange
      final Map<String, dynamic> originalJson = <String, dynamic>{
        "id": "test-123",
        "country": "Canada",
        "iso3_code": "CAN",
        "zone_name": "North America",
        "country_code": "CA",
        "alternative_country": "Canada",
        "icon": "https://flagsapi.com/CA/flat/64.png",
        "operator_list": <String>["Rogers", "Bell"],
      };

      // Act
      final CountryResponseModel model =
          CountryResponseModel.fromJson(originalJson);
      final Map<String, dynamic> resultJson = model.toJson();

      // Assert
      expect(resultJson["id"], originalJson["id"]);
      expect(resultJson["country"], originalJson["country"]);
      expect(resultJson["country_code"], originalJson["country_code"]);
      expect(resultJson["alternative_country"], originalJson["alternative_country"]);
      expect(resultJson["icon"], originalJson["icon"]);
      expect(resultJson["operator_list"], originalJson["operator_list"]);
    });

    test("getMockCountries Belgium has correct values", () {
      // Act
      final List<CountryResponseModel> mockCountries =
          CountryResponseModel.getMockCountries();
      final CountryResponseModel belgium = mockCountries.firstWhere(
        (CountryResponseModel c) => c.country == "Belgium",
      );

      // Assert
      expect(belgium.countryCode, "BE");
      expect(belgium.iso3Code, "BEL");
      expect(belgium.alternativeCountry, "Belgium");
      expect(belgium.icon, "https://flagsapi.com/BE/flat/64.png");
    });
  });
}
