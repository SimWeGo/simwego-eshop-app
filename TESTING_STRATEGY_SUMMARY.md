# Testing Strategy & Maximum Coverage Plan

**Generated**: 2025-11-11
**Current Status**: 2,493 passing tests | ~79.5% coverage
**Target**: 95%+ coverage | ~2,900-3,000 tests

---

## Executive Summary

The Flutter eSIM application has a **mature testing infrastructure** with comprehensive mock service locator, test helpers, and documented patterns. This document provides a strategic roadmap to achieve maximum test coverage across all Clean Architecture layers.

### Current Strengths
- ✅ **2,493 passing tests** - all tests green
- ✅ **Robust Infrastructure**: Mock service locator with 50+ dependencies
- ✅ **Test Helpers**: 20 helper files with mixins and utilities
- ✅ **Documentation**: `claude_unit_test.md` with comprehensive patterns
- ✅ **High ViewModel Coverage**: 95.8% (46/48 tested)
- ✅ **Strong Data Layer**: 71-81% coverage across repositories/services

---

## Coverage Analysis by Layer

### 1. Presentation Layer

| Component | Total | Tested | Coverage | Priority |
|-----------|-------|--------|----------|----------|
| ViewModels | 48 | 46 | 95.8% ✓ | Low |
| Views (Widget Tests) | 139 | 56 | 40.3% ⚠️ | Medium |
| Reusable Widgets | 66 | 2 | 3.0% ❌ | High |
| Reactive Services | 3 | 0 | 0% ❌ | Critical |
| Extensions | 7 | 0 | 0% ❌ | Medium |

**Key Gaps**:
- 64 untested reusable widgets (shared components)
- 3 critical reactive services (UserService, UserAuthenticationService, BundlesDataService)
- 83 views missing widget/UI tests
- 7 utility extensions untested

### 2. Domain Layer

| Component | Total | Tested | Coverage | Priority |
|-----------|-------|--------|----------|----------|
| Use Cases | 51 | 7 | 13.7% ❌ | **CRITICAL** |

**Breakdown of Untested Use Cases (44 total)**:
- **Auth**: 11 use cases (Login, Logout, VerifyOTP, RefreshToken, Register, etc.)
- **Bundles**: 6 use cases (GetBundles, GetConsumption, PurchaseBundle, etc.)
- **User**: 15 use cases (GetProfile, UpdateProfile, DeleteAccount, etc.)
- **Promotion**: 4 use cases (GetPromotions, ApplyPromotion, etc.)
- **Device**: 8 use cases (InstallProfile, RemoveProfile, GetDevices, etc.)

**Impact**: **HIGHEST** - Use cases contain core business logic

### 3. Data Layer

| Component | Total | Tested | Coverage | Priority |
|-----------|-------|--------|----------|----------|
| Repositories | 7 | 5 | 71.4% ✓ | Low |
| Services | 16 | 13 | 81.3% ✓ | Low |
| APIs | 15 | 11 | 73.3% ✓ | Low |
| Data Sources | 15 | 1 | 6.7% ❌ | High |
| Response Models | 35 | 13 | 37.1% ⚠️ | Medium |

**Key Gaps**:
- 14 untested data sources (local/secure storage, caching)
- 22 untested response models (JSON serialization/deserialization)
- 2 missing repository tests (NotificationsRepository, PromotionRepository)

### 4. Core & Utils Layers

| Component | Coverage | Notes |
|-----------|----------|-------|
| Core Files | 33.3% ⚠️ | 2/3 files need tests |
| Utils | Good ✓ | Comprehensive coverage of utilities |

---

## Strategic Testing Plan

### PHASE 1: Domain Layer Use Cases (Week 1-2)
**Priority**: CRITICAL | **Effort**: 2-3 days | **Tests Added**: ~44

#### Why Start Here?
- Highest ROI - tests core business logic
- Leverages existing mock infrastructure
- Follows established patterns in `test/domain/use_case/app/`

#### Use Cases to Test:

