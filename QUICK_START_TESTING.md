# Quick Start Testing Guide

**Purpose**: Get started immediately with testing to achieve maximum coverage
**Target**: 95%+ coverage | ~2,900-3,000 tests
**Current**: 2,493 tests passing

---

## Immediate Next Steps

### Step 1: Start with Domain Layer Use Cases (Highest Priority)

#### Why Start Here?
- ✅ Highest ROI - tests core business logic
- ✅ Uses existing mock infrastructure
- ✅ Clear patterns already established
- ✅ 44 tests needed across 5 categories

#### Command to Generate Tests
```bash
# Create test directory if it doesn't exist
mkdir -p test/domain/use_case/auth
mkdir -p test/domain/use_case/bundles
mkdir -p test/domain/use_case/user
mkdir -p test/domain/use_case/promotion
mkdir -p test/domain/use_case/device
```

#### Quick Prompt for Claude Code
```
"Please generate a comprehensive unit test for the [USE_CASE_NAME] use case
following the established testing patterns documented in claude_unit_test.md
and TESTING_STRATEGY_SUMMARY.md. The test should:
1. Mock the repository using the test service locator
2. Test success scenarios with valid data
3. Test error scenarios with appropriate error handling
4. Verify repository method calls
5. Use TestDataFactory for test data
6. Use ResourceTestMixin for Resource pattern validation"
```

#### Example: Testing LoginUseCase
```bash
# 1. Identify the use case file
lib/domain/use_case/auth/login_use_case.dart

# 2. Create the test file
touch test/domain/use_case/auth/login_use_case_test.dart

# 3. Use Claude Code prompt:
"Please generate a comprehensive unit test for the LoginUseCase
following the established testing patterns."

# 4. Run the test
flutter test test/domain/use_case/auth/login_use_case_test.dart

# 5. Verify it passes
```

---

## Phase 1: Domain Layer Use Cases (Priority 1)

### Auth Use Cases (11 tests) - Start Here!

**Location**: `lib/domain/use_case/auth/`
**Test Location**: `test/domain/use_case/auth/`

**Files to Test**:
1. `login_use_case.dart` → `login_use_case_test.dart`
2. `logout_use_case.dart` → `logout_use_case_test.dart`
3. `verify_otp_use_case.dart` → `verify_otp_use_case_test.dart`
4. `refresh_token_use_case.dart` → `refresh_token_use_case_test.dart`
5. `register_use_case.dart` → `register_use_case_test.dart`
6. `resend_otp_use_case.dart` → `resend_otp_use_case_test.dart`
7. `verify_phone_use_case.dart` → `verify_phone_use_case_test.dart`
8. `delete_account_use_case.dart` → `delete_account_use_case_test.dart`
9. `social_login_use_case.dart` → `social_login_use_case_test.dart`
10. `check_auth_status_use_case.dart` → `check_auth_status_use_case_test.dart`
11. `forgot_password_use_case.dart` → `forgot_password_use_case_test.dart`

**Estimated Time**: 1-2 days (15-20 minutes per test with Claude Code assistance)

### Bundles Use Cases (6 tests)

**Location**: `lib/domain/use_case/bundles/`
**Test Location**: `test/domain/use_case/bundles/`

**Files to Test**:
1. `get_bundles_use_case.dart`
2. `get_consumption_use_case.dart`
3. `purchase_bundle_use_case.dart`
4. `get_bundle_details_use_case.dart`
5. `get_active_bundles_use_case.dart`
6. `renew_bundle_use_case.dart`

**Estimated Time**: 0.5-1 day

### User Use Cases (15 tests)

**Location**: `lib/domain/use_case/user/`
**Test Location**: `test/domain/use_case/user/`

**Batch Testing Approach**:
```bash
# List all user use cases
ls lib/domain/use_case/user/

# Create tests in batch (use Claude Code with context of multiple files)
"Please generate comprehensive unit tests for the following user use cases:
[list all 15 use case files]"
```

**Estimated Time**: 2-3 days

### Promotion Use Cases (4 tests)

**Location**: `lib/domain/use_case/promotion/`
**Estimated Time**: 0.5 day

### Device Use Cases (8 tests)

**Location**: `lib/domain/use_case/device/`
**Estimated Time**: 1 day

---

## Testing Template (Copy & Customize)

### Use Case Test Template

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/base_repository_helper.dart';
import '../../../helpers/test_data_factory.dart';
import '../../../locator_test.dart';

