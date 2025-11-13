import "package:esim_open_source/data/remote/unauthorized_access_interface.dart";
import "package:esim_open_source/domain/repository/api_auth_repository.dart";
import "package:esim_open_source/domain/use_case/auth/set_unauthorized_access_call_back_use_case.dart";
import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart";
import "package:mockito/mockito.dart";

import "../../../helpers/test_environment_setup.dart";
import "../../../locator_test.dart";
import "../../../locator_test.mocks.dart";

/// Mock implementation of UnauthorizedAccessListener for testing
class MockUnauthorizedAccessListener implements UnauthorizedAccessListener {
  int callCount = 0;
  BaseResponse? lastResponse;
  Exception? lastException;

  @override
  void onUnauthorizedAccessCallBackUseCase(
    BaseResponse? response,
    Exception? e,
  ) {
    callCount++;
    lastResponse = response;
    lastException = e;
  }
}

/// Unit tests for AddUnauthorizedAccessCallBackUseCase
/// Tests the unauthorized access callback registration functionality
Future<void> main() async {
  await TestEnvironmentSetup.initializeTestEnvironment();

  late AddUnauthorizedAccessCallBackUseCase useCase;
  late MockApiAuthRepository mockRepository;

  setUp(() async {
    await setupTestLocator();
    mockRepository = locator<ApiAuthRepository>() as MockApiAuthRepository;
    useCase = AddUnauthorizedAccessCallBackUseCase(mockRepository);
  });

  tearDown(() async {
    await locator.reset();
  });

  group("AddUnauthorizedAccessCallBackUseCase Tests", () {
    test("execute calls repository to add unauthorized access listener", () {
      // Arrange
      final UnauthorizedAccessListener mockListener = MockUnauthorizedAccessListener();
      final UnauthorizedAccessCallBackParams params = UnauthorizedAccessCallBackParams(mockListener);

      when(mockRepository.addUnauthorizedAccessListener(any)).thenReturn(null);

      // Act
      useCase.execute(params);

      // Assert
      verify(mockRepository.addUnauthorizedAccessListener(mockListener)).called(1);
    });

    test("execute handles multiple listener registrations", () {
      // Arrange
      final UnauthorizedAccessListener mockListener1 = MockUnauthorizedAccessListener();
      final UnauthorizedAccessListener mockListener2 = MockUnauthorizedAccessListener();

      final UnauthorizedAccessCallBackParams params1 = UnauthorizedAccessCallBackParams(mockListener1);
      final UnauthorizedAccessCallBackParams params2 = UnauthorizedAccessCallBackParams(mockListener2);

      when(mockRepository.addUnauthorizedAccessListener(any)).thenReturn(null);

      // Act
      useCase..execute(params1)
      ..execute(params2);

      // Assert
      verify(mockRepository.addUnauthorizedAccessListener(mockListener1)).called(1);
      verify(mockRepository.addUnauthorizedAccessListener(mockListener2)).called(1);
    });

    test("execute registers listener without throwing exceptions", () {
      // Arrange
      final UnauthorizedAccessListener mockListener = MockUnauthorizedAccessListener();
      final UnauthorizedAccessCallBackParams params = UnauthorizedAccessCallBackParams(mockListener);

      when(mockRepository.addUnauthorizedAccessListener(any)).thenReturn(null);

      // Act & Assert
      expect(() => useCase.execute(params), returnsNormally);
    });
  });
}