**Auth Use Cases (11 tests)**:
```
lib/domain/use_case/auth/
├── login_use_case.dart
├── logout_use_case.dart
├── verify_otp_use_case.dart
├── refresh_token_use_case.dart
├── register_use_case.dart
├── resend_otp_use_case.dart
├── verify_phone_use_case.dart
├── delete_account_use_case.dart
├── social_login_use_case.dart
├── check_auth_status_use_case.dart
└── forgot_password_use_case.dart
```

**Testing Pattern**:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/base_repository_helper.dart';
import '../../../helpers/test_data_factory.dart';
import '../../../locator_test.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() async {
    await setupTest();
    mockAuthRepository = authRepository;
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  tearDown(() async {
    await tearDownTest();
  });

  group('LoginUseCase', () {
    test('should return success when repository returns success', () async {
      // Arrange
      final params = TestDataFactory.createLoginParams();
      final expectedUser = TestDataFactory.createUser();
      when(mockAuthRepository.login(any, any))
          .thenAnswer((_) async => Resource.success(expectedUser));

      // Act
      final result = await loginUseCase.call(params);

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, expectedUser);
      verify(mockAuthRepository.login(params.email, params.password)).called(1);
    });

    test('should return error when repository returns error', () async {
      // Arrange
      final params = TestDataFactory.createLoginParams();
      when(mockAuthRepository.login(any, any))
          .thenAnswer((_) async => Resource.error('Invalid credentials'));

      // Act
      final result = await loginUseCase.call(params);

      // Assert
      expect(result.isError, true);
      expect(result.message, 'Invalid credentials');
    });
  });
}
```

**Bundles Use Cases (6 tests)**:
- GetBundlesUseCase
- GetConsumptionUseCase
- PurchaseBundleUseCase
- GetBundleDetailsUseCase
- GetActiveBundlesUseCase
- RenewBundleUseCase

**User Use Cases (15 tests)**:
- GetUserProfileUseCase
- UpdateUserProfileUseCase
- UploadProfilePictureUseCase
- GetUserTransactionsUseCase
- GetUserDevicesUseCase
- (10 more user-related use cases)

**Promotion Use Cases (4 tests)**:
- GetPromotionsUseCase
- ApplyPromotionUseCase
- ValidatePromotionUseCase
- GetActivePromotionsUseCase

**Device Use Cases (8 tests)**:
- InstallProfileUseCase
- RemoveProfileUseCase
- GetDevicesUseCase
- GetDeviceDetailsUseCase
- ActivateDeviceUseCase
- (3 more device-related use cases)

---

### PHASE 2: Data Layer Foundation (Week 2-3)
**Priority**: HIGH | **Effort**: 2-3 days | **Tests Added**: ~38

#### 2.1 Data Sources (14 tests)
**Location**: `lib/data/data_source/`

Key data sources to test:
- LocalStorageService (already tested ✓)
- SecureStorageService
- CacheService
- PreferencesService
- KeyValueStorageService
- AuthTokenStorage
- UserDataStorage
- BundlesDataStorage
- DeviceDataStorage
- ConfigurationStorage
- (4 more storage services)

**Testing Pattern**:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late SecureStorageService secureStorage;
  late MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    secureStorage = SecureStorageService(mockFlutterSecureStorage);
  });

  group('SecureStorageService', () {
    test('should store value securely', () async {
      // Arrange
      const key = 'auth_token';
      const value = 'secret_token_123';
      when(mockFlutterSecureStorage.write(key: key, value: value))
          .thenAnswer((_) async => null);

      // Act
      await secureStorage.write(key, value);

      // Assert
      verify(mockFlutterSecureStorage.write(key: key, value: value)).called(1);
    });

    test('should retrieve stored value', () async {
      // Arrange
      const key = 'auth_token';
      const value = 'secret_token_123';
      when(mockFlutterSecureStorage.read(key: key))
          .thenAnswer((_) async => value);

      // Act
      final result = await secureStorage.read(key);

      // Assert
      expect(result, value);
      verify(mockFlutterSecureStorage.read(key: key)).called(1);
    });

    test('should handle null values gracefully', () async {
      // Arrange
      const key = 'non_existent_key';
      when(mockFlutterSecureStorage.read(key: key))
          .thenAnswer((_) async => null);

      // Act
      final result = await secureStorage.read(key);

      // Assert
      expect(result, isNull);
    });

    test('should delete stored value', () async {
      // Arrange
      const key = 'auth_token';
      when(mockFlutterSecureStorage.delete(key: key))
          .thenAnswer((_) async => null);

      // Act
      await secureStorage.delete(key);

      // Assert
      verify(mockFlutterSecureStorage.delete(key: key)).called(1);
    });
  });
}
```

