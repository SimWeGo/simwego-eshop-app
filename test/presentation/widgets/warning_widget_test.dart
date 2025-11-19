import "package:esim_open_source/presentation/widgets/warning_widget.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("WarningWidget Tests", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("renders with warning content", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const WarningWidget(
            warningTextContent: "This is a warning message",
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(WarningWidget), findsOneWidget);
      expect(find.text("Warning"), findsOneWidget);
      expect(find.text("This is a warning message"), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets("displays info icon", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const WarningWidget(
            warningTextContent: "Test warning",
          ),
        ),
      );

      await tester.pump();

      final Finder iconFinder = find.byIcon(Icons.info_outline);
      expect(iconFinder, findsOneWidget);

      final Icon icon = tester.widget<Icon>(iconFinder);
      expect(icon.size, 18);
    });

    testWidgets("applies correct card styling", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const WarningWidget(
            warningTextContent: "Card style test",
          ),
        ),
      );

      await tester.pump();

      final Card card = tester.widget<Card>(find.byType(Card));
      expect(card.elevation, 0);
      expect(card.margin, EdgeInsets.zero);
      expect(card.shape, isA<RoundedRectangleBorder>());
    });

    testWidgets("applies correct padding", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const WarningWidget(
            warningTextContent: "Padding test",
          ),
        ),
      );

      await tester.pump();

      final Padding padding = tester.widget<Padding>(
        find.ancestor(
          of: find.byType(Column),
          matching: find.byType(Padding),
        ).first,
      );

      expect(padding.padding, const EdgeInsets.all(12));
    });

    testWidgets("has column with correct layout", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const WarningWidget(
            warningTextContent: "Layout test",
          ),
        ),
      );

      await tester.pump();

      final Column column = tester.widget<Column>(
        find.descendant(
          of: find.byType(Padding),
          matching: find.byType(Column),
        ),
      );

      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
    });

    testWidgets("displays row with icon and title", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const WarningWidget(
            warningTextContent: "Row test",
          ),
        ),
      );

      await tester.pump();

      final Finder rowFinder = find.descendant(
        of: find.byType(Column),
        matching: find.byType(Row),
      );

      expect(rowFinder, findsOneWidget);

      final Row row = tester.widget<Row>(rowFinder);
      expect(row.children.length, 2);
    });

    test("handles warning text property", () {
      const WarningWidget widget = WarningWidget(
        warningTextContent: "Test Warning Content",
      );

      expect(widget.warningTextContent, equals("Test Warning Content"));
    });

    test("handles empty warning text", () {
      const WarningWidget widget = WarningWidget(
        warningTextContent: "",
      );

      expect(widget.warningTextContent, isEmpty);
    });

    test("debug properties coverage", () {
      const WarningWidget widget = WarningWidget(
        warningTextContent: "Debug warning text",
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(
        props.any((DiagnosticsNode prop) => prop.name == "warningTextContent"),
        isTrue,
      );
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
