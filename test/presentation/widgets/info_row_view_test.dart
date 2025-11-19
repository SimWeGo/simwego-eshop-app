import "package:esim_open_source/presentation/widgets/info_row_view.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("InfoRow Widget Tests", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("renders with title and message", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const InfoRow(
            title: "Test Title",
            message: "Test Message",
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(InfoRow), findsOneWidget);
      expect(find.text("Test Title"), findsOneWidget);
      expect(find.text("Test Message"), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets("renders with title only (no message)", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const InfoRow(
            title: "Title Only",
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(InfoRow), findsOneWidget);
      expect(find.text("Title Only"), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets("applies correct layout structure", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const InfoRow(
            title: "Layout Test",
            message: "Message Test",
          ),
        ),
      );

      await tester.pump();

      final Finder columnFinder = find.descendant(
        of: find.byType(SizedBox),
        matching: find.byType(Column),
      );

      expect(columnFinder, findsWidgets);

      final Column column = tester.widget<Column>(columnFinder.first);
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
    });

    testWidgets("has full width", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const InfoRow(
            title: "Width Test",
          ),
        ),
      );

      await tester.pump();

      final SizedBox sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(InfoRow),
          matching: find.byType(SizedBox),
        ).first,
      );

      expect(sizedBox.width, double.infinity);
    });

    test("handles null message property", () {
      const InfoRow widget = InfoRow(
        title: "Test Title",
      );

      expect(widget.title, equals("Test Title"));
      expect(widget.message, isNull);
    });

    test("handles non-null message property", () {
      const InfoRow widget = InfoRow(
        title: "Test Title",
        message: "Test Message",
      );

      expect(widget.title, equals("Test Title"));
      expect(widget.message, equals("Test Message"));
    });

    test("debug properties coverage", () {
      const InfoRow widget = InfoRow(
        title: "Debug Title",
        message: "Debug Message",
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(props.any((DiagnosticsNode prop) => prop.name == "title"), isTrue);
      expect(props.any((DiagnosticsNode prop) => prop.name == "message"), isTrue);
    });

    test("debug properties with null message", () {
      const InfoRow widget = InfoRow(
        title: "Debug Title",
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(props.any((DiagnosticsNode prop) => prop.name == "title"), isTrue);
      expect(props.any((DiagnosticsNode prop) => prop.name == "message"), isTrue);
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