#### 2.2 Response Models (22 tests)
**Location**: `lib/data/response/`

Focus on JSON serialization/deserialization:
- User response models
- Bundle response models
- Device response models
- Transaction response models
- Promotion response models
- Notification response models
- Error response models

**Testing Pattern**:
```dart
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserResponse', () {
    test('should parse from JSON correctly', () {
      // Arrange
      final jsonString = '''
        {
          "id": "123",
          "email": "test@example.com",
          "firstName": "John",
          "lastName": "Doe",
          "phoneNumber": "+1234567890"
        }
      ''';
      final json = jsonDecode(jsonString);

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.id, '123');
      expect(userResponse.email, 'test@example.com');
      expect(userResponse.firstName, 'John');
      expect(userResponse.lastName, 'Doe');
      expect(userResponse.phoneNumber, '+1234567890');
    });

    test('should convert to JSON correctly', () {
      // Arrange
      final userResponse = UserResponse(
        id: '123',
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '+1234567890',
      );

      // Act
      final json = userResponse.toJson();

      // Assert
      expect(json['id'], '123');
      expect(json['email'], 'test@example.com');
      expect(json['firstName'], 'John');
      expect(json['lastName'], 'Doe');
      expect(json['phoneNumber'], '+1234567890');
    });

    test('should handle null values gracefully', () {
      // Arrange
      final jsonString = '''
        {
          "id": "123",
          "email": "test@example.com"
        }
      ''';
      final json = jsonDecode(jsonString);

      // Act
      final userResponse = UserResponse.fromJson(json);

      // Assert
      expect(userResponse.id, '123');
      expect(userResponse.email, 'test@example.com');
      expect(userResponse.firstName, isNull);
      expect(userResponse.lastName, isNull);
    });

    test('should handle malformed JSON', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act & Assert
      expect(() => UserResponse.fromJson(json), throwsA(isA<TypeError>()));
    });
  });
}
```

#### 2.3 Missing Repositories (2 tests)
- Test `ApiNotificationsRepository`
- Test `ApiPromotionRepository`

Follow patterns from existing repository tests in `test/data/repository/`.

---

### PHASE 3: Presentation Layer UI (Week 3-5)
**Priority**: MEDIUM-HIGH | **Effort**: 5-7 days | **Tests Added**: ~154

#### 3.1 Reactive Services (3 tests - CRITICAL)
**Location**: `lib/presentation/reactive_service/`

These manage critical application state:
- **UserService**: User authentication and profile state
- **UserAuthenticationService**: Auth token and session management
- **BundlesDataService**: Active bundles and data consumption state

**Testing Pattern**:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../locator_test.dart';
import '../../../helpers/test_data_factory.dart';

