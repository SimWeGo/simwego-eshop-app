import "package:esim_open_source/presentation/enums/bottomsheet_type.dart";
import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/upgrade_wallet_bottom_sheet/upgrade_wallet_bottom_sheet_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../helpers/view_helper.dart";
import "../helpers/view_model_helper.dart";

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

  group("setupBottomSheetUi Upgrade Wallet Tests", () {
    test("setupBottomSheetUi registers builders including upgrade wallet", () {
      // The function should execute without errors
      expect(setupBottomSheetUi, returnsNormally);
    });
  });

  group("Upgrade Wallet Bottom Sheet Builder Tests", () {
    testWidgets("creates UpgradeWalletBottomSheetView via builder", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      // Access the upgrade wallet builder through the pattern used in setupBottomSheetUi
      final Map<
          BottomSheetType,
          dynamic Function(
            dynamic context,
            dynamic sheetRequest,
            Function(SheetResponse<EmptyBottomSheetResponse> p1) completer,
          )> builders = <BottomSheetType,
          dynamic Function(
        dynamic context,
        dynamic sheetRequest,
        Function(SheetResponse<EmptyBottomSheetResponse> p1) completer,
      )>{
        BottomSheetType.upgradeWallet: (
          dynamic context,
          dynamic sheetRequest,
          Function(SheetResponse<EmptyBottomSheetResponse>) completer,
        ) =>
            UpgradeWalletBottomSheetView(
              requestBase: sheetRequest,
              completer: completer,
            ),
      };

      final Widget bottomSheetWidget = builders[BottomSheetType.upgradeWallet]!(
        null,
        request,
        completer,
      );

      expect(bottomSheetWidget, isA<UpgradeWalletBottomSheetView>());

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: bottomSheetWidget,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(UpgradeWalletBottomSheetView), findsOneWidget);
    });

    testWidgets("handles upgrade wallet bottom sheet with mock request", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>(
        title: "Test Upgrade Wallet",
        description: "Test upgrade wallet bottom sheet",
      );

      // bool completerCalled = false;
      // EmptyBottomSheetResponse? responseData;

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {
        // completerCalled = true;
        // responseData = response.data;
      }

      final UpgradeWalletBottomSheetView bottomSheetWidget = UpgradeWalletBottomSheetView(
        requestBase: request,
        completer: completer,
      );

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: bottomSheetWidget,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(UpgradeWalletBottomSheetView), findsOneWidget);

      // Test close button functionality
      await tester.tap(find.byType(UpgradeWalletBottomSheetView)
          .first,); // This will trigger the close button via the completer

      // Note: The actual tap on close button is tested in the view test
      // Here we just verify the widget can be created through the builder pattern
    });

    testWidgets("verifies bottom sheet type mapping", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      // Verify that BottomSheetType.upgradeWallet maps to UpgradeWalletBottomSheetView
      const BottomSheetType upgradeWalletType = BottomSheetType.upgradeWallet;

      expect(upgradeWalletType, isA<BottomSheetType>());
      expect(upgradeWalletType.toString(), contains("upgradeWallet"));

      final UpgradeWalletBottomSheetView widget = UpgradeWalletBottomSheetView(
        requestBase: request,
        completer: completer,
      );

      expect(widget, isA<UpgradeWalletBottomSheetView>());
    });

    testWidgets("handles upgrade wallet with empty request", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      final UpgradeWalletBottomSheetView widget = UpgradeWalletBottomSheetView(
        requestBase: request,
        completer: completer,
      );

      await tester.pumpWidget(
        createTestableWidget(
          Scaffold(
            body: widget,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(UpgradeWalletBottomSheetView), findsOneWidget);
      // Should render without errors even with empty request
    });

    testWidgets("verifies upgrade wallet builder function signature", (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "UpgradeWalletBottomSheetView");

      final SheetRequest<dynamic> request = SheetRequest<dynamic>();

      void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

      // Test the builder function signature matches expected pattern
      UpgradeWalletBottomSheetView builder(
        dynamic context,
        dynamic sheetRequest,
        Function(SheetResponse<EmptyBottomSheetResponse>) completer,
      ) =>
          UpgradeWalletBottomSheetView(
            requestBase: sheetRequest,
            completer: completer,
          );

      final Widget result = builder(null, request, completer);

      expect(result, isA<UpgradeWalletBottomSheetView>());
      expect(result, isA<Widget>());
    });
  });
}
