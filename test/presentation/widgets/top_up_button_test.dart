import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:esim_open_source/presentation/widgets/top_up_button.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("TopUpButton Tests", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("renders top up button", (WidgetTester tester) async {
      bool clicked = false;

      await tester.pumpWidget(
        createTestableWidget(
          TopUpButton(
            onClick: () {
              clicked = true;
            },
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(TopUpButton), findsOneWidget);
      expect(find.byType(MainButton), findsOneWidget);
    });

    testWidgets("calls onClick when tapped", (WidgetTester tester) async {
      bool clicked = false;

      await tester.pumpWidget(
        createTestableWidget(
          TopUpButton(
            onClick: () {
              clicked = true;
            },
          ),
        ),
      );

      await tester.pump();

      await tester.tap(find.byType(MainButton));
      await tester.pump();

      expect(clicked, isTrue);
    });

    testWidgets("renders with custom background color", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          TopUpButton(
            onClick: () {},
            backgroundColor: Colors.red,
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(TopUpButton), findsOneWidget);
    });

    testWidgets("renders with custom text color", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          TopUpButton(
            onClick: () {},
            textColor: Colors.white,
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(TopUpButton), findsOneWidget);
    });

    testWidgets("renders with loading state", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          TopUpButton(
            onClick: () {},
            isLoading: true,
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(TopUpButton), findsOneWidget);
    });

    testWidgets("renders without loading state", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          TopUpButton(
            onClick: () {},
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(TopUpButton), findsOneWidget);
    });

    test("debug properties coverage", () {
      final TopUpButton widget = TopUpButton(
        onClick: () {},
        isLoading: true,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(
        props.any((DiagnosticsNode prop) => prop.name == "isLoading"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "onClick"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "backgroundColor"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "textColor"),
        isTrue,
      );
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