void main() {
  late UserService userService;
  late MockUserRepository mockUserRepository;

  setUp(() async {
    await setupTest();
    mockUserRepository = userRepository;
    userService = UserService(mockUserRepository);
  });

  tearDown(() async {
    await tearDownTest();
  });

  group('UserService', () {
    test('should initialize with null user', () {
      expect(userService.user, isNull);
      expect(userService.isAuthenticated, false);
    });

    test('should update user state on successful fetch', () async {
      // Arrange
      final expectedUser = TestDataFactory.createUser();
      when(mockUserRepository.getProfile())
          .thenAnswer((_) async => Resource.success(expectedUser));

      // Act
      await userService.fetchUser();

      // Assert
      expect(userService.user, expectedUser);
      expect(userService.isAuthenticated, true);
      verify(mockUserRepository.getProfile()).called(1);
    });

    test('should notify listeners on user update', () async {
      // Arrange
      final expectedUser = TestDataFactory.createUser();
      when(mockUserRepository.getProfile())
          .thenAnswer((_) async => Resource.success(expectedUser));
      var listenerCalled = false;
      userService.addListener(() => listenerCalled = true);

      // Act
      await userService.fetchUser();

      // Assert
      expect(listenerCalled, true);
    });

    test('should clear user state on logout', () {
      // Arrange
      final user = TestDataFactory.createUser();
      userService.setUser(user);
      expect(userService.user, isNotNull);

      // Act
      userService.clearUser();

      // Assert
      expect(userService.user, isNull);
      expect(userService.isAuthenticated, false);
    });
  });
}
```

#### 3.2 Reusable Widgets (64 tests)
**Location**: `lib/presentation/widgets/`

Focus on shared components used across views:
- Button components (PrimaryButton, SecondaryButton, IconButton, etc.)
- Input components (TextInput, PhoneInput, EmailInput, etc.)
- Card components (BundleCard, DeviceCard, TransactionCard, etc.)
- Loading components (LoadingSpinner, LoadingOverlay, Skeleton, etc.)
- Dialog components (ConfirmDialog, AlertDialog, BottomSheet, etc.)
- Navigation components (AppBar, BottomNav, TabBar, etc.)

**Testing Pattern**:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../helpers/view_helper.dart';

void main() {
  testWidgets('PrimaryButton renders correctly', (WidgetTester tester) async {
    // Arrange
    const buttonText = 'Click Me';
    var buttonPressed = false;

    // Act
    await tester.pumpWidget(
      createTestableWidget(
        PrimaryButton(
          text: buttonText,
          onPressed: () => buttonPressed = true,
        ),
      ),
    );

    // Assert
    expect(find.text(buttonText), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('PrimaryButton handles tap correctly', (WidgetTester tester) async {
    // Arrange
    var buttonPressed = false;

    await tester.pumpWidget(
      createTestableWidget(
        PrimaryButton(
          text: 'Click Me',
          onPressed: () => buttonPressed = true,
        ),
      ),
    );

    // Act
    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();

    // Assert
    expect(buttonPressed, true);
  });

  testWidgets('PrimaryButton shows loading state', (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(
      createTestableWidget(
        PrimaryButton(
          text: 'Click Me',
          onPressed: () {},
          isLoading: true,
        ),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Click Me'), findsNothing);
  });

  testWidgets('PrimaryButton disabled state prevents interaction', (WidgetTester tester) async {
    // Arrange
    var buttonPressed = false;

    await tester.pumpWidget(
      createTestableWidget(
        PrimaryButton(
          text: 'Click Me',
          onPressed: null,
        ),
      ),
    );

    // Act
    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();

    // Assert
    expect(buttonPressed, false);
  });

  testWidgets('PrimaryButton debugFillProperties works', (WidgetTester tester) async {
    // Arrange
    final button = PrimaryButton(
      text: 'Test',
      onPressed: () {},
      isLoading: true,
    );

    // Act
    final builder = DiagnosticPropertiesBuilder();
    button.debugFillProperties(builder);

    // Assert
    final description = builder.properties
        .map((p) => p.toString())
        .join(', ');
    expect(description, contains('text: Test'));
    expect(description, contains('isLoading: true'));
  });
}
```

#### 3.3 Extensions (7 tests)
**Location**: `lib/core/extensions/` or `lib/presentation/extensions/`

Test utility extensions:
- String extensions
- DateTime extensions
- BuildContext extensions
- Color extensions
- Number extensions
- List extensions
- (1 more extension)

