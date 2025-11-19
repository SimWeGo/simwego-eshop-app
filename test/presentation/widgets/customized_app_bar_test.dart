import "dart:io";

import "package:esim_open_source/presentation/widgets/customized_app_bar.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  group("myAppBar Widget Tests - Android", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("renders AppBar on Android", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(context, title: "Test Title"),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(AppBar), Platform.isIOS ? findsNothing : findsOneWidget);
    });

    testWidgets("displays title", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(context, title: "My App"),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      expect(find.text("My App"), findsOneWidget);
    });

    testWidgets("displays empty title when not provided", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(context),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      if (!Platform.isIOS) {
        final AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));
        final Text titleWidget = appBar.title! as Text;
        expect(titleWidget.data, "");
      }
    });

    testWidgets("shows back button by default", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(context, title: "Test"),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(IconButton), findsWidgets);
    });

    testWidgets("hides back button when removeBackButton is true", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(context, title: "Test", removeBackButton: true),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      if (!Platform.isIOS) {
        final AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.leading, isA<Container>());
      }
    });

    testWidgets("shows custom back button icon", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(
                  context,
                  title: "Test",
                  backButtonIcon: const Icon(Icons.close),
                ),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsWidgets);
    });

    testWidgets("centers title when centerTitle is true", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(
                  context,
                  title: "Centered",
                  centerTitle: true,
                ),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      if (!Platform.isIOS) {
        final AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.centerTitle, isTrue);
      }
    });

    testWidgets("displays action list when provided", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(
                  context,
                  title: "Actions",
                  actionList: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {},
                    ),
                  ],
                ),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets("shows border when showBorder is true", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(
                  context,
                  title: "Border",
                  showBorder: true,
                ),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      if (!Platform.isIOS) {
        final AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.elevation, 1);
      }
    });

    testWidgets("has zero elevation when showBorder is false", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(
                  context,
                  title: "No Border",
                ),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      if (!Platform.isIOS) {
        final AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.elevation, 0);
      }
    });

    testWidgets("uses custom backgroundColor", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(
                  context,
                  title: "Custom Color",
                  backgroundColor: Colors.red,
                ),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      if (!Platform.isIOS) {
        final AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.backgroundColor, Colors.red);
      }
    });

    testWidgets("uses custom back button color", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(
                  context,
                  title: "Custom Button Color",
                  backButtonColor: Colors.green,
                ),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      final IconButton iconButton = tester.widget<IconButton>(
        find.byType(IconButton).first,
      );
      expect(iconButton.color, Colors.green);
    });

    testWidgets("calls onBackPress when provided and back button tapped", (WidgetTester tester) async {
      bool backPressed = false;

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(
                  context,
                  title: "Back Press",
                  onBackPress: () {
                    backPressed = true;
                  },
                ),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      await tester.tap(find.byType(IconButton).first);
      await tester.pump();

      expect(backPressed, isTrue);
    });

    testWidgets("displays custom leading widget", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(
                  context,
                  title: "Leading",
                  leading: const Text("Custom"),
                ),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      expect(find.text("Custom"), findsWidgets);
    });

    testWidgets("uses custom title style", (WidgetTester tester) async {
      const TextStyle customStyle = TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(
                  context,
                  title: "Styled Title",
                  customTitleStyle: customStyle,
                ),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      if (!Platform.isIOS) {
        final AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));
        final Text titleWidget = appBar.title! as Text;
        expect(titleWidget.style, customStyle);
      }
    });

    testWidgets("sets leadingWidth on Android when removeBackButton is true and no leading", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(
                  context,
                  title: "Width Test",
                  removeBackButton: true,
                ),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      if (!Platform.isIOS) {
        final AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.leadingWidth, 0);
      }
    });

    testWidgets("uses custom leadingWidthAndroid", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: myAppBar(
                  context,
                  title: "Leading Width",
                  leadingWidthAndroid: 100,
                ),
                body: const SizedBox(),
              );
            },
          ),
        ),
      );

      await tester.pump();

      if (!Platform.isIOS) {
        final AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.leadingWidth, 100);
      }
    });

    tearDown(() async {
      await tearDownTest();
    });
  });

  group("myAppBar Widget Tests - iOS", () {
    setUp(() async {
      await tearDownTest();
      await setupTest();
    });

    testWidgets("renders CupertinoNavigationBar on iOS", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              final PreferredSizeWidget appBar = myAppBar(context, title: "iOS Title");

              if (Platform.isIOS) {
                return CupertinoPageScaffold(
                  navigationBar: appBar as ObstructingPreferredSizeWidget,
                  child: const SizedBox(),
                );
              } else {
                // On non-iOS platforms, just verify the type
                return Scaffold(
                  appBar: appBar,
                  body: const SizedBox(),
                );
              }
            },
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CupertinoNavigationBar), Platform.isIOS ? findsOneWidget : findsNothing);
    });

    testWidgets("displays centered title on iOS", (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              final PreferredSizeWidget appBar = myAppBar(
                context,
                title: "Centered iOS",
                centerTitle: true,
              );

              if (Platform.isIOS) {
                return CupertinoPageScaffold(
                  navigationBar: appBar as ObstructingPreferredSizeWidget,
                  child: const SizedBox(),
                );
              } else {
                // On non-iOS platforms, just use Scaffold
                return Scaffold(
                  appBar: appBar,
                  body: const SizedBox(),
                );
              }
            },
          ),
        ),
      );

      await tester.pump();

      // Title should be visible on all platforms
      expect(find.text("Centered iOS"), findsOneWidget);
    });

    tearDown(() async {
      await tearDownTest();
    });
  });
}
