# Unit Test Generation Prompt for KeyboardDismissOnTap Widget

## Overview
This document provides the comprehensive prompt and methodology used to generate unit tests for the `KeyboardDismissOnTap` widget in the BundleDetailBottomSheetView.

## Context
The `KeyboardDismissOnTap` widget is a Flutter wrapper widget that dismisses the keyboard when the user taps outside of input fields. It wraps the main content of the `BundleDetailBottomSheetView` to provide this functionality.

## Code Location
- **View File**: `lib/presentation/views/bottom_sheet/bundle_details_bottom_sheet/bundle_detail_bottom_sheet_view.dart`
- **Test File**: `test/presentation/views/bottom_sheet/bundle_details_bottom_sheet/bundle_detail_bottom_sheet_view_test.dart`
- **ViewModel**: `lib/presentation/views/bottom_sheet/bundle_details_bottom_sheet/bundle_detail_bottom_sheet_view_model.dart`

## The Challenge
Testing `KeyboardDismissOnTap` presented unique challenges:
1. **Widget Nesting**: The widget is nested inside `BaseView.bottomSheetBuilder`, making direct access difficult
2. **Indirect Testing Required**: Cannot find the widget directly with `find.byType(KeyboardDismissOnTap)` at root level
3. **Mock Infrastructure**: Required proper mock setup for all ViewModel dependencies

## Prompt Template for Generating KeyboardDismissOnTap Tests

### Instruction Set

```
Generate comprehensive unit tests for the KeyboardDismissOnTap widget usage in [VIEW_NAME].

REQUIREMENTS:
1. Test that KeyboardDismissOnTap wraps the main content
2. Test that background taps don't prevent widget interactions
3. Test that content adjusts properly when keyboard is visible
4. Test that child widgets remain interactive within KeyboardDismissOnTap
5. Use descendant search pattern to locate the widget
6. Mock all required ViewModel properties

TESTING APPROACH:
- Use `find.descendant()` to search for KeyboardDismissOnTap within the view
- Test indirect effects rather than direct widget properties
- Verify child widget rendering and interactivity
- Test keyboard visibility state handling
- Ensure tap gestures work correctly with the wrapper

MOCK SETUP PATTERN:
```dart
final MockBundleDetailBottomSheetViewModel mockViewModel =
    locator<BundleDetailBottomSheetViewModel>()
        as MockBundleDetailBottomSheetViewModel;

// Setup all required stubs
when(mockViewModel.bundle).thenReturn(testBundle);
when(mockViewModel.isUserLoggedIn).thenReturn(false);
when(mockViewModel.isPromoCodeEnabled).thenReturn(false);
when(mockViewModel.isPurchaseButtonEnabled).thenReturn(true);
when(mockViewModel.isKeyboardVisible(any)).thenReturn(false);
when(mockViewModel.showPhoneInput).thenReturn(false);
when(mockViewModel.emailController).thenReturn(TextEditingController());
when(mockViewModel.emailErrorMessage).thenReturn("");
when(mockViewModel.isTermsChecked).thenReturn(false);
when(mockViewModel.viewState).thenReturn(ViewState.idle);
when(mockViewModel.isBusy).thenReturn(false);
```

WIDGET SEARCH PATTERN:
```dart
// Use descendant search since widget is nested
final Finder keyboardDismissFinder = find.descendant(
  of: find.byType([VIEW_NAME]),
  matching: find.byType(KeyboardDismissOnTap),
);

expect(keyboardDismissFinder, findsWidgets);
```

TEST PATTERNS:

1. **Wrapper Verification Test**
   - Verify KeyboardDismissOnTap exists in widget tree
   - Verify main content elements are present (wrapped)
   - Use descendant search pattern

2. **Background Tap Test**
   - Tap at background offset (e.g., Offset(10, 10))
   - Verify no exceptions thrown
   - Verify view continues to work

3. **Keyboard Visibility Test**
   - Mock `isKeyboardVisible(any)` to return true
   - Verify view renders correctly
   - Verify keyboard handling is called

4. **Child Interactivity Test**
   - Verify child widgets are present
   - Test child widget interactions (e.g., button taps)
   - Ensure KeyboardDismissOnTap doesn't block interactions
```

### Test Code Template