**Testing Pattern**:
```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExtensions', () {
    test('isValidEmail should return true for valid emails', () {
      expect('test@example.com'.isValidEmail, true);
      expect('user.name@domain.co.uk'.isValidEmail, true);
      expect('user+tag@example.com'.isValidEmail, true);
    });

    test('isValidEmail should return false for invalid emails', () {
      expect('invalid'.isValidEmail, false);
      expect('invalid@'.isValidEmail, false);
      expect('@example.com'.isValidEmail, false);
      expect('user@'.isValidEmail, false);
    });

    test('capitalize should capitalize first letter', () {
      expect('hello'.capitalize(), 'Hello');
      expect('WORLD'.capitalize(), 'WORLD');
      expect(''.capitalize(), '');
    });

    test('truncate should limit string length', () {
      expect('Hello World'.truncate(5), 'Hello...');
      expect('Hi'.truncate(5), 'Hi');
      expect(''.truncate(5), '');
    });
  });
}
```

#### 3.4 View Widget Tests (83 tests)
**Location**: `test/presentation/views/`

Add widget tests for views that currently only have ViewModel tests:
- Auth views (Login, Register, OTP verification, etc.)
- Bundle views (Browse, Details, Purchase, etc.)
- Profile views (View, Edit, Settings, etc.)
- Device views (List, Install, Manage, etc.)
- Transaction views (History, Details, etc.)

**Testing Pattern**:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../helpers/view_helper.dart';
import '../../../locator_test.dart';

void main() {
  setUp(() async {
    await setupTest();
  });

  tearDown(() async {
    await tearDownTest();
  });

  testWidgets('LoginView renders all UI elements', (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(createTestableWidget(const LoginView()));
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(TextField), findsNWidgets(2)); // Email and password
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('LoginView validates email input', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(createTestableWidget(const LoginView()));
    await tester.pumpAndSettle();

    // Act - Enter invalid email
    await tester.enterText(find.byType(TextField).first, 'invalid-email');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Please enter a valid email'), findsOneWidget);
  });

  testWidgets('LoginView handles successful login', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(createTestableWidget(const LoginView()));
    await tester.pumpAndSettle();

    // Act
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).last, 'password123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Assert - Verify navigation occurred (check for next view or verify mock calls)
    // This depends on your navigation setup
  });

  testWidgets('LoginView toggles password visibility', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(createTestableWidget(const LoginView()));
    await tester.pumpAndSettle();

    // Act - Find and tap visibility toggle
    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pumpAndSettle();

    // Assert
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });
}
```

---

## Testing Infrastructure Reference

### Mock Service Locator
**Location**: `test/locator_test.dart`

All dependencies are pre-mocked and available:
```dart
await setupTest(); // Initialize all mocks
// Access mocks via global variables:
// - authRepository, userRepository, bundlesRepository, etc.
// - analyticsService, pushNotificationService, etc.
// - navigationService, dialogService, bottomSheetService, etc.
await tearDownTest(); // Clean up
```

### Test Helpers
**Location**: `test/helpers/`

Key helpers available:
- **`test_data_factory.dart`**: Create consistent test data
- **`resource_test_mixin.dart`**: Validate Resource<T> responses
- **`view_helper.dart`**: Create testable widgets with proper setup
- **`view_model_helper.dart`**: Common ViewModel test utilities
- **`base_repository_helper.dart`**: Repository testing base classes

### Resource Pattern Testing
Use `ResourceTestMixin` for comprehensive validation:
```dart
// Success validation
expectSuccessResource(result, expectedData: expectedUser);

// Error validation
expectErrorResource(result, expectedMessage: 'Error occurred');

