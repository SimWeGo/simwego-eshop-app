import "package:esim_open_source/data/remote/responses/skeleton_responses/skeleton_responses.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("BaseAPIResponse Tests", () {
    test("success constructor creates instance with success result", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "message": "Success",
        "code": "200",
        "success": true,
        "version": "1.0",
        "data": <String, dynamic>{"fact": "test", "length": 4},
      };

      // Act
      final BaseAPIResponse<FactModel> response =
          BaseAPIResponse<FactModel>.success(
        json,
        FactModel.fromJson,
      );

      // Assert
      expect(response.message, "Success");
      expect(response.code, "200");
      expect(response.success, true);
      expect(response.version, "1.0");
      expect(response.data, isNotNull);
      expect(response.result, ApiResponseResultEnum.success);
    });

    test("success constructor handles list data", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "message": "Success",
        "data": <Map<String, dynamic>>[
          <String, dynamic>{"fact": "fact1", "length": 5},
          <String, dynamic>{"fact": "fact2", "length": 5},
        ],
      };

      // Act
      final BaseAPIResponse<FactModel> response =
          BaseAPIResponse<FactModel>.success(
        json,
        FactModel.fromJson,
      );

      // Assert
      expect(response.data, isList);
      expect((response.data as List<dynamic>).length, 2);
    });

    test("failure constructor creates instance with failure result", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "message": "Error",
        "code": "400",
        "success": false,
        "version": "1.0",
      };

      // Act
      final BaseAPIResponse<FactModel> response =
          BaseAPIResponse<FactModel>.failure(
        json,
        FactModel.fromJson,
      );

      // Assert
      expect(response.message, "Error");
      expect(response.code, "400");
      expect(response.success, false);
      expect(response.result, ApiResponseResultEnum.failure);
    });

    test("dynamicError constructor creates error response", () {
      // Act
      final BaseAPIResponse<FactModel> response =
          BaseAPIResponse<FactModel>.dynamicError(
        message: "Dynamic error",
        responseCode: "500",
      );

      // Assert
      expect(response.message, "Dynamic error");
      expect(response.code, "500");
      expect(response.success, false);
      expect(response.version, "1");
      expect(response.data, isNull);
      expect(response.result, ApiResponseResultEnum.failure);
    });
  });

  group("FactModel Tests", () {
    test("fromJson creates instance with all fields", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "fact": "Test fact",
        "length": 10,
      };

      // Act
      final FactModel model = FactModel.fromJson(json);

      // Assert
      expect(model.fact, "Test fact");
      expect(model.length, 10);
    });

    test("fromJson handles missing fields", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{};

      // Act
      final FactModel model = FactModel.fromJson(json);

      // Assert
      expect(model.fact, "");
      expect(model.length, 0);
    });

    test("fromJsonDynamic creates instance", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "fact": "Dynamic fact",
        "length": 15,
      };

      // Act
      final FactModel model = FactModel.fromJsonDynamic(json: json);

      // Assert
      expect(model.fact, "Dynamic fact");
      expect(model.length, 15);
    });

    test("constructor assigns values correctly", () {
      // Act
      final FactModel model = FactModel("Test", 4);

      // Assert
      expect(model.fact, "Test");
      expect(model.length, 4);
    });

    test("toJson returns correct map", () {
      // Arrange
      final FactModel model = FactModel("Fact", 4);

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["fact"], "Fact");
      expect(json["length"], 4);
    });

    test("mockData returns valid fact model", () {
      // Act
      final FactModel mock = FactModel.mockData;

      // Assert
      expect(mock.fact, "this is a fact");
      expect(mock.length, 0);
    });
  });

  group("RefreshTokenModel Tests", () {
    test("fromJson creates instance with all fields", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "token": "access_token",
        "refreshToken": "refresh_token",
      };

      // Act
      final RefreshTokenModel model = RefreshTokenModel.fromJson(json);

      // Assert
      expect(model.token, "access_token");
      expect(model.refreshToken, "refresh_token");
    });

    test("fromJson handles missing fields", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{};

      // Act
      final RefreshTokenModel model = RefreshTokenModel.fromJson(json);

      // Assert
      expect(model.token, "");
      expect(model.refreshToken, "");
    });

    test("constructor assigns values correctly", () {
      // Act
      final RefreshTokenModel model =
          RefreshTokenModel("token123", "refresh123");

      // Assert
      expect(model.token, "token123");
      expect(model.refreshToken, "refresh123");
    });

    test("toJson returns correct map", () {
      // Arrange
      final RefreshTokenModel model =
          RefreshTokenModel("access", "refresh");

      // Act
      final Map<String, dynamic> json = model.toJson();

      // Assert
      expect(json["token"], "access");
      expect(json["refreshToken"], "refresh");
    });
  });

  group("CoinModel Tests", () {
    test("fromJson creates instance with all fields", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{
        "id": "bitcoin",
        "name": "Bitcoin",
        "symbol": "BTC",
      };

      // Act
      final CoinModel model = CoinModel.fromJson(json);

      // Assert
      expect(model.coinID, "bitcoin");
      expect(model.coinName, "Bitcoin");
      expect(model.coinSymbol, "BTC");
    });

    test("fromJson handles missing fields", () {
      // Arrange
      final Map<String, dynamic> json = <String, dynamic>{};

      // Act
      final CoinModel model = CoinModel.fromJson(json);

      // Assert
      expect(model.coinID, "");
      expect(model.coinName, "");
      expect(model.coinSymbol, "");
    });

    test("constructor assigns values correctly", () {
      // Act
      final CoinModel model = CoinModel("eth", "Ethereum", "ETH");

      // Assert
      expect(model.coinID, "eth");
      expect(model.coinName, "Ethereum");
      expect(model.coinSymbol, "ETH");
    });
  });

  group("ApiResponseResultEnum Tests", () {
    test("enum has success and failure values", () {
      // Assert
      expect(ApiResponseResultEnum.success, isNotNull);
      expect(ApiResponseResultEnum.failure, isNotNull);
      expect(ApiResponseResultEnum.values.length, 2);
    });
  });
}
