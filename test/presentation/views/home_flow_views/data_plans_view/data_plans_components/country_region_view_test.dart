import "package:esim_open_source/core/presentation/util/flag_util.dart";
import "package:esim_open_source/presentation/views/home_flow_views/data_plans_view/data_plans_components/country_region_view.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("CountryRegionView Widget Tests", () {
    late VoidCallback mockOnTap;

    setUp(() async {
      await tearDownTest();
      await setupTest();
      
      mockOnTap = () {
        // Mock callback implementation
      };
    });

    testWidgets("renders basic structure", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          CountryRegionView(
            title: "United States",
            type: BundleType.country,
            code: "USA",
            onTap: mockOnTap,
            showShimmer: false,
            icon: "us_icon",
          ),
        ),
      );
      
      await tester.pump();

      expect(find.byType(CountryRegionView), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
      expect(find.byType(DecoratedBox), findsWidgets);
      expect(find.text("United States"), findsOneWidget);
    });

    testWidgets("renders with regional type", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          CountryRegionView(
            title: "Europe",
            type: BundleType.regional,
            code: "EUR",
            onTap: mockOnTap,
            showShimmer: false,
            icon: "europe_icon",
          ),
        ),
      );
      
      await tester.pump();

      expect(find.byType(CountryRegionView), findsOneWidget);
      expect(find.text("Europe"), findsOneWidget);
    });

    testWidgets("renders with shimmer effect", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          CountryRegionView(
            title: "Test Country",
            type: BundleType.country,
            code: "TST",
            onTap: mockOnTap,
            showShimmer: true,
            icon: "test_icon",
          ),
        ),
      );
      
      await tester.pump();

      expect(find.byType(CountryRegionView), findsOneWidget);
      expect(find.text("Test Country"), findsOneWidget);
    });

    test("handles tap callback", () {
      bool wasTapped = false;
      
      final CountryRegionView widget = CountryRegionView(
        title: "Test Country",
        type: BundleType.country,
        code: "TST",
        onTap: () {
          wasTapped = true;
        },
        showShimmer: false,
        icon: "test_icon",
      );

      // Simulate tap by calling the callback directly
      widget.onTap();
      expect(wasTapped, isTrue);
    });

    test("handles properties correctly", () {
      final CountryRegionView widget = CountryRegionView(
        title: "Test Title",
        type: BundleType.regional,
        code: "TST",
        onTap: mockOnTap,
        showShimmer: true,
        icon: "test_icon",
      );

      expect(widget.title, equals("Test Title"));
      expect(widget.type, equals(BundleType.regional));
      expect(widget.code, equals("TST"));
      expect(widget.showShimmer, isTrue);
      expect(widget.icon, equals("test_icon"));
    });

    test("debug properties coverage", () {
      final CountryRegionView widget = CountryRegionView(
        title: "Test Title",
        type: BundleType.regional,
        code: "TST",
        onTap: mockOnTap,
        showShimmer: true,
        icon: "test_icon",
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;
      expect(props, isNotEmpty);

      // Test that all properties are included
      expect(props.any((DiagnosticsNode prop) => prop.name == "title"), isTrue);
      expect(props.any((DiagnosticsNode prop) => prop.name == "type"), isTrue);
      expect(props.any((DiagnosticsNode prop) => prop.name == "code"), isTrue);
      expect(props.any((DiagnosticsNode prop) => prop.name == "onTap"), isTrue);
      expect(props.any((DiagnosticsNode prop) => prop.name == "showShimmer"), isTrue);
      expect(props.any((DiagnosticsNode prop) => prop.name == "icon"), isTrue);
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
