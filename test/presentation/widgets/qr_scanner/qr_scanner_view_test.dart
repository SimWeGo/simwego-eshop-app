import "package:esim_open_source/presentation/widgets/qr_scanner/qr_scanner_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:qr_code_scanner/qr_code_scanner.dart";

import "../../../helpers/view_helper.dart";
import "../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();

  setUp(() async {
    await setupTest();
    onViewModelReadyMock(viewName: "QrScannerViewRoute");
  });

  tearDown(() async {
    await tearDownTest();
  });

  group("QrScannerView Widget Tests", () {
    test("routeName constant is correctly defined", () {
      expect(QrScannerView.routeName, equals("QrScannerViewRoute"));
    });

    test("widget can be instantiated", () {
      const QrScannerView widget = QrScannerView();
      expect(widget, isNotNull);
      expect(widget.key, isNull);
    });

    test("widget with key can be instantiated", () {
      const Key testKey = ValueKey<String>("test_key");
      const QrScannerView widget = QrScannerView(key: testKey);
      expect(widget, isNotNull);
      expect(widget.key, equals(testKey));
    });

    testWidgets("builds correctly and contains QRView", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(const QrScannerView()),
      );

      await tester.pump();

      expect(find.byType(QrScannerView), findsOneWidget);
      expect(find.byType(QRView), findsOneWidget);
    });

    testWidgets("contains back button", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(const QrScannerView()),
      );

      await tester.pump();

      final Finder backButtonFinder = find.byIcon(Icons.arrow_back_ios);
      expect(backButtonFinder, findsOneWidget);

      final IconButton backButton = tester.widget<IconButton>(
        find.ancestor(
          of: backButtonFinder,
          matching: find.byType(IconButton),
        ),
      );

      expect(backButton.onPressed, isNotNull);
    });

    testWidgets("contains flash toggle button", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(const QrScannerView()),
      );

      await tester.pump();

      // Should show flash_on icon when flash is disabled
      expect(find.byIcon(Icons.flash_on_outlined), findsOneWidget);
    });

    testWidgets("displays flash toggle button with correct icon", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(const QrScannerView()),
      );

      await tester.pump();

      final Finder flashIconFinder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Icon &&
            (widget.icon == Icons.flash_on_outlined ||
                widget.icon == Icons.flash_off),
      );

      expect(flashIconFinder, findsOneWidget);

      final Icon flashIcon = tester.widget<Icon>(flashIconFinder);
      expect(flashIcon.color, isNotNull);
    });

    testWidgets("has proper Stack layout structure", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(const QrScannerView()),
      );

      await tester.pump();

      expect(find.byType(Stack), findsAtLeastNWidgets(1));
    });

    testWidgets("contains top control bar with buttons", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(const QrScannerView()),
      );

      await tester.pump();

      final Finder rowFinder = find.byWidgetPredicate(
        (Widget widget) => widget is Row && widget.children.length >= 2,
      );

      expect(rowFinder, findsAtLeastNWidgets(1));
    });

    testWidgets("QRView has overlay shape configured", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(const QrScannerView()),
      );

      await tester.pump();

      final QRView qrView = tester.widget<QRView>(find.byType(QRView));
      expect(qrView.overlay, isNotNull);
      expect(qrView.overlay, isA<QrScannerOverlayShape>());
    });

    testWidgets("contains IconButton widgets for controls", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(const QrScannerView()),
      );

      await tester.pump();

      final Finder iconButtonFinder = find.byType(IconButton);

      // Should have at least 2 IconButtons (back and flash toggle)
      expect(iconButtonFinder, findsAtLeastNWidgets(2));
    });

    testWidgets("widget structure includes necessary UI elements", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(const QrScannerView()),
      );

      await tester.pump();

      // Check for key UI components
      expect(find.byType(Stack), findsWidgets);
      expect(find.byType(Row), findsWidgets);
      expect(find.byType(IconButton), findsAtLeastNWidgets(2));
      expect(find.byType(QRView), findsOneWidget);
    });
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });
}