// HTTP error validation
expectErrorResourceWithCode(result, expectedCode: 404);
```

---

## Execution Strategy

### Week 1-2: Domain Layer Blitz
**Goal**: Test all 44 use cases

**Daily Targets**:
- Day 1-2: Auth use cases (11 tests)
- Day 3: Bundles use cases (6 tests)
- Day 4-5: User use cases (15 tests)
- Day 6: Promotion use cases (4 tests)
- Day 7-8: Device use cases (8 tests)

**Success Criteria**: Domain layer at 95%+ coverage

### Week 2-3: Data Layer Foundation
**Goal**: Test data sources, models, and missing repositories

**Daily Targets**:
- Day 1-3: Data sources (14 tests)
- Day 4-5: Response models (22 tests)
- Day 6: Missing repositories (2 tests)

**Success Criteria**: Data layer at 90%+ coverage

### Week 3-5: Presentation Layer UI
**Goal**: Test reactive services, widgets, extensions, and views

**Daily Targets**:
- Day 1: Reactive services (3 tests) - CRITICAL
- Day 2-8: Reusable widgets (64 tests, ~8-10 per day)
- Day 9: Extensions (7 tests)
- Day 10-20: View widget tests (83 tests, ~8-10 per day)

**Success Criteria**: Presentation layer at 85%+ coverage

---

## Success Metrics

### Coverage Targets by Layer
- **Domain Layer**: 95%+ (currently 13.7%)
- **Data Layer**: 90%+ (currently 60-80% depending on component)
- **Presentation Layer**: 85%+ (currently 3-96% depending on component)
- **Overall**: 95%+ (currently ~79.5%)

### Test Count Targets
- **Current**: 2,493 tests
- **Phase 1**: +44 tests = 2,537 tests
- **Phase 2**: +38 tests = 2,575 tests
- **Phase 3**: +154 tests = 2,729 tests
- **Final Target**: ~2,900-3,000 tests (including edge cases and integration tests)

### Quality Metrics
- ✅ All tests must pass
- ✅ No skipped tests
- ✅ No flaky tests
- ✅ Meaningful assertions (not just smoke tests)
- ✅ Edge cases covered
- ✅ Error scenarios tested

---

## Quick Start Guide

### Step 1: Generate Coverage Report
```bash
# Run tests with coverage
flutter test --coverage

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open in browser
open coverage/html/index.html
```

### Step 2: Identify Gaps
```bash
# Review coverage report to see uncovered files
# Focus on files with 0% or low coverage
```

### Step 3: Start Testing (Priority Order)
1. **Start with Domain Layer Use Cases** (Highest ROI)
   - Navigate to `lib/domain/use_case/auth/`
   - Create corresponding test in `test/domain/use_case/auth/`
   - Follow pattern from existing tests in `test/domain/use_case/app/`

2. **Move to Data Sources**
   - Navigate to `lib/data/data_source/`
   - Create tests in `test/data/data_source/`
   - Focus on storage and caching logic

3. **Test Reactive Services** (Critical for state management)
   - Navigate to `lib/presentation/reactive_service/`
   - Create tests in `test/presentation/reactive_service/`

4. **Test Widgets and UI Components**
   - Navigate to `lib/presentation/widgets/`
   - Create tests in `test/presentation/widgets/`
   - Use `createTestableWidget()` helper

### Step 4: Run Tests Frequently
```bash
# Run specific test file
flutter test test/domain/use_case/auth/login_use_case_test.dart

# Run all tests
flutter test

# Watch mode (re-run on changes)
flutter test --watch
```

### Step 5: Verify Coverage Improvement
```bash
# After adding tests, regenerate coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Compare with previous coverage percentage
```

---

## Common Testing Patterns

### Pattern 1: Use Case Testing
```dart
// 1. Mock repository
when(mockRepository.method(params))
    .thenAnswer((_) async => Resource.success(data));

// 2. Call use case
final result = await useCase.call(params);

// 3. Verify result
expectSuccessResource(result, expectedData: data);
verify(mockRepository.method(params)).called(1);
```

### Pattern 2: Widget Testing
```dart
// 1. Create testable widget
await tester.pumpWidget(createTestableWidget(MyWidget()));

// 2. Interact with widget
await tester.enterText(find.byType(TextField), 'test');
await tester.tap(find.byType(Button));
await tester.pumpAndSettle();

// 3. Assert UI state
expect(find.text('Expected Text'), findsOneWidget);
```

### Pattern 3: Repository Testing
```dart
// 1. Mock API response
when(mockApi.endpoint()).thenAnswer((_) async => mockResponse);

// 2. Call repository
final result = await repository.getData();

