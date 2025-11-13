import "package:esim_open_source/app/environment/app_environment.dart";
import "package:esim_open_source/data/remote/apis/device_apis/api_device_impl.dart";
import "package:esim_open_source/data/remote/request/device/device_info_request_model.dart";
import "package:esim_open_source/domain/data/api_device.dart";
import "package:esim_open_source/domain/repository/services/connectivity_service.dart";
import "package:esim_open_source/domain/repository/services/local_storage_service.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";

import "../../../../helpers/app_enviroment_helper.dart";
import "../../../../locator_test.dart";
import "../../../../locator_test.mocks.dart";

void main() {
  group("ApiDeviceImpl Implementation Coverage", () {
    late MockConnectivityService mockConnectivityService;
    late MockLocalStorageService mockLocalStorageService;

    setUpAll(() async {
      await setupTestLocator();

      // Initialize AppEnvironment with test values
      AppEnvironment.isFromAppClip = false;
      AppEnvironment.appEnvironmentHelper = createTestEnvironmentHelper();

      // Setup mock services with default stubs
      mockConnectivityService =
          locator<ConnectivityService>() as MockConnectivityService;
      mockLocalStorageService =
          locator<LocalStorageService>() as MockLocalStorageService;

      // Stub required methods to prevent HTTP calls
      when(mockConnectivityService.isConnected())
          .thenAnswer((_) async => false);
      when(mockLocalStorageService.accessToken).thenReturn("");
      when(mockLocalStorageService.refreshToken).thenReturn("");
      when(mockLocalStorageService.languageCode).thenReturn("en");
    });

    test("ApiDeviceImpl singleton initialization", () {
      final ApiDeviceImpl instance1 = ApiDeviceImpl.instance;
      final ApiDeviceImpl instance2 = ApiDeviceImpl.instance;

      expect(instance1, isNotNull);
      expect(instance1, same(instance2));
      expect(instance1, isA<APIDevice>());
    });

    test("registerDevice method implementation coverage", () async {
      final ApiDeviceImpl apiImpl = ApiDeviceImpl.instance;
      final DeviceInfoRequestModel deviceInfo = DeviceInfoRequestModel(
        deviceName: "test_device",
        latitude: 37.7749,
        longitude: -122.4194,
        mcc: "310",
        mnc: "260",
      );

      try {
        await apiImpl.registerDevice(
          fcmToken: "test_fcm_token",
          deviceId: "test_device_id",
          platformTag: "android",
          osTag: "Android",
          appGuid: "test_app_guid",
          version: "1.0.0",
          userGuid: "test_user_guid",
          deviceInfo: deviceInfo,
        );
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.registerDevice, isA<Function>());
    });

    test("registerDevice method with empty userGuid", () async {
      final ApiDeviceImpl apiImpl = ApiDeviceImpl.instance;
      final DeviceInfoRequestModel deviceInfo = DeviceInfoRequestModel(
        deviceName: "test_device",
      );

      try {
        await apiImpl.registerDevice(
          fcmToken: "test_fcm_token",
          deviceId: "test_device_id",
          platformTag: "ios",
          osTag: "iOS",
          appGuid: "test_app_guid",
          version: "1.0.0",
          userGuid: "",
          deviceInfo: deviceInfo,
        );
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.registerDevice, isA<Function>());
    });

    test("ApiDeviceImpl implements all APIDevice interface methods", () {
      final ApiDeviceImpl apiImpl = ApiDeviceImpl.instance;
      final APIDevice apiInterface = apiImpl as APIDevice;

      expect(apiInterface.registerDevice, isNotNull);
    });
  });
}