void main() {
  late [UseCaseName] useCase;
  late Mock[RepositoryName] mockRepository;

  setUp(() async {
    await setupTest();
    mockRepository = [repositoryGlobalVariable]; // From locator_test.dart
    useCase = [UseCaseName](mockRepository);
  });

  tearDown(() async {
    await tearDownTest();
  });

  group('[UseCaseName]', () {
    test('should return success when repository returns success', () async {
      // Arrange
      final params = TestDataFactory.create[Params]();
      final expectedData = TestDataFactory.create[Data]();
      when(mockRepository.method(any))
          .thenAnswer((_) async => Resource.success(expectedData));

      // Act
      final result = await useCase.call(params);

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, expectedData);
      verify(mockRepository.method(any)).called(1);
    });

    test('should return error when repository returns error', () async {
      // Arrange
      final params = TestDataFactory.create[Params]();
      const errorMessage = 'Error occurred';
      when(mockRepository.method(any))
          .thenAnswer((_) async => Resource.error(errorMessage));

      // Act
      final result = await useCase.call(params);

      // Assert
      expect(result.isError, true);
      expect(result.message, errorMessage);
    });

    test('should handle network errors', () async {
      // Arrange
      final params = TestDataFactory.create[Params]();
      when(mockRepository.method(any))
          .thenAnswer((_) async => Resource.error('Network error', code: 500));

      // Act
      final result = await useCase.call(params);

      // Assert
      expect(result.isError, true);
      expect(result.code, 500);
    });

    test('should handle invalid input', () async {
      // Arrange
      final invalidParams = TestDataFactory.create[InvalidParams]();
      when(mockRepository.method(any))
          .thenAnswer((_) async => Resource.error('Invalid input', code: 400));

      // Act
      final result = await useCase.call(invalidParams);

      // Assert
      expect(result.isError, true);
      expect(result.code, 400);
    });
  });
}
```

---

## Daily Workflow

### Morning (2-3 hours)
1. Choose 5-6 use cases from priority list
2. Create test files
3. Use Claude Code to generate tests
4. Review and customize tests
5. Run tests and fix any issues

### Afternoon (2-3 hours)
1. Choose next 5-6 use cases
2. Repeat generation process
3. Run all new tests together
4. Check coverage improvement
5. Commit completed tests

### Evening (Optional)
1. Review test patterns
2. Refactor common test setup into helpers
3. Update TestDataFactory if needed
4. Plan next day's testing targets

---

## Progress Tracking

### Day 1-2: Auth Use Cases
- [ ] login_use_case_test.dart
- [ ] logout_use_case_test.dart
- [ ] verify_otp_use_case_test.dart
- [ ] refresh_token_use_case_test.dart
- [ ] register_use_case_test.dart
- [ ] resend_otp_use_case_test.dart
- [ ] verify_phone_use_case_test.dart
- [ ] delete_account_use_case_test.dart
- [ ] social_login_use_case_test.dart
- [ ] check_auth_status_use_case_test.dart
- [ ] forgot_password_use_case_test.dart

**Target**: 11 tests | **Expected Coverage Increase**: +5-8%

### Day 3: Bundles Use Cases
- [ ] All 6 bundle use case tests

**Target**: 6 tests | **Expected Coverage Increase**: +3-5%

### Day 4-5: User Use Cases
- [ ] All 15 user use case tests

**Target**: 15 tests | **Expected Coverage Increase**: +8-12%

### Day 6: Promotion Use Cases
- [ ] All 4 promotion use case tests

**Target**: 4 tests | **Expected Coverage Increase**: +2-3%

### Day 7-8: Device Use Cases
- [ ] All 8 device use case tests

**Target**: 8 tests | **Expected Coverage Increase**: +4-6%

---

## Verification Commands

### After Each Test
```bash
# Run specific test
flutter test test/domain/use_case/[category]/[test_file].dart

# Should see output like:
# 00:01 +5: All tests passed!
```

### After Each Day
```bash
# Run all tests
flutter test

# Should maintain:
# All tests passed! (increasing count)
```

### Weekly Coverage Check
```bash
# Generate coverage report
flutter test --coverage

# View coverage (if you have lcov/genhtml installed)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Manual check: Look at coverage/lcov.info for domain layer coverage
grep -A 1 "domain/use_case" coverage/lcov.info | grep "LF:" | awk '{s+=$1} END {print s}'
```

---

## Tips for Success

### 1. Use Claude Code Effectively
```
# Good prompt:
"Generate a unit test for LoginUseCase following the existing patterns
in test/domain/use_case/app/"

# Better prompt:
"Generate a comprehensive unit test for LoginUseCase that:
- Mocks AuthRepository from the test service locator
- Tests successful login with valid credentials
- Tests error handling for invalid credentials
- Tests network error scenarios (500, 404, 401)
- Tests null/empty input handling
- Uses TestDataFactory for creating test data
- Uses ResourceTestMixin for Resource pattern validation
- Follows the exact pattern from existing tests in test/domain/use_case/app/"
```

### 2. Batch Similar Tests
Test similar use cases together to maintain context and patterns:
```
"Generate tests for these 3 related use cases:
1. login_use_case.dart
2. logout_use_case.dart
3. refresh_token_use_case.dart

