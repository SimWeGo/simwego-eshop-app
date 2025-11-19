import "package:esim_open_source/presentation/widgets/circular_flag_icon.dart";
import "package:esim_open_source/presentation/widgets/country_flag_image.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("CircularFlagIcon Widget Tests", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("renders with icon and size", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const CircularFlagIcon(
            icon: "us",
            size: 50,
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularFlagIcon), findsOneWidget);
      expect(find.byType(CountryFlagImage), findsOneWidget);
      expect(find.byType(DecoratedBox), findsAtLeastNWidgets(1));
    });

    testWidgets("renders with custom border width", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const CircularFlagIcon(
            icon: "uk",
            size: 60,
            borderWidth: 3,
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularFlagIcon), findsOneWidget);
      expect(find.byType(DecoratedBox), findsAtLeastNWidgets(1));
    });

    testWidgets("renders with custom border color", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const CircularFlagIcon(
            icon: "fr",
            size: 40,
            borderColor: Colors.red,
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularFlagIcon), findsOneWidget);
      expect(find.byType(DecoratedBox), findsAtLeastNWidgets(1));
    });

    testWidgets("renders with all custom properties", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const CircularFlagIcon(
            icon: "de",
            size: 70,
            borderWidth: 2.5,
            borderColor: Colors.blue,
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularFlagIcon), findsOneWidget);
      expect(find.byType(CountryFlagImage), findsOneWidget);
    });

    testWidgets("contains ClipOval for circular shape", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const CircularFlagIcon(
            icon: "ca",
            size: 50,
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(ClipOval), findsOneWidget);
    });

    testWidgets("passes correct size to CountryFlagImage", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const CircularFlagIcon(
            icon: "au",
            size: 80,
          ),
        ),
      );

      await tester.pump();

      final CountryFlagImage flagImage = tester.widget<CountryFlagImage>(
        find.byType(CountryFlagImage),
      );

      expect(flagImage.icon, "au");
      expect(flagImage.width, 80);
      expect(flagImage.height, 80);
    });

    test("handles default property values", () {
      const CircularFlagIcon widget = CircularFlagIcon(
        icon: "us",
        size: 50,
      );

      expect(widget.icon, equals("us"));
      expect(widget.size, 50);
      expect(widget.borderWidth, 1.5);
      expect(widget.borderColor, Colors.white);
    });

    test("handles custom property values", () {
      const CircularFlagIcon widget = CircularFlagIcon(
        icon: "jp",
        size: 100,
        borderWidth: 3,
        borderColor: Colors.black,
      );

      expect(widget.icon, equals("jp"));
      expect(widget.size, 100);
      expect(widget.borderWidth, 3.0);
      expect(widget.borderColor, Colors.black);
    });

    test("handles zero border width", () {
      const CircularFlagIcon widget = CircularFlagIcon(
        icon: "es",
        size: 40,
        borderWidth: 0,
      );

      expect(widget.borderWidth, 0);
    });

    test("handles large size value", () {
      const CircularFlagIcon widget = CircularFlagIcon(
        icon: "it",
        size: 200,
      );

      expect(widget.size, 200);
    });

    test("debug properties coverage", () {
      const CircularFlagIcon widget = CircularFlagIcon(
        icon: "br",
        size: 60,
        borderWidth: 2,
        borderColor: Colors.green,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(props.any((DiagnosticsNode prop) => prop.name == "icon"), isTrue);
      expect(props.any((DiagnosticsNode prop) => prop.name == "size"), isTrue);
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "borderWidth"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "borderColor"),
        isTrue,
      );
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
