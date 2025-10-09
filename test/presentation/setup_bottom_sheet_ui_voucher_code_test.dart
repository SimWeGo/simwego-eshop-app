// import "package:esim_open_source/presentation/enums/bottomsheet_type.dart";
// import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
// import "package:esim_open_source/presentation/views/bottom_sheet/voucher_code_bottom_sheet/voucher_code_bottom_sheet_view.dart";
// import "package:flutter/material.dart";
// import "package:flutter_test/flutter_test.dart";
// import "package:stacked_services/stacked_services.dart";
//
// import "../helpers/view_helper.dart";
// import "../helpers/view_model_helper.dart";
//
Future<void> main() async {}
//   await prepareTest();
//
//   setUp(() async {
//     await setupTest();
//   });
//
//   tearDown(() async {
//     await tearDownTest();
//   });
//
//   tearDownAll(() async {
//     await tearDownAllTest();
//   });
//
//   group("setupBottomSheetUi Voucher Code Tests", () {
//     test("setupBottomSheetUi registers builders including voucher code", () {
//       // The function should execute without errors
//       expect(setupBottomSheetUi, returnsNormally);
//     });
//   });
//
//   group("EmptyBottomSheetResponse Tests", () {
//     test("creates instance with default constructor", () {
//       const EmptyBottomSheetResponse response = EmptyBottomSheetResponse();
//
//       expect(response, isA<EmptyBottomSheetResponse>());
//     });
//   });
//
//   group("MainBottomSheetResponse Tests", () {
//     test("creates instance with default values", () {
//       const MainBottomSheetResponse response = MainBottomSheetResponse();
//
//       expect(response.tag, equals(""));
//       expect(response.canceled, isTrue);
//     });
//
//     test("creates instance with custom values", () {
//       const MainBottomSheetResponse response = MainBottomSheetResponse(
//         tag: "custom_tag",
//         canceled: false,
//       );
//
//       expect(response.tag, equals("custom_tag"));
//       expect(response.canceled, isFalse);
//     });
//   });
//
//   group("Voucher Code Bottom Sheet Builder Tests", () {
//     testWidgets("creates VoucherCodeBottomSheetView via builder", (WidgetTester tester) async {
//       onViewModelReadyMock(viewName: "VoucherCodeBottomSheetView");
//
//       final SheetRequest<dynamic> request = SheetRequest<dynamic>();
//
//       void completer(SheetResponse<EmptyBottomSheetResponse> response) {}
//
//       // Access the voucher code builder through the pattern used in setupBottomSheetUi
//       final Map<
//           BottomSheetType,
//           dynamic Function(
//             dynamic context,
//             dynamic sheetRequest,
//             Function(SheetResponse<EmptyBottomSheetResponse> p1) completer,
//           )> builders = <BottomSheetType,
//           dynamic Function(
//         dynamic context,
//         dynamic sheetRequest,
//         Function(SheetResponse<EmptyBottomSheetResponse> p1) completer,
//       )>{
//         BottomSheetType.voucherCode: (
//           dynamic context,
//           dynamic sheetRequest,
//           Function(SheetResponse<EmptyBottomSheetResponse>) completer,
//         ) =>
//             VoucherCodeBottomSheetView(
//               requestBase: sheetRequest,
//               completer: completer,
//             ),
//       };
//
//       final Widget bottomSheetWidget = builders[BottomSheetType.voucherCode]!(
//         null,
//         request,
//         completer,
//       );
//
//       expect(bottomSheetWidget, isA<VoucherCodeBottomSheetView>());
//
//       await tester.pumpWidget(
//         createTestableWidget(bottomSheetWidget),
//       );
//       await tester.pump();
//
//       expect(find.byType(VoucherCodeBottomSheetView), findsOneWidget);
//     });
//
//     testWidgets("handles voucher code bottom sheet with mock request", (WidgetTester tester) async {
//       onViewModelReadyMock(viewName: "VoucherCodeBottomSheetView");
//
//       final SheetRequest<dynamic> request = SheetRequest<dynamic>(
//         title: "Test Voucher Code",
//         description: "Test voucher code bottom sheet",
//       );
//
//       bool completerCalled = false;
//       EmptyBottomSheetResponse? responseData;
//
//       void completer(SheetResponse<EmptyBottomSheetResponse> response) {
//         completerCalled = true;
//         responseData = response.data;
//       }
//
//       final VoucherCodeBottomSheetView bottomSheetWidget = VoucherCodeBottomSheetView(
//         requestBase: request,
//         completer: completer,
//       );
//
//       await tester.pumpWidget(
//         createTestableWidget(bottomSheetWidget),
//       );
//       await tester.pump();
//
//       expect(find.byType(VoucherCodeBottomSheetView), findsOneWidget);
//
//       // Test close button functionality
//       await tester.tap(find.byType(VoucherCodeBottomSheetView)
//           .first,); // This will trigger the close button via the completer
//
//       // Note: The actual tap on close button is tested in the view test
//       // Here we just verify the widget can be created through the builder pattern
//     });
//
//     testWidgets("verifies bottom sheet type mapping", (WidgetTester tester) async {
//       onViewModelReadyMock(viewName: "VoucherCodeBottomSheetView");
//
//       final SheetRequest<dynamic> request = SheetRequest<dynamic>();
//
//       void completer(SheetResponse<EmptyBottomSheetResponse> response) {}
//
//       // Verify that BottomSheetType.voucherCode maps to VoucherCodeBottomSheetView
//       const BottomSheetType voucherCodeType = BottomSheetType.voucherCode;
//
//       expect(voucherCodeType, isA<BottomSheetType>());
//       expect(voucherCodeType.toString(), contains("voucherCode"));
//
//       final VoucherCodeBottomSheetView widget = VoucherCodeBottomSheetView(
//         requestBase: request,
//         completer: completer,
//       );
//
//       expect(widget, isA<VoucherCodeBottomSheetView>());
//     });
//   });
// }
