import "package:esim_open_source/presentation/widgets/divider_line.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("DividerLine Widget Tests", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("renders with default values", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const DividerLine(),
        ),
      );

      await tester.pump();

      expect(find.byType(DividerLine), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets("renders with custom color", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const DividerLine(
            dividerColor: Colors.red,
          ),
        ),
      );

      await tester.pump();

      final Divider divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider.color, Colors.red);
    });

    testWidgets("renders with custom padding", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const DividerLine(
            verticalPadding: 10,
            horizontalPadding: 20,
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(DividerLine), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets("renders with all custom parameters", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const DividerLine(
            dividerColor: Colors.blue,
            verticalPadding: 15,
            horizontalPadding: 25,
          ),
        ),
      );

      await tester.pump();

      final Divider divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider.color, Colors.blue);
    });

    test("handles default property values", () {
      const DividerLine widget = DividerLine();

      expect(widget.dividerColor, isNull);
      expect(widget.verticalPadding, 5);
      expect(widget.horizontalPadding, 5);
    });

    test("handles custom property values", () {
      const DividerLine widget = DividerLine(
        dividerColor: Colors.green,
        verticalPadding: 8,
        horizontalPadding: 12,
      );

      expect(widget.dividerColor, Colors.green);
      expect(widget.verticalPadding, 8);
      expect(widget.horizontalPadding, 12);
    });

    test("handles zero padding", () {
      const DividerLine widget = DividerLine(
        verticalPadding: 0,
        horizontalPadding: 0,
      );

      expect(widget.verticalPadding, 0);
      expect(widget.horizontalPadding, 0);
    });

    test("debug properties coverage with all values", () {
      const DividerLine widget = DividerLine(
        dividerColor: Colors.purple,
        verticalPadding: 10,
        horizontalPadding: 15,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(
        props.any((DiagnosticsNode prop) => prop.name == "verticalPadding"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "dividerColor"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "horizontalPadding"),
        isTrue,
      );
    });

    test("debug properties with default values", () {
      const DividerLine widget = DividerLine();

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(
        props.any((DiagnosticsNode prop) => prop.name == "verticalPadding"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "horizontalPadding"),
        isTrue,
      );
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
