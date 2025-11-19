import "package:esim_open_source/presentation/widgets/bundle_title_content_view.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("BundleTitleContentView Widget Tests", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("renders with title and content", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const BundleTitleContentView(
            titleText: "Test Title",
            contentText: "Test Content",
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(BundleTitleContentView), findsOneWidget);
      expect(find.text("Test Title"), findsOneWidget);
      expect(find.text("Test Content"), findsOneWidget);
    });

    testWidgets("renders without shimmer", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const BundleTitleContentView(
            titleText: "No Shimmer",
            contentText: "Content Text",
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(BundleTitleContentView), findsOneWidget);
      expect(find.text("No Shimmer"), findsOneWidget);
      expect(find.text("Content Text"), findsOneWidget);
    });

    testWidgets("renders with shimmer enabled", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const BundleTitleContentView(
            titleText: "With Shimmer",
            contentText: "Shimmer Content",
            showShimmer: true,
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(BundleTitleContentView), findsOneWidget);
      expect(find.text("With Shimmer"), findsOneWidget);
      expect(find.text("Shimmer Content"), findsOneWidget);
    });

    testWidgets("applies custom cross axis alignment", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const BundleTitleContentView(
            titleText: "Center Aligned",
            contentText: "Center Content",
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      );

      await tester.pump();

      final Column column = tester.widget<Column>(
        find.descendant(
          of: find.byType(Align),
          matching: find.byType(Column),
        ),
      );

      expect(column.crossAxisAlignment, CrossAxisAlignment.center);
    });

    testWidgets("applies default cross axis alignment", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const BundleTitleContentView(
            titleText: "Default Aligned",
            contentText: "Default Content",
          ),
        ),
      );

      await tester.pump();

      final Column column = tester.widget<Column>(
        find.descendant(
          of: find.byType(Align),
          matching: find.byType(Column),
        ),
      );

      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
    });

    testWidgets("renders with end alignment", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const BundleTitleContentView(
            titleText: "End Aligned",
            contentText: "End Content",
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
        ),
      );

      await tester.pump();

      final Column column = tester.widget<Column>(
        find.descendant(
          of: find.byType(Align),
          matching: find.byType(Column),
        ),
      );

      expect(column.crossAxisAlignment, CrossAxisAlignment.end);
    });

    testWidgets("has correct alignment", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const BundleTitleContentView(
            titleText: "Alignment Test",
            contentText: "Content",
          ),
        ),
      );

      await tester.pump();

      final Align align = tester.widget<Align>(find.byType(Align));
      expect(align.alignment, Alignment.centerLeft);
    });

    test("handles property values", () {
      const BundleTitleContentView widget = BundleTitleContentView(
        titleText: "Test",
        contentText: "Content",
      );

      expect(widget.titleText, equals("Test"));
      expect(widget.contentText, equals("Content"));
      expect(widget.showShimmer, false);
      expect(widget.crossAxisAlignment, CrossAxisAlignment.start);
    });

    test("handles custom property values", () {
      const BundleTitleContentView widget = BundleTitleContentView(
        titleText: "Custom",
        contentText: "Custom Content",
        showShimmer: true,
        crossAxisAlignment: CrossAxisAlignment.center,
      );

      expect(widget.titleText, equals("Custom"));
      expect(widget.contentText, equals("Custom Content"));
      expect(widget.showShimmer, true);
      expect(widget.crossAxisAlignment, CrossAxisAlignment.center);
    });

    test("debug properties coverage", () {
      const BundleTitleContentView widget = BundleTitleContentView(
        titleText: "Debug Title",
        contentText: "Debug Content",
        showShimmer: true,
        crossAxisAlignment: CrossAxisAlignment.center,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(
        props.any((DiagnosticsNode prop) => prop.name == "titleText"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "contentText"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "crossAxisAlignment"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "showShimmer"),
        isTrue,
      );
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
