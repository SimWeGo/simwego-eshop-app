import "package:esim_open_source/presentation/widgets/padding_widget.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("PaddingWidget Tests", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("applySymmetricPadding creates widget with symmetric padding", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          PaddingWidget.applySymmetricPadding(
            vertical: 10,
            horizontal: 20,
            child: const Text("Test"),
          ),
        ),
      );

      await tester.pump();

      final Padding padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.symmetric(vertical: 10, horizontal: 20));
    });

    testWidgets("applyPadding creates widget with directional padding", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          PaddingWidget.applyPadding(
            top: 10,
            start: 15,
            end: 20,
            bottom: 5,
            child: const Text("Test"),
          ),
        ),
      );

      await tester.pump();

      final Padding padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsetsDirectional.only(
        top: 10,
        start: 15,
        end: 20,
        bottom: 5,
      ),);
    });

    testWidgets("applyPadding with isRtlSupported false uses EdgeInsets", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          PaddingWidget.applyPadding(
            top: 10,
            start: 15,
            end: 20,
            bottom: 5,
            isRtlSupported: false,
            child: const Text("Test"),
          ),
        ),
      );

      await tester.pump();

      final Padding padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(
        top: 10,
        left: 15,
        right: 20,
        bottom: 5,
      ),);
    });

    testWidgets("renders child widget", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          PaddingWidget.applySymmetricPadding(
            vertical: 5,
            horizontal: 10,
            child: const Text("Child Widget"),
          ),
        ),
      );

      await tester.pump();

      expect(find.text("Child Widget"), findsOneWidget);
    });

    testWidgets("applySymmetricPadding with zero values", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          PaddingWidget.applySymmetricPadding(
            child: const Text("Test"),
          ),
        ),
      );

      await tester.pump();

      final Padding padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, EdgeInsets.zero);
    });

    testWidgets("applyPadding with all zero values", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          PaddingWidget.applyPadding(
            child: const Text("Test"),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(Padding), findsOneWidget);
    });

    test("debug properties coverage", () {
      final PaddingWidget widget = PaddingWidget.applySymmetricPadding(
        vertical: 10,
        horizontal: 20,
        child: const Text("Test"),
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(
        props.any((DiagnosticsNode prop) => prop.name == "vertical"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "horizontal"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "top"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "start"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "end"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "bottom"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "isRtlSupported"),
        isTrue,
      );
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
