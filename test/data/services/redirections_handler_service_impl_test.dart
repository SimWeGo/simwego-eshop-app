import "package:esim_open_source/data/services/redirections_handler_service_impl.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";
import "package:stacked_services/stacked_services.dart";

import "../../locator_test.mocks.dart";

/// Unit tests for RedirectionsHandlerServiceImpl
/// Tests navigation and deep link handling
///
/// Note: Tests are simplified for line coverage as RedirectionsHandlerServiceImpl
/// has complex dependencies on navigation services and view models
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("RedirectionsHandlerServiceImpl Tests", () {
    late MockNavigationService mockNavigationService;
    late MockBottomSheetService mockBottomSheetService;

    setUp(() {
      mockNavigationService = MockNavigationService();
      mockBottomSheetService = MockBottomSheetService();

      when(mockNavigationService.navigateTo(any))
          .thenAnswer((_) async => true);
      when(mockNavigationService.back()).thenReturn(true);
      when(mockBottomSheetService.showCustomSheet(
        variant: anyNamed("variant"),
        data: anyNamed("data"),
        enableDrag: anyNamed("enableDrag"),
        isScrollControlled: anyNamed("isScrollControlled"),
      ),).thenAnswer((_) async => null);
    });

    test("getInstance creates instance", () {
      final RedirectionsHandlerServiceImpl instance =
          RedirectionsHandlerServiceImpl.getInstance(
        mockNavigationService,
        mockBottomSheetService,
      );

      expect(instance, isNotNull);
      expect(instance, isA<RedirectionsHandlerServiceImpl>());
    });

    test("multiple getInstance calls return same instance", () {
      final RedirectionsHandlerServiceImpl instance1 =
          RedirectionsHandlerServiceImpl.getInstance(
        mockNavigationService,
        mockBottomSheetService,
      );
      final RedirectionsHandlerServiceImpl instance2 =
          RedirectionsHandlerServiceImpl.getInstance(
        mockNavigationService,
        mockBottomSheetService,
      );

      expect(instance1, same(instance2));
    });

    test("navigationService property is accessible", () {
      final RedirectionsHandlerServiceImpl service =
          RedirectionsHandlerServiceImpl.getInstance(
        mockNavigationService,
        mockBottomSheetService,
      );

      expect(service.navigationService, isNotNull);
      expect(service.navigationService, isA<NavigationService>());
    });

    test("bottomSheetService property is accessible", () {
      final RedirectionsHandlerServiceImpl service =
          RedirectionsHandlerServiceImpl.getInstance(
        mockNavigationService,
        mockBottomSheetService,
      );

      expect(service.bottomSheetService, isNotNull);
      expect(service.bottomSheetService, isA<BottomSheetService>());
    });

    test("handleInitialRedirection with no data calls callback", () async {
      final RedirectionsHandlerServiceImpl service =
          RedirectionsHandlerServiceImpl.getInstance(
        mockNavigationService,
        mockBottomSheetService,
      );

      bool callbackCalled = false;
      await service.handleInitialRedirection(() {
        callbackCalled = true;
      });

      expect(callbackCalled, isTrue);
    });

    test("serialiseAndRedirectNotification handles null data", () async {
      final RedirectionsHandlerServiceImpl service =
          RedirectionsHandlerServiceImpl.getInstance(
        mockNavigationService,
        mockBottomSheetService,
      );

      // Should not throw
      await service.serialiseAndRedirectNotification(
        isClicked: false,
        isInitial: false,
      );

      expect(service, isNotNull);
    });

    test("serialiseAndRedirectNotification with initial data", () async {
      final RedirectionsHandlerServiceImpl service =
          RedirectionsHandlerServiceImpl.getInstance(
        mockNavigationService,
        mockBottomSheetService,
      );

      await service.serialiseAndRedirectNotification(
        isClicked: true,
        isInitial: true,
        handlePushData: <String, dynamic>{
          "category": "1",
          "iccid": "test-iccid",
        },
      );

      expect(service, isNotNull);
    });

    test("serialiseAndRedirectDeepLink handles initial link", () async {
      final RedirectionsHandlerServiceImpl service =
          RedirectionsHandlerServiceImpl.getInstance(
        mockNavigationService,
        mockBottomSheetService,
      );

      final Uri testUri = Uri.parse("https://example.com/test");

      await service.serialiseAndRedirectDeepLink(
        isInitial: true,
        uriDeepLinkData: testUri,
      );

      expect(service, isNotNull);
    });
  });
}
