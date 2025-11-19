import "package:esim_open_source/presentation/widgets/animated_half_circular_progress_indicator.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("AnimatedHalfCircularProgressIndicator Widget Tests", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("renders with basic properties", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AnimatedHalfCircularProgressIndicator(
            targetValue: 0.5,
            valueColor: Colors.blue,
            isLoading: false,
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(AnimatedHalfCircularProgressIndicator), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AnimatedHalfCircularProgressIndicator),
          matching: find.byType(AnimatedBuilder),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(AnimatedHalfCircularProgressIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets("renders with custom background color", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AnimatedHalfCircularProgressIndicator(
            targetValue: 0.75,
            valueColor: Colors.green,
            backgroundColor: Colors.grey,
            isLoading: false,
          ),
        ),
      );

      await tester.pump();

      expect(
        find.descendant(
          of: find.byType(AnimatedHalfCircularProgressIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets("renders with custom stroke width", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AnimatedHalfCircularProgressIndicator(
            targetValue: 0.8,
            valueColor: Colors.red,
            strokeWidth: 50,
            isLoading: false,
          ),
        ),
      );

      await tester.pump();

      final CustomPaint customPaint = tester.widget<CustomPaint>(
        find.descendant(
          of: find.byType(AnimatedHalfCircularProgressIndicator),
          matching: find.byType(CustomPaint),
        ),
      );

      expect(customPaint.size, const Size(300, 150)); // strokeWidth * 6, strokeWidth * 3
    });

    testWidgets("renders with custom stroke cap", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AnimatedHalfCircularProgressIndicator(
            targetValue: 0.6,
            valueColor: Colors.orange,
            strokeCap: StrokeCap.square,
            isLoading: false,
          ),
        ),
      );

      await tester.pump();

      expect(
        find.descendant(
          of: find.byType(AnimatedHalfCircularProgressIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets("renders with custom duration", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AnimatedHalfCircularProgressIndicator(
            targetValue: 0.9,
            valueColor: Colors.purple,
            duration: Duration(milliseconds: 500),
            isLoading: false,
          ),
        ),
      );

      await tester.pump();

      expect(
        find.descendant(
          of: find.byType(AnimatedHalfCircularProgressIndicator),
          matching: find.byType(AnimatedBuilder),
        ),
        findsOneWidget,
      );
    });

    testWidgets("animates progress value", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AnimatedHalfCircularProgressIndicator(
            targetValue: 1,
            valueColor: Colors.blue,
            isLoading: false,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(
        find.descendant(
          of: find.byType(AnimatedHalfCircularProgressIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets("updates when target value changes", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AnimatedHalfCircularProgressIndicator(
            targetValue: 0.3,
            valueColor: Colors.blue,
            isLoading: false,
          ),
        ),
      );

      await tester.pump();

      // Update target value
      await tester.pumpWidget(
        createTestableWidget(
          const AnimatedHalfCircularProgressIndicator(
            targetValue: 0.7,
            valueColor: Colors.blue,
            isLoading: false,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(
        find.descendant(
          of: find.byType(AnimatedHalfCircularProgressIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets("handles zero target value", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AnimatedHalfCircularProgressIndicator(
            targetValue: 0,
            valueColor: Colors.blue,
            isLoading: false,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byType(AnimatedHalfCircularProgressIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets("handles full progress (1.0)", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AnimatedHalfCircularProgressIndicator(
            targetValue: 1,
            valueColor: Colors.green,
            isLoading: false,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byType(AnimatedHalfCircularProgressIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets("handles loading state", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AnimatedHalfCircularProgressIndicator(
            targetValue: 0.5,
            valueColor: Colors.blue,
            isLoading: true,
          ),
        ),
      );

      await tester.pump();

      expect(
        find.descendant(
          of: find.byType(AnimatedHalfCircularProgressIndicator),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets("custom paint has correct painter", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AnimatedHalfCircularProgressIndicator(
            targetValue: 0.5,
            valueColor: Colors.blue,
            isLoading: false,
          ),
        ),
      );

      await tester.pump();

      final CustomPaint customPaint = tester.widget<CustomPaint>(
        find.descendant(
          of: find.byType(AnimatedHalfCircularProgressIndicator),
          matching: find.byType(CustomPaint),
        ),
      );

      expect(customPaint.painter, isA<HalfCircleProgressPainter>());
    });

    test("handles property values", () {
      const AnimatedHalfCircularProgressIndicator widget =
          AnimatedHalfCircularProgressIndicator(
        targetValue: 0.5,
        valueColor: Colors.blue,
        isLoading: false,
      );

      expect(widget.targetValue, equals(0.5));
      expect(widget.valueColor, equals(Colors.blue));
      expect(widget.isLoading, equals(false));
      expect(widget.duration, equals(const Duration(milliseconds: 1000)));
      expect(widget.strokeWidth, equals(35));
      expect(widget.strokeCap, equals(StrokeCap.round));
    });

    test("handles custom property values", () {
      const AnimatedHalfCircularProgressIndicator widget =
          AnimatedHalfCircularProgressIndicator(
        targetValue: 0.75,
        valueColor: Colors.red,
        backgroundColor: Colors.grey,
        duration: Duration(milliseconds: 500),
        strokeWidth: 50,
        strokeCap: StrokeCap.square,
        isLoading: true,
      );

      expect(widget.targetValue, equals(0.75));
      expect(widget.valueColor, equals(Colors.red));
      expect(widget.backgroundColor, equals(Colors.grey));
      expect(widget.duration, equals(const Duration(milliseconds: 500)));
      expect(widget.strokeWidth, equals(50));
      expect(widget.strokeCap, equals(StrokeCap.square));
      expect(widget.isLoading, equals(true));
    });

    test("debug properties coverage", () {
      const AnimatedHalfCircularProgressIndicator widget =
          AnimatedHalfCircularProgressIndicator(
        targetValue: 0.85,
        valueColor: Colors.purple,
        backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 750),
        strokeWidth: 40,
        strokeCap: StrokeCap.butt,
        isLoading: true,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(
        props.any((DiagnosticsNode prop) => prop.name == "targetValue"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "duration"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "backgroundColor"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "valueColor"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "strokeWidth"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "strokeCap"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "isLoading"),
        isTrue,
      );
    });

    test("HalfCircleProgressPainter shouldRepaint returns true when value changes", () {
      final HalfCircleProgressPainter painter1 = HalfCircleProgressPainter(
        backgroundColor: Colors.grey,
        valueColor: Colors.blue,
        value: 0.5,
        strokeWidth: 35,
        strokeCap: StrokeCap.round,
      );

      final HalfCircleProgressPainter painter2 = HalfCircleProgressPainter(
        backgroundColor: Colors.grey,
        valueColor: Colors.blue,
        value: 0.7,
        strokeWidth: 35,
        strokeCap: StrokeCap.round,
      );

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test("HalfCircleProgressPainter shouldRepaint returns true when backgroundColor changes", () {
      final HalfCircleProgressPainter painter1 = HalfCircleProgressPainter(
        backgroundColor: Colors.grey,
        valueColor: Colors.blue,
        value: 0.5,
        strokeWidth: 35,
        strokeCap: StrokeCap.round,
      );

      final HalfCircleProgressPainter painter2 = HalfCircleProgressPainter(
        backgroundColor: Colors.red,
        valueColor: Colors.blue,
        value: 0.5,
        strokeWidth: 35,
        strokeCap: StrokeCap.round,
      );

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test("HalfCircleProgressPainter shouldRepaint returns true when valueColor changes", () {
      final HalfCircleProgressPainter painter1 = HalfCircleProgressPainter(
        backgroundColor: Colors.grey,
        valueColor: Colors.blue,
        value: 0.5,
        strokeWidth: 35,
        strokeCap: StrokeCap.round,
      );

      final HalfCircleProgressPainter painter2 = HalfCircleProgressPainter(
        backgroundColor: Colors.grey,
        valueColor: Colors.green,
        value: 0.5,
        strokeWidth: 35,
        strokeCap: StrokeCap.round,
      );

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test("HalfCircleProgressPainter shouldRepaint returns true when strokeWidth changes", () {
      final HalfCircleProgressPainter painter1 = HalfCircleProgressPainter(
        backgroundColor: Colors.grey,
        valueColor: Colors.blue,
        value: 0.5,
        strokeWidth: 35,
        strokeCap: StrokeCap.round,
      );

      final HalfCircleProgressPainter painter2 = HalfCircleProgressPainter(
        backgroundColor: Colors.grey,
        valueColor: Colors.blue,
        value: 0.5,
        strokeWidth: 50,
        strokeCap: StrokeCap.round,
      );

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test("HalfCircleProgressPainter shouldRepaint returns true when strokeCap changes", () {
      final HalfCircleProgressPainter painter1 = HalfCircleProgressPainter(
        backgroundColor: Colors.grey,
        valueColor: Colors.blue,
        value: 0.5,
        strokeWidth: 35,
        strokeCap: StrokeCap.round,
      );

      final HalfCircleProgressPainter painter2 = HalfCircleProgressPainter(
        backgroundColor: Colors.grey,
        valueColor: Colors.blue,
        value: 0.5,
        strokeWidth: 35,
        strokeCap: StrokeCap.square,
      );

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test("HalfCircleProgressPainter shouldRepaint returns false when nothing changes", () {
      final HalfCircleProgressPainter painter1 = HalfCircleProgressPainter(
        backgroundColor: Colors.grey,
        valueColor: Colors.blue,
        value: 0.5,
        strokeWidth: 35,
        strokeCap: StrokeCap.round,
      );

      final HalfCircleProgressPainter painter2 = HalfCircleProgressPainter(
        backgroundColor: Colors.grey,
        valueColor: Colors.blue,
        value: 0.5,
        strokeWidth: 35,
        strokeCap: StrokeCap.round,
      );

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
