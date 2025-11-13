// start_up_view_test.dart

import "package:esim_open_source/presentation/views/start_up_view/startup_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../helpers/view_helper.dart";

void main() async {
  await prepareTest();
  setUp(() async {
    await setupTest();
  });

  group("StartUpView Widget Tests", () {
    testWidgets("renders StartupView with scaffold and image",
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const StartUpView(),
        ),
      );

      // Verify the main structure
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets("widget can be created without errors",
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const StartUpView(),
        ),
      );

      await tester.pump();

      // Verify the widget renders without errors
      expect(find.byType(StartUpView), findsOneWidget);
    });

    test("routeName constant is correctly defined", () {
      expect(StartUpView.routeName, equals("StartUpView"));
    });

    testWidgets("verifies widget structure and layout",
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          const StartUpView(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify widget tree is properly constructed
      expect(find.byType(StartUpView), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);

      // Verify the image is present
      final Finder imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);
    });
  });

  tearDown(() async {
    await tearDownTest();
  });
  tearDownAll(() async {
    await tearDownAllTest();
  });
}
