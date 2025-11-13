import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/confirmation_bottom_sheet_view/confirmation_bottom_sheet_view.dart";
import "package:esim_open_source/presentation/widgets/bottom_sheet_close_button.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();

  late SheetRequest<ConfirmationSheetRequest> testRequest;
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
    onViewModelReadyMock(viewName: "ConfirmationBottomSheetView");

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

    testRequest = SheetRequest<ConfirmationSheetRequest>(
      data: ConfirmationSheetRequest(
        titleText: "Confirm Action",
        contentText: "Are you sure you want to delete",
        selectedText: "this item",
      ),
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

  group("ConfirmationBottomSheetView Widget Tests", () {
    testWidgets("renders with valid data", (WidgetTester tester) async {
      // Arrange
      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ConfirmationBottomSheetView), findsOneWidget);
      expect(find.text("Confirm Action"), findsOneWidget);
      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
      expect(find.byType(MainButton), findsWidgets);
    });

    testWidgets("renders complete content text with selected text",
        (WidgetTester tester) async {
      // Arrange
      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert - Check the full concatenated text
      expect(
        find.text("Are you sure you want to delete this item ?"),
        findsOneWidget,
      );
    });

    testWidgets("widget contains close button", (WidgetTester tester) async {
      // Arrange
      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
    });

    testWidgets("widget contains confirmation and cancellation buttons",
        (WidgetTester tester) async {
      // Arrange
      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert - Should have 2 MainButton widgets
      expect(find.byType(MainButton), findsNWidgets(2));
    });


    testWidgets("renders with empty string data", (WidgetTester tester) async {
      // Arrange
      final SheetRequest<ConfirmationSheetRequest> emptyRequest =
          SheetRequest<ConfirmationSheetRequest>(
        data: ConfirmationSheetRequest(
          titleText: "",
          contentText: "",
          selectedText: "",
        ),
      );

      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: emptyRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ConfirmationBottomSheetView), findsOneWidget);
      expect(find.text("  ?"), findsOneWidget);
    });

    testWidgets("renders with null data", (WidgetTester tester) async {
      // Arrange
      final SheetRequest<ConfirmationSheetRequest> nullRequest =
          SheetRequest<ConfirmationSheetRequest>();

      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: nullRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ConfirmationBottomSheetView), findsOneWidget);
      expect(find.text("  ?"), findsOneWidget);
    });

    testWidgets("handles special characters in text",
        (WidgetTester tester) async {
      // Arrange
      final SheetRequest<ConfirmationSheetRequest> specialCharRequest =
          SheetRequest<ConfirmationSheetRequest>(
        data: ConfirmationSheetRequest(
          titleText: "Delete Account & Data!",
          contentText: r"Are you sure? This action can't be undone",
          selectedText: "@user_123",
        ),
      );

      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: specialCharRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text("Delete Account & Data!"), findsOneWidget);
      expect(
        find.text(r"Are you sure? This action can't be undone @user_123 ?"),
        findsOneWidget,
      );
    });

    testWidgets("widget layout structure is correct",
        (WidgetTester tester) async {
      // Arrange
      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: testRequest,
        completer: testCompleter,
      );

      // Act
      await tester.pumpWidget(wrapWidget(widget));
      await tester.pumpAndSettle();

      // Assert - Check widget hierarchy
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(DecoratedBox), findsWidgets);
      expect(find.byType(SizedBox), findsWidgets);
    });
  });

  group("ConfirmationBottomSheetView Debug Properties Tests", () {
    testWidgets("debug properties are set correctly",
        (WidgetTester tester) async {
      // Arrange
      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: testRequest,
        completer: testCompleter,
      );

      // Act
      final DiagnosticPropertiesBuilder builder =
          DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> properties = builder.properties;

      // Assert
      expect(properties, isNotEmpty);
      expect(
        properties.any((DiagnosticsNode p) => p.name == "completer"),
        isTrue,
      );
      expect(
        properties.any((DiagnosticsNode p) => p.name == "requestBase"),
        isTrue,
      );
    });
  });

  group("ConfirmationBottomSheetView Constructor Tests", () {
    test("widget holds correct request and completer references", () {
      // Arrange & Act
      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: testRequest,
        completer: testCompleter,
      );

      // Assert
      expect(widget.request, equals(testRequest));
      expect(widget.completer, equals(testCompleter));
    });

    test("widget can be instantiated with different request data", () {
      // Arrange
      final SheetRequest<ConfirmationSheetRequest> differentRequest =
          SheetRequest<ConfirmationSheetRequest>(
        data: ConfirmationSheetRequest(
          titleText: "Warning",
          contentText: "Do you want to proceed with",
          selectedText: "payment",
        ),
      );

      // Act
      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: differentRequest,
        completer: testCompleter,
      );

      // Assert
      expect(widget.request, equals(differentRequest));
      expect(widget.request.data?.titleText, equals("Warning"));
      expect(widget.request.data?.contentText, equals("Do you want to proceed with"));
      expect(widget.request.data?.selectedText, equals("payment"));
    });

    test("completer callback works with confirmed response", () {
      // Arrange
      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: testRequest,
        completer: testCompleter,
      );

      // Act - Call completer directly with confirmed response
      widget.completer(SheetResponse<EmptyBottomSheetResponse>(confirmed: true));

      // Assert
      expect(completerCalled, isTrue);
      expect(completerResponse?.confirmed, isTrue);
    });

    test("completer callback works with unconfirmed response", () {
      // Arrange
      bool localCompleterCalled = false;
      SheetResponse<EmptyBottomSheetResponse>? localCompleterResponse;

      void localCompleter(SheetResponse<EmptyBottomSheetResponse> response) {
        localCompleterCalled = true;
        localCompleterResponse = response;
      }

      final ConfirmationBottomSheetView widget = ConfirmationBottomSheetView(
        request: testRequest,
        completer: localCompleter,
      );

      // Act - Call completer directly without confirmed
      widget.completer(SheetResponse<EmptyBottomSheetResponse>());

      // Assert
      expect(localCompleterCalled, isTrue);
      // confirmed defaults to false when not explicitly set
      expect(localCompleterResponse?.confirmed, isFalse);
    });
  });
}
