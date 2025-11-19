import "package:esim_open_source/presentation/widgets/top_indicator.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("TopIndicator Tests", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("renders as decoration", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Container(
            width: 200,
            height: 50,
            decoration: const TopIndicator(
              color: Colors.blue,
            ),
            child: const Text("Test"),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(Container), findsWidgets);
      expect(find.text("Test"), findsOneWidget);
    });

    testWidgets("renders with custom stroke width", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Container(
            width: 200,
            height: 50,
            decoration: const TopIndicator(
              color: Colors.red,
              strokeWidth: 6,
            ),
            child: const Text("Custom Stroke"),
          ),
        ),
      );

      await tester.pump();

      expect(find.text("Custom Stroke"), findsOneWidget);
    });

    testWidgets("renders with additional width", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Container(
            width: 200,
            height: 50,
            decoration: const TopIndicator(
              color: Colors.green,
              additionalWidth: 10,
            ),
            child: const Text("Additional Width"),
          ),
        ),
      );

      await tester.pump();

      expect(find.text("Additional Width"), findsOneWidget);
    });

    testWidgets("renders with all custom properties", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Container(
            width: 200,
            height: 50,
            decoration: const TopIndicator(
              color: Colors.purple,
              additionalWidth: 15,
              strokeWidth: 8,
            ),
            child: const Text("All Custom"),
          ),
        ),
      );

      await tester.pump();

      expect(find.text("All Custom"), findsOneWidget);
    });

    test("handles default property values", () {
      const TopIndicator indicator = TopIndicator(
        color: Colors.blue,
      );

      expect(indicator.color, Colors.blue);
      expect(indicator.additionalWidth, 0);
      expect(indicator.strokeWidth, 4);
    });

    test("handles custom property values", () {
      const TopIndicator indicator = TopIndicator(
        color: Colors.orange,
        additionalWidth: 20,
        strokeWidth: 10,
      );

      expect(indicator.color, Colors.orange);
      expect(indicator.additionalWidth, 20);
      expect(indicator.strokeWidth, 10);
    });

    test("handles zero values", () {
      const TopIndicator indicator = TopIndicator(
        color: Colors.black,
        strokeWidth: 0,
      );

      expect(indicator.additionalWidth, 0);
      expect(indicator.strokeWidth, 0);
    });

    test("createBoxPainter returns painter", () {
      const TopIndicator indicator = TopIndicator(
        color: Colors.red,
      );

      final BoxPainter painter = indicator.createBoxPainter();
      expect(painter, isNotNull);
    });

    test("createBoxPainter with callback", () {
      const TopIndicator indicator = TopIndicator(
        color: Colors.green,
      );

      bool callbackCalled = false;
      final BoxPainter painter = indicator.createBoxPainter(() {
        callbackCalled = true;
      });

      expect(painter, isNotNull);
      expect(callbackCalled, isFalse);
    });

    test("createBoxPainter with null callback", () {
      const TopIndicator indicator = TopIndicator(
        color: Colors.blue,
        additionalWidth: 5,
        strokeWidth: 3,
      );

      final BoxPainter painter = indicator.createBoxPainter();
      expect(painter, isNotNull);
    });

    test("debug properties coverage", () {
      const TopIndicator indicator = TopIndicator(
        color: Colors.yellow,
        additionalWidth: 12,
        strokeWidth: 6,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      indicator.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(props.any((DiagnosticsNode prop) => prop.name == "color"), isTrue);
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "additionalWidth"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "strokeWidth"),
        isTrue,
      );
    });

    test("debug properties with default values", () {
      const TopIndicator indicator = TopIndicator(
        color: Colors.cyan,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      indicator.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
