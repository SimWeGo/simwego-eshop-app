import "package:esim_open_source/presentation/widgets/bundle_validity_view.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("BundleValidityView Widget Tests", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("renders with validity and expiry date", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const BundleValidityView(
            bundleValidity: "30 days",
            bundleExpiryDate: "2024-12-31",
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(BundleValidityView), findsOneWidget);
      expect(find.text("2024-12-31"), findsOneWidget);
      expect(find.byType(Row), findsWidgets);
    });

    testWidgets("displays both texts", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const BundleValidityView(
            bundleValidity: "7 days",
            bundleExpiryDate: "2024-01-15",
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(Text), findsNWidgets(2));
      expect(find.text("2024-01-15"), findsOneWidget);
    });

    testWidgets("applies correct row layout", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const BundleValidityView(
            bundleValidity: "15 days",
            bundleExpiryDate: "2024-06-30",
          ),
        ),
      );

      await tester.pump();

      final Row row = tester.widget<Row>(find.byType(Row).first);
      expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
    });

    testWidgets("renders with empty strings", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const BundleValidityView(
            bundleValidity: "",
            bundleExpiryDate: "",
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(BundleValidityView), findsOneWidget);
      expect(find.byType(Row), findsWidgets);
    });

    testWidgets("renders with long text values", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const BundleValidityView(
            bundleValidity: "365 days unlimited",
            bundleExpiryDate: "2025-12-31 23:59:59",
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(BundleValidityView), findsOneWidget);
      expect(find.text("2025-12-31 23:59:59"), findsOneWidget);
    });

    test("handles validity property", () {
      const BundleValidityView widget = BundleValidityView(
        bundleValidity: "30 days",
        bundleExpiryDate: "2024-12-31",
      );

      expect(widget.bundleValidity, equals("30 days"));
      expect(widget.bundleExpiryDate, equals("2024-12-31"));
    });

    test("handles empty property values", () {
      const BundleValidityView widget = BundleValidityView(
        bundleValidity: "",
        bundleExpiryDate: "",
      );

      expect(widget.bundleValidity, isEmpty);
      expect(widget.bundleExpiryDate, isEmpty);
    });

    test("handles different date formats", () {
      const BundleValidityView widget = BundleValidityView(
        bundleValidity: "90 days",
        bundleExpiryDate: "31/12/2024",
      );

      expect(widget.bundleValidity, equals("90 days"));
      expect(widget.bundleExpiryDate, equals("31/12/2024"));
    });

    test("debug properties coverage", () {
      const BundleValidityView widget = BundleValidityView(
        bundleValidity: "Debug validity",
        bundleExpiryDate: "Debug date",
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      expect(
        props.any((DiagnosticsNode prop) => prop.name == "bundleValidity"),
        isTrue,
      );
      expect(
        props.any((DiagnosticsNode prop) => prop.name == "bundleExpiryDate"),
        isTrue,
      );
    });

    test("debug properties with empty values", () {
      const BundleValidityView widget = BundleValidityView(
        bundleValidity: "",
        bundleExpiryDate: "",
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