// 3. Validate Resource pattern
expectSuccessResource(result, expectedData: expectedData);
verify(mockApi.endpoint()).called(1);
```

### Pattern 4: Service Testing
```dart
// 1. Mock dependencies
when(mockDependency.method()).thenAnswer((_) async => value);

// 2. Call service
await service.performAction();

// 3. Verify interactions
verify(mockDependency.method()).called(1);
expect(service.state, expectedState);
```

---

## Troubleshooting

### Issue: Mock not working
**Solution**: Ensure mock is registered in `test/locator_test.dart`

### Issue: Widget test fails with missing localization
**Solution**: Use `createTestableWidget()` from `view_helper.dart`

### Issue: Async test timing out
**Solution**: Use `await tester.pumpAndSettle()` after async operations

### Issue: Coverage not showing file
**Solution**: Ensure file is imported and executed in tests

### Issue: Test flakiness
**Solution**:
- Use `await tester.pumpAndSettle()` instead of `pump()`
- Mock all external dependencies
- Avoid real timers, use fake timers

---

## Best Practices

### DO:
✅ Follow existing test patterns in the codebase
✅ Use test helpers and mixins (`ResourceTestMixin`, `view_helper.dart`)
✅ Test both success and error scenarios
✅ Use `TestDataFactory` for consistent test data
✅ Write descriptive test names that explain what is being tested
✅ Test edge cases (null, empty, invalid input)
✅ Verify mock interactions with `verify()`
✅ Use `expectSuccessResource()` and `expectErrorResource()` for Resource pattern
✅ Clean up with proper `tearDown()` methods
✅ Run tests frequently during development

### DON'T:
❌ Skip proper setup/teardown
❌ Use real network calls in unit tests
❌ Test implementation details
❌ Write tests without assertions
❌ Ignore test failures
❌ Copy-paste tests without understanding patterns
❌ Mock entire classes when only specific methods are needed
❌ Forget to test error scenarios
❌ Leave commented-out test code
❌ Skip testing edge cases

---

## Resources

### Documentation
- **`CLAUDE.md`**: Project overview and development commands
- **`claude_unit_test.md`**: Comprehensive testing patterns (200+ lines)
- **Test Infrastructure**: `test/locator_test.dart`, `test/helpers/`

### Key Commands
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Generate HTML coverage report
genhtml coverage/lcov.info -o coverage/html

# Run specific test
flutter test test/path/to/test_file.dart

# Watch mode
flutter test --watch

# Update golden files (for widget tests)
flutter test --update-goldens
```

### Test File Locations
```
test/
├── domain/
│   └── use_case/          # Use case tests
├── data/
│   ├── repository/        # Repository tests
│   ├── api/               # API tests
│   ├── data_source/       # Data source tests
│   └── response/          # Response model tests
├── presentation/
│   ├── view_models/       # ViewModel tests
│   ├── views/             # Widget tests for views
│   ├── widgets/           # Widget tests for components
│   ├── reactive_service/  # Reactive service tests
│   └── extensions/        # Extension tests
├── helpers/               # Test utilities
└── locator_test.dart      # Mock service locator
```

---

## Conclusion

This testing strategy provides a clear roadmap to achieve **95%+ test coverage** with approximately **2,900-3,000 comprehensive tests**. The project already has excellent testing infrastructure - the focus now is systematic execution across all architectural layers.

**Key Takeaways**:
1. Start with **Domain Layer Use Cases** (highest ROI, 44 tests)
2. Build **Data Layer Foundation** (data sources and models, 38 tests)
3. Complete **Presentation Layer UI** (widgets and views, 154 tests)
4. Follow existing patterns documented in `claude_unit_test.md`
5. Use test helpers and mock infrastructure already in place
6. Run tests frequently and monitor coverage progress

**Timeline**: 15-20 development days for maximum coverage
**Outcome**: World-class test suite for Clean Architecture Flutter application

---

**Generated by**: Claude Code Testing Analysis
**Date**: 2025-11-11
**Status**: Ready for execution