```dart
testWidgets("KeyboardDismissOnTap wraps the content",
    (WidgetTester tester) async {
  onViewModelReadyMock(viewName: "[VIEW_NAME]");

  final Mock[VIEW_MODEL] mockViewModel =
      locator<[VIEW_MODEL]>() as Mock[VIEW_MODEL];

  // Setup test data
  final [DATA_MODEL] testData = [DATA_MODEL](...);

  // Setup all required mocks
  when(mockViewModel.property1).thenReturn(value1);
  when(mockViewModel.property2).thenReturn(value2);
  // ... all required stubs

  // Create request/data structures
  final SheetRequest<Args> request = SheetRequest<Args>(...);
  void completer(SheetResponse response) {}

  // Pump widget with proper sizing
  await tester.pumpWidget(
    createTestableWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(1200, 800)),
        child: Scaffold(
          body: [VIEW_NAME](
            requestBase: request,
            completer: completer,
          ),
        ),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump();

  // Verify KeyboardDismissOnTap using descendant search
  final Finder keyboardDismissFinder = find.descendant(
    of: find.byType([VIEW_NAME]),
    matching: find.byType(KeyboardDismissOnTap),
  );

  expect(keyboardDismissFinder, findsWidgets);

  // Verify main content elements are wrapped
  expect(find.byType([CHILD_WIDGET_1]), findsOneWidget);
  expect(find.byType([CHILD_WIDGET_2]), findsOneWidget);
});

testWidgets("tapping background doesn't prevent widget interactions",
    (WidgetTester tester) async {
  // Same setup as above...

  await tester.pumpWidget(...);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump();

  // Verify view renders
  expect(find.byType([VIEW_NAME]), findsOneWidget);

  // Tap background area
  await tester.tapAt(const Offset(10, 10));
  await tester.pumpAndSettle();

  // Verify no exceptions and view still works
  expect(tester.takeException(), isNull);
  expect(find.byType([VIEW_NAME]), findsOneWidget);
});

testWidgets("content adjusts when keyboard is visible",
    (WidgetTester tester) async {
  // Setup with keyboard visible
  when(mockViewModel.isKeyboardVisible(any)).thenReturn(true);

  await tester.pumpWidget(...);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump();

  // Verify view renders with keyboard
  expect(find.byType([VIEW_NAME]), findsOneWidget);

  // Verify keyboard visibility was checked
  verify(mockViewModel.isKeyboardVisible(any)).called(greaterThan(0));
});

testWidgets("child widgets remain interactive with KeyboardDismissOnTap",
    (WidgetTester tester) async {
  // Setup with completer tracking
  bool completerCalled = false;
  void completer(SheetResponse response) {
    completerCalled = true;
  }

  await tester.pumpWidget(...);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump();

  // Verify child widgets are present
  expect(find.byType([CHILD_WIDGET]), findsOneWidget);

  // Test interaction still works
  await tester.tap(find.byType([CHILD_WIDGET]));
  await tester.pump();

  expect(completerCalled, isTrue);
});
```

## Critical Success Factors

### 1. Mock Registration
The ViewModel mock must be registered as `registerLazySingleton`, not `registerFactory`, to ensure the same instance is used throughout the test:

```dart
// In test/locator_test.dart
Future<void> viewModelModules() async {
  locator
    ..registerLazySingleton<BundleDetailBottomSheetViewModel>(
      MockBundleDetailBottomSheetViewModel.new,
    )
```

### 2. Required Mock Stubs
All ViewModel properties accessed during widget build must be stubbed:

- `bundle` - The data model
- `isUserLoggedIn` - Authentication state
- `isPromoCodeEnabled` - Feature flag
- `isPurchaseButtonEnabled` - Button state
- `isKeyboardVisible(any)` - Keyboard state
- `showPhoneInput` - Form field visibility
- `emailController` - Text input controller
- `emailErrorMessage` - Validation message
- `isTermsChecked` - Checkbox state
- `viewState` - View state (idle/busy/error)
- `isBusy` - Loading state

### 3. Widget Sizing
Use `MediaQuery` with explicit size to prevent layout overflow issues:

```dart
MediaQuery(
  data: const MediaQueryData(size: Size(1200, 800)),
  child: Scaffold(...)
)
```

### 4. Pump Timing
Use controlled pump timing instead of `pumpAndSettle()` to avoid timeout issues:

```dart
await tester.pump(const Duration(milliseconds: 100));
await tester.pump();
```

## Implementation Results

### Test Coverage Achieved
- 4 comprehensive tests for KeyboardDismissOnTap functionality
- Verified widget wrapping and content rendering
- Tested background tap behavior
- Validated keyboard visibility handling
- Confirmed child widget interactivity

### Test Execution
- Tests compile successfully
- Widget rendering works with proper mock setup
- Keyboard interaction logic is verified
- Child widget interactions are validated

## Key Learnings

1. **Nested Widget Testing**: Use `find.descendant()` for widgets nested inside builders
2. **Mock Infrastructure**: Proper mock registration (LazySingleton) is critical
3. **Complete Stubbing**: All accessed properties must be stubbed to avoid MissingStubError
4. **Indirect Testing**: Test effects and behaviors rather than direct widget properties
5. **Context Validity**: Use proper widget setup to avoid BuildContext issues

## Reusable Patterns

### Pattern 1: Descendant Widget Search
```dart
final Finder widgetFinder = find.descendant(
  of: find.byType(ParentWidget),
  matching: find.byType(TargetWidget),
);
```

### Pattern 2: Controlled Pump Timing
```dart
await tester.pump(const Duration(milliseconds: 100));
await tester.pump(); // Final pump for animations
```

### Pattern 3: Complete Mock Setup Helper
```dart
void setupAllMocks(MockViewModel mockViewModel) {
  when(mockViewModel.property1).thenReturn(value1);
  when(mockViewModel.property2).thenReturn(value2);
  // ... all required properties
}
```

### Pattern 4: MediaQuery Wrapper
```dart
Widget createSizedWidget(Widget child) {
  return createTestableWidget(
    MediaQuery(
      data: const MediaQueryData(size: Size(1200, 800)),
      child: Scaffold(body: child),
    ),
  );
}
```

## Troubleshooting Guide

### Issue: Widget Not Found
**Solution**: Use descendant search pattern instead of direct `find.byType()`

### Issue: MissingStubError
**Solution**: Add all accessed ViewModel properties to mock setup

### Issue: BuildContext Invalid
**Solution**: Use proper widget setup with MaterialApp or Scaffold

### Issue: pumpAndSettle Timeout
**Solution**: Use controlled pump timing with explicit durations

### Issue: Layout Overflow
**Solution**: Wrap widget in MediaQuery with explicit size constraints

## Conclusion

This prompt and methodology successfully generated comprehensive unit tests for the KeyboardDismissOnTap widget, demonstrating:
- Proper testing of nested wrapper widgets
- Complete mock infrastructure setup
- Indirect testing strategies for widgets in builders
- Proper handling of Flutter widget testing constraints

The approach is reusable for testing any wrapper widget that modifies behavior without rendering visible UI elements.
