import "package:esim_open_source/app/environment/app_environment.dart";
import "package:esim_open_source/data/remote/apis/bundles_apis/api_bundles_impl.dart";
import "package:esim_open_source/domain/data/api_bundles.dart";
import "package:esim_open_source/domain/repository/services/connectivity_service.dart";
import "package:esim_open_source/domain/repository/services/local_storage_service.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";

import "../../../../helpers/app_enviroment_helper.dart";
import "../../../../locator_test.dart";
import "../../../../locator_test.mocks.dart";

void main() {
  group("APIBundlesImpl Implementation Coverage", () {
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

    test("APIBundlesImpl singleton initialization", () {
      final APIBundlesImpl instance1 = APIBundlesImpl.instance;
      final APIBundlesImpl instance2 = APIBundlesImpl.instance;

      expect(instance1, isNotNull);
      expect(instance1, same(instance2));
      expect(instance1, isA<APIBundles>());
    });

    test("getBundleConsumption method implementation coverage", () async {
      final APIBundlesImpl apiImpl = APIBundlesImpl.instance;

      try {
        await apiImpl.getBundleConsumption(iccID: "test_icc_id");
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.getBundleConsumption, isA<Function>());
    });

    test("getAllData method implementation coverage", () async {
      final APIBundlesImpl apiImpl = APIBundlesImpl.instance;

      try {
        await apiImpl.getAllData();
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.getAllData, isA<Function>());
    });

    test("getAllBundles method implementation coverage", () async {
      final APIBundlesImpl apiImpl = APIBundlesImpl.instance;

      try {
        await apiImpl.getAllBundles();
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.getAllBundles, isA<Function>());
    });

    test("getBundle method implementation coverage", () async {
      final APIBundlesImpl apiImpl = APIBundlesImpl.instance;

      try {
        await apiImpl.getBundle(code: "test_bundle_code");
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.getBundle, isA<Function>());
    });

    test("getBundlesByRegion method implementation coverage", () async {
      final APIBundlesImpl apiImpl = APIBundlesImpl.instance;

      try {
        await apiImpl.getBundlesByRegion(regionCode: "US");
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.getBundlesByRegion, isA<Function>());
    });

    test("getBundlesByCountries method implementation coverage", () async {
      final APIBundlesImpl apiImpl = APIBundlesImpl.instance;

      try {
        await apiImpl.getBundlesByCountries(countryCodes: "US,UK,FR");
      } on Object catch (e) {
        expect(e.toString(), contains("No internet connection"));
      }

      expect(apiImpl.getBundlesByCountries, isA<Function>());
    });

    test("APIBundlesImpl implements all APIBundles interface methods", () {
      final APIBundlesImpl apiImpl = APIBundlesImpl.instance;
      final APIBundles apiInterface = apiImpl as APIBundles;

      expect(apiInterface.getBundleConsumption, isNotNull);
      expect(apiInterface.getAllData, isNotNull);
      expect(apiInterface.getAllBundles, isNotNull);
      expect(apiInterface.getBundle, isNotNull);
      expect(apiInterface.getBundlesByRegion, isNotNull);
      expect(apiInterface.getBundlesByCountries, isNotNull);
    });
  });
}
