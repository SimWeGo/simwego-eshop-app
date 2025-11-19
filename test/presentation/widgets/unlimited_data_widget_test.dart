import "package:esim_open_source/presentation/widgets/unlimited_data_widget.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("UnlimitedDataWidget Tests", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("renders unlimited data widget", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const UnlimitedDataWidget(),
        ),
      );

      await tester.pump();

      expect(find.byType(UnlimitedDataWidget), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets("renders with default dimensions", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const UnlimitedDataWidget(),
        ),
      );

      await tester.pump();

      final Container container = tester.widget<Container>(
        find.byType(Container).first,
      );
      final BoxConstraints constraints = container.constraints!;
      expect(constraints.maxWidth, 110);
      expect(constraints.maxHeight, 47);
    });

    testWidgets("renders with custom width", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const UnlimitedDataWidget(width: 150),
        ),
      );

      await tester.pump();

      final Container container = tester.widget<Container>(
        find.byType(Container).first,
      );
      final BoxConstraints constraints = container.constraints!;
      expect(constraints.maxWidth, 150);
    });

    testWidgets("renders with custom height", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const UnlimitedDataWidget(height: 60),
        ),
      );

      await tester.pump();

      final Container container = tester.widget<Container>(
        find.byType(Container).first,
      );
      final BoxConstraints constraints = container.constraints!;
      expect(constraints.maxHeight, 60);
    });

    testWidgets("renders with custom border radius", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const UnlimitedDataWidget(borderRadius: 12),
        ),
      );

      await tester.pump();

      expect(find.byType(UnlimitedDataWidget), findsOneWidget);
    });

    testWidgets("renders with custom padding", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const UnlimitedDataWidget(padding: EdgeInsets.all(8)),
        ),
      );

      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets("renders with loading state", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const UnlimitedDataWidget(isLoading: true),
        ),
      );

      await tester.pump();

      expect(find.byType(UnlimitedDataWidget), findsOneWidget);
    });

    testWidgets("renders without loading state", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const UnlimitedDataWidget(),
        ),
      );

      await tester.pump();

      expect(find.byType(UnlimitedDataWidget), findsOneWidget);
    });

    testWidgets("displays column layout", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const UnlimitedDataWidget(),
        ),
      );

      await tester.pump();

      expect(find.byType(Column), findsOneWidget);
    });

    test("debug properties coverage", () {
      const UnlimitedDataWidget widget = UnlimitedDataWidget(
        width: 120,
        height: 50,
        padding: EdgeInsets.all(5),
        borderRadius: 10,
        isLoading: true,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(
        props.any((DiagnosticsNode prop) => prop.name == "width"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "height"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "padding"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "borderRadius"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "isLoading"),
        isTrue,
      );
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
