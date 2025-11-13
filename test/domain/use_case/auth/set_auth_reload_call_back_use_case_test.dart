import "package:esim_open_source/data/remote/auth_reload_interface.dart";
import "package:esim_open_source/domain/repository/api_auth_repository.dart";
import "package:esim_open_source/domain/use_case/auth/set_auth_reload_call_back_use_case.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";

import "../../../helpers/test_environment_setup.dart";
import "../../../locator_test.dart";
import "../../../locator_test.mocks.dart";

/// Unit tests for AddAuthReloadCallBackUseCase
/// Tests the auth reload callback registration functionality
Future<void> main() async {
  await TestEnvironmentSetup.initializeTestEnvironment();

  late AddAuthReloadCallBackUseCase useCase;
  late MockApiAuthRepository mockRepository;

  setUp(() async {
    await setupTestLocator();
    mockRepository = locator<ApiAuthRepository>() as MockApiAuthRepository;
    useCase = AddAuthReloadCallBackUseCase(mockRepository);
  });

  tearDown(() async {
    await locator.reset();
  });

  group("AddAuthReloadCallBackUseCase Tests", () {
    test("execute calls repository to add auth reload listener", () {
      // Arrange
      final MockAuthReloadListener mockListener = MockAuthReloadListener();
      final AuthReloadAccessCallBackParams params = AuthReloadAccessCallBackParams(mockListener);

      when(mockRepository.addAuthReloadListenerCallBack(any)).thenReturn(null);

      // Act
      useCase.execute(params);

      // Assert
      verify(mockRepository.addAuthReloadListenerCallBack(mockListener)).called(1);
    });

    test("execute handles multiple listener registrations", () {
      // Arrange
      final MockAuthReloadListener mockListener1 = MockAuthReloadListener();
      final MockAuthReloadListener mockListener2 = MockAuthReloadListener();

      final AuthReloadAccessCallBackParams params1 = AuthReloadAccessCallBackParams(mockListener1);
      final AuthReloadAccessCallBackParams params2 = AuthReloadAccessCallBackParams(mockListener2);

      when(mockRepository.addAuthReloadListenerCallBack(any)).thenReturn(null);

      // Act
      useCase..execute(params1)
      ..execute(params2);

      // Assert
      verify(mockRepository.addAuthReloadListenerCallBack(mockListener1)).called(1);
      verify(mockRepository.addAuthReloadListenerCallBack(mockListener2)).called(1);
    });

    test("execute registers listener without throwing exceptions", () {
      // Arrange
      final MockAuthReloadListener mockListener = MockAuthReloadListener();
      final AuthReloadAccessCallBackParams params = AuthReloadAccessCallBackParams(mockListener);

      when(mockRepository.addAuthReloadListenerCallBack(any)).thenReturn(null);

      // Act & Assert
      expect(() => useCase.execute(params), returnsNormally);
    });
  });
}

/// Mock implementation of AuthReloadListener for testing
class MockAuthReloadListener implements AuthReloadListener {
  @override
  void onAuthReloadListenerCallBackUseCase(dynamic response) {
    // Mock implementation
  }
}