All should follow the same pattern and share common test setup."
```

### 3. Review Before Running
- Check imports are correct
- Verify mock variable names match locator_test.dart
- Ensure TestDataFactory methods exist
- Validate test descriptions are clear

### 4. Fix Common Issues Quickly

**Issue**: Mock not found
```dart
// Solution: Check locator_test.dart for correct mock variable name
late MockAuthRepository mockAuthRepository;
mockAuthRepository = authRepository; // Global from locator_test.dart
```

**Issue**: TestDataFactory method doesn't exist
```dart
// Solution: Add to test/helpers/test_data_factory.dart
static User createUser() => User(
  id: '123',
  email: 'test@example.com',
  // ... other fields
);
```

**Issue**: Resource validation not working
```dart
// Solution: Use ResourceTestMixin
class MyTest with ResourceTestMixin {
  // Then use:
  expectSuccessResource(result, expectedData: data);
}
```

### 5. Maintain Test Quality
- Every test should have clear Arrange-Act-Assert sections
- Test names should describe what is being tested
- Include both positive and negative test cases
- Verify mock interactions with `verify()`
- Don't skip edge cases

---

## Expected Outcomes

### After Phase 1 (Domain Layer - Week 1-2)
- **Tests Added**: 44 use case tests
- **Total Tests**: ~2,537
- **Coverage**: Domain layer at 95%+, overall ~85%
- **Confidence**: Core business logic comprehensively tested

### After Phase 2 (Data Layer - Week 2-3)
- **Tests Added**: 38 tests (data sources, models, repositories)
- **Total Tests**: ~2,575
- **Coverage**: Data layer at 90%+, overall ~88%
- **Confidence**: Data persistence and API integration tested

### After Phase 3 (Presentation Layer - Week 3-5)
- **Tests Added**: 154 tests (reactive services, widgets, views)
- **Total Tests**: ~2,729
- **Coverage**: Presentation layer at 85%+, overall ~93%
- **Confidence**: UI components and user interactions tested

### Final Target
- **Total Tests**: ~2,900-3,000 (including additional edge cases)
- **Coverage**: 95%+
- **Status**: World-class test coverage

---

## Resources

### Key Files to Reference
1. **`TESTING_STRATEGY_SUMMARY.md`** - Comprehensive strategy (this file)
2. **`claude_unit_test.md`** - Detailed testing patterns
3. **`test/locator_test.dart`** - Mock service locator
4. **`test/helpers/test_data_factory.dart`** - Test data creation
5. **`test/domain/use_case/app/`** - Example use case tests

### Commands Reference
```bash
# Run single test
flutter test test/path/to/test.dart

# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run in watch mode
flutter test --watch

# Run specific group
flutter test --name "LoginUseCase"

# Generate mocks (if needed)
flutter pub run build_runner build
```

### Git Workflow
```bash
# After completing a batch of tests (e.g., all auth use cases)
git add test/domain/use_case/auth/
git commit -m "Add unit tests for auth use cases (11 tests)

- login_use_case_test
- logout_use_case_test
- verify_otp_use_case_test
... (list all)

Coverage: Domain layer auth use cases at 100%
Tests: +11 (now 2,504 total)
"
```

---

## Success Checklist

### Before Starting
- [ ] Read `TESTING_STRATEGY_SUMMARY.md`
- [ ] Read `claude_unit_test.md`
- [ ] Review existing test patterns in `test/domain/use_case/app/`
- [ ] Understand mock service locator in `test/locator_test.dart`
- [ ] Run `flutter test` to ensure all current tests pass (2,493 tests)

### Daily Checklist
- [ ] Identify target use cases for the day (5-8 tests)
- [ ] Create test files in appropriate directory
- [ ] Generate tests using Claude Code with clear prompts
- [ ] Review generated tests for correctness
- [ ] Run tests to verify they pass
- [ ] Check for test quality (clear assertions, edge cases, etc.)
- [ ] Commit completed tests with descriptive message
- [ ] Update progress tracking

### Weekly Checklist
- [ ] Run full test suite: `flutter test`
- [ ] Generate coverage report: `flutter test --coverage`
- [ ] Review coverage improvement
- [ ] Identify any flaky or failing tests
- [ ] Refactor common patterns into test helpers if needed
- [ ] Update TestDataFactory with new test data methods
- [ ] Plan next week's testing targets

### Phase Completion Checklist
- [ ] All planned tests implemented
- [ ] All tests passing
- [ ] Coverage target met for the phase
- [ ] No skipped tests
- [ ] Test quality review completed
- [ ] Documentation updated if needed
- [ ] Code committed and pushed

---

## Ready to Start?

### Your First Action (Right Now!)
```bash
# 1. Ensure you're in the project directory
cd /Users/alihammoud1/Documents/Workspace/Monty/flutter/b2c-esim-flutter-open-source

# 2. Create auth use case test directory
mkdir -p test/domain/use_case/auth

# 3. List auth use cases to test
ls lib/domain/use_case/auth/

# 4. Use Claude Code to generate your first test
# Prompt: "Generate a comprehensive unit test for lib/domain/use_case/auth/login_use_case.dart
# following the patterns in test/domain/use_case/app/ and claude_unit_test.md"

# 5. Run the test
flutter test test/domain/use_case/auth/login_use_case_test.dart

# 6. Celebrate your first new test! 🎉
```

---

**You're now ready to achieve maximum test coverage! Start with Domain Layer Use Cases and work systematically through each phase. Good luck! 🚀**
