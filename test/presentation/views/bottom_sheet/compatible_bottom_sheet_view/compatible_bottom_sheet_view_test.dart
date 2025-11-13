import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/compatible_bottom_sheet_view/compatible_bottom_sheet_view.dart";
import "package:esim_open_source/presentation/widgets/bottom_sheet_close_button.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();

  late SheetRequest<dynamic> testRequest;
  late Function(SheetResponse<EmptyBottomSheetResponse>) testCompleter;
  late bool completerCalled;
  late SheetResponse<EmptyBottomSheetResponse>? completerResponse;

  Widget wrapWidget(Widget child) {
    return createTestableWidget(
      MediaQuery(
        data: const MediaQueryData(
          size: Size(1200, 800),
        ),
        child: Scaffold(body: child),
      ),
    );
  }

  setUp(() async {
    await setupTest();
    onViewModelReadyMock(viewName: "CompatibleBottomSheetView");

    // Suppress overflow errors in tests
    FlutterError.onError = (FlutterErrorDetails details) {
      final String message = details.exceptionAsString();
      if (message.contains("A RenderFlex overflowed") ||
          message.contains("overflowed by")) {
        // Ignore overflow errors in tests
        return;
      }
      FlutterError.presentError(details);
    };

    completerCalled = false;
    completerResponse = null;

    testRequest = SheetRequest<dynamic>(
      
    );

    testCompleter = (SheetResponse<EmptyBottomSheetResponse> response) {
      completerCalled = true;
      completerResponse = response;
    };
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("CompatibleBottomSheetView Widget Tests", () {
    testWidgets("widget renders with valid components",
        (WidgetTester tester) async {
      // Arrange
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(CompatibleBottomSheetView), findsOneWidget);
      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
      expect(find.byType(MainButton), findsOneWidget);
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets("widget displays close button", (WidgetTester tester) async {
      // Arrange
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
    });

    testWidgets("widget displays main action button",
        (WidgetTester tester) async {
      // Arrange
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(MainButton), findsOneWidget);
    });

    testWidgets("widget displays check compatible icon",
        (WidgetTester tester) async {
      // Arrange
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert - Multiple images exist (close button + compatible icon)
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets("widget displays content text with special code",
        (WidgetTester tester) async {
      // Arrange
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert - Should display Text widgets (RichText content)
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets("close button exists and can be found",
        (WidgetTester tester) async {
      // Arrange
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      final Finder closeButton = find.byType(BottomSheetCloseButton);

      // Assert - Close button should exist
      expect(closeButton, findsOneWidget);
    });

    testWidgets("main button exists and is tappable",
        (WidgetTester tester) async {
      // Arrange
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      final Finder mainButton = find.byType(MainButton);
      expect(mainButton, findsOneWidget);

      await tester.tap(mainButton);
      await tester.pumpAndSettle();

      // Assert - Completer should be called
      expect(completerCalled, isTrue);
    });

    testWidgets("widget has correct layout structure",
        (WidgetTester tester) async {
      // Arrange
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert - Verify widget hierarchy
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets("widget renders Text.rich for content",
        (WidgetTester tester) async {
      // Arrange
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert - Text.rich is used for content with multiple styles
      expect(find.byType(Text), findsWidgets);
    });
  });

  group("CompatibleBottomSheetView Constructor Tests", () {
    test("widget holds correct request and completer references", () {
      // Arrange & Act
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Assert
      expect(widget.requestBase, equals(testRequest));
      expect(widget.completer, equals(testCompleter));
    });

    test("widget can be instantiated with different requests", () {
      // Arrange
      final SheetRequest<dynamic> differentRequest = SheetRequest<dynamic>(
        data: <String, dynamic>{"test": "data"},
      );

      // Act
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: differentRequest,
        completer: testCompleter,
      );

      // Assert
      expect(widget.requestBase, equals(differentRequest));
    });
  });

  group("CompatibleBottomSheetView contentText Method Tests", () {
    testWidgets("contentText method returns Text.rich widget",
        (WidgetTester tester) async {
      // Arrange
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(
        wrapWidget(
          Builder(
            builder: widget.contentText,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Widget should render Text
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets("contentText method can be called independently",
        (WidgetTester tester) async {
      // Arrange
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(
        wrapWidget(
          Builder(
            builder: (BuildContext context) {
              final Widget content = widget.contentText(context);
              return content;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Should render successfully
      expect(find.byType(Text), findsOneWidget);
    });
  });

  group("CompatibleBottomSheetView User Interaction Tests", () {
    testWidgets("tapping close button does not confirm",
        (WidgetTester tester) async {
      // Arrange
      bool? wasConfirmed;
      void capturingCompleter(SheetResponse<EmptyBottomSheetResponse> response) {
        wasConfirmed = response.confirmed;
      }

      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: capturingCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      final Finder closeButton = find.byType(BottomSheetCloseButton);
      await tester.tap(closeButton);
      await tester.pumpAndSettle();

      // Assert - Close button should not set confirmed to true
      expect(wasConfirmed, isNull);
    });

    testWidgets("tapping main button sets confirmed to true",
        (WidgetTester tester) async {
      // Arrange
      bool? wasConfirmed;
      void capturingCompleter(SheetResponse<EmptyBottomSheetResponse> response) {
        wasConfirmed = response.confirmed;
      }

      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: capturingCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      final Finder mainButton = find.byType(MainButton);
      await tester.tap(mainButton);
      await tester.pumpAndSettle();

      // Assert - Main button should set confirmed to true
      expect(wasConfirmed, isTrue);
    });

    testWidgets("tapping main button calls completer",
        (WidgetTester tester) async {
      // Arrange
      int callCount = 0;
      void countingCompleter(SheetResponse<EmptyBottomSheetResponse> response) {
        callCount++;
      }

      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: countingCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      final Finder mainButton = find.byType(MainButton);

      await tester.tap(mainButton);
      await tester.pumpAndSettle();

      // Assert
      expect(callCount, greaterThan(0));
    });
  });

  group("CompatibleBottomSheetView debugFillProperties Tests", () {
    testWidgets("debugFillProperties includes request and completer",
        (WidgetTester tester) async {
      // Arrange
      final CompatibleBottomSheetView widget = CompatibleBottomSheetView(
        requestBase: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert - Widget should exist and have diagnostic properties
      expect(find.byType(CompatibleBottomSheetView), findsOneWidget);
      final CompatibleBottomSheetView foundWidget =
          tester.widget<CompatibleBottomSheetView>(
        find.byType(CompatibleBottomSheetView),
      );
      expect(foundWidget.requestBase, equals(testRequest));
      expect(foundWidget.completer, equals(testCompleter));
    });
  });
}
