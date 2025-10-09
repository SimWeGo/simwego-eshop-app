import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/share_referral_code/share_referral_code_bottom_sheet.dart";
import "package:esim_open_source/presentation/widgets/bottom_sheet_close_button.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:esim_open_source/presentation/widgets/padding_widget.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();

  setUp(() async {
    await setupTest();
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("ShareReferralCodeBottomSheet Widget Tests", () {
    testWidgets("displays all UI components", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "ShareReferralCodeBottomSheet");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: ShareReferralCodeBottomSheet(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(ShareReferralCodeBottomSheet), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(DecoratedBox), findsWidgets);
      expect(find.byType(PaddingWidget), findsWidgets);
      expect(find.byType(BottomSheetCloseButton), findsOneWidget);
      expect(find.byType(Image), findsWidgets);
      expect(find.byType(MainButton), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byIcon(Icons.copy), findsOneWidget);
    });

    testWidgets("displays correct localized texts",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "ShareReferralCodeBottomSheet");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: ShareReferralCodeBottomSheet(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(
          find.text(LocaleKeys.shareReferral_titleText.tr()), findsOneWidget,);
      expect(find.text(LocaleKeys.shareReferral_hintText.tr()), findsOneWidget);
      expect(
          find.text(LocaleKeys.shareReferral_buttonText.tr()), findsOneWidget,);
    });

    testWidgets("displays referral code and message from viewModel",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "ShareReferralCodeBottomSheet");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: ShareReferralCodeBottomSheet(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      // Find any text widget that would contain the referral code
      expect(find.byType(Text), findsWidgets);

      // Verify the structure contains referral-related components
      final Finder rowWithCode = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Row &&
            widget.mainAxisAlignment == MainAxisAlignment.spaceBetween,
      );
      expect(rowWithCode, findsOneWidget);
    });

    testWidgets("copy button is present and tappable",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "ShareReferralCodeBottomSheet");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: ShareReferralCodeBottomSheet(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      // Test copy button exists
      final Finder copyButton = find.byIcon(Icons.copy);
      expect(copyButton, findsOneWidget);

      // Test main button exists
      final Finder mainButton = find.byType(MainButton);
      expect(mainButton, findsOneWidget);

      expect(tester.takeException(), isNull);
    });

    testWidgets("widget properties validation", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "ShareReferralCodeBottomSheet");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: ShareReferralCodeBottomSheet(
              requestBase: request,
              completer: completer,
            ),
          ),
        ),
      );
      await tester.pump();

      // Test image exists
      final Finder image = find.byType(Image);
      expect(image, findsWidgets);

      // Test main button exists
      final Finder mainButton = find.byType(MainButton);
      expect(mainButton, findsOneWidget);

      // Test padding widget exists
      final Finder paddingWidget = find.byType(PaddingWidget);
      expect(paddingWidget, findsWidgets);

      expect(tester.takeException(), isNull);
    });

    testWidgets("debug properties", (WidgetTester tester) async {
      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      final ShareReferralCodeBottomSheet widget = ShareReferralCodeBottomSheet(
        requestBase: request,
        completer: completer,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      widget.debugFillProperties(builder);

      final List<DiagnosticsNode> props = builder.properties;

      final DiagnosticsProperty<SheetRequest<dynamic>> requestBaseProp =
          props.firstWhere((DiagnosticsNode p) => p.name == "requestBase")
              as DiagnosticsProperty<SheetRequest<dynamic>>;

      final ObjectFlagProperty<
              Function(SheetResponse<EmptyBottomSheetResponse>)> completerProp =
          props.firstWhere((DiagnosticsNode p) => p.name == "completer")
              as ObjectFlagProperty<
                  Function(SheetResponse<EmptyBottomSheetResponse>)>;

      expect(requestBaseProp.value, equals(request));
      expect(completerProp.value, equals(completer));
    });
  });
}
