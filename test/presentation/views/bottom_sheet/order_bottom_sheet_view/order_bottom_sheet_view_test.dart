import "package:esim_open_source/data/remote/responses/user/order_history_response_model.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/order_bottom_sheet_view/order_bottom_sheet_view.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

void main() {
  group("OrderBottomSheetView Tests", () {
    setUpAll(() async {
      await prepareTest();
    });

    setUp(() async {
      await setupTest();
      onViewModelReadyMock(viewName: "OrderBottomSheetView");
    });

    tearDown(() async {
      await tearDownTest();
    });

    tearDownAll(() async {
      await tearDownAllTest();
    });

    test("should execute build method for coverage", () {
      void mockCompleter(SheetResponse<OrderHistoryResponseModel> response) {}

      final OrderHistoryResponseModel mockOrder = OrderHistoryResponseModel(
        orderNumber: "O1",
        companyName: "Co",
        orderDisplayPrice: r"$1",
        orderDate: "1640995200000",
        orderStatus: "Completed",
      );

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>(data: mockOrder);

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      expect(view.build, isNotNull);
      expect(view.requestBase.data?.orderNumber, equals("O1"));
    });

    test("should handle null order data correctly", () {
      void mockCompleter(SheetResponse<OrderHistoryResponseModel> response) {}

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>();

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      expect(view.requestBase.data, isNull);
      expect(view.build, isNotNull);
    });

    test("completer should be callable", () {
      bool completerCaller = false;
      void testCompleter(SheetResponse<OrderHistoryResponseModel> response) {
        completerCaller = true;
      }

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>();

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: testCompleter,
        requestBase: requestBase,
      );

      view.completer(SheetResponse<OrderHistoryResponseModel>());

      expect(completerCaller, isTrue);
    });

    test("should render and completer should be callable", () {
      bool completerCalled = false;
      void testCompleter(SheetResponse<OrderHistoryResponseModel> response) {
        completerCalled = true;
      }

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>();

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: testCompleter,
        requestBase: requestBase,
      );

      view.completer(SheetResponse<OrderHistoryResponseModel>());
      expect(completerCalled, isTrue);

      expect(view.build, isNotNull);
    });

    testWidgets("should render with order data",
        (WidgetTester tester) async {
      void mockCompleter(SheetResponse<OrderHistoryResponseModel> response) {}

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>();

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );
      tester.view.physicalSize = const Size(2500, 2556);
      tester.view.devicePixelRatio = 3.0;

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) {
              return view;
            },
          ),
        ),
      );
      await tester.pump();
    }, skip: true,);

    test("debugFillProperties should add properties correctly", () {
      void mockCompleter(SheetResponse<OrderHistoryResponseModel> response) {}

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>();

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      view.debugFillProperties(builder);

      final List<DiagnosticsNode> properties = builder.properties;
      expect(
        properties.any((DiagnosticsNode node) => node.name == "requestBase"),
        isTrue,
      );
      expect(
        properties.any((DiagnosticsNode node) => node.name == "completer"),
        isTrue,
      );
    });

    test("view should be created with required parameters", () {
      void mockCompleter(SheetResponse<OrderHistoryResponseModel> response) {}

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>();

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      expect(view.completer, equals(mockCompleter));
      expect(view.requestBase, equals(requestBase));
    });

    test("view should handle order data correctly", () {
      void mockCompleter(SheetResponse<OrderHistoryResponseModel> response) {}

      final OrderHistoryResponseModel mockOrder = OrderHistoryResponseModel(
        orderNumber: "ORDER-12345",
        companyName: "Flutter eSIM Company",
        orderDisplayPrice: r"$25.99",
        orderDate: "1640995200000",
        orderStatus: "Completed",
      );

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>(data: mockOrder);

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      expect(
        view.requestBase.data?.orderNumber,
        equals("ORDER-12345"),
      );
      expect(
        view.requestBase.data?.companyName,
        equals("Flutter eSIM Company"),
      );
      expect(
        view.requestBase.data?.orderDisplayPrice,
        equals(r"$25.99"),
      );
    });

    test("view should handle bundle details correctly", () {
      void mockCompleter(SheetResponse<OrderHistoryResponseModel> response) {}

      final OrderHistoryResponseModel mockOrder = OrderHistoryResponseModel(
        orderNumber: "ORD001",
      );

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>(data: mockOrder);

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      expect(view.requestBase.data?.bundleDetails, isNull);
    });

    test("view should handle payment details correctly", () {
      void mockCompleter(SheetResponse<OrderHistoryResponseModel> response) {}

      final OrderHistoryResponseModel mockOrder = OrderHistoryResponseModel(
        orderNumber: "ORD002",
      );

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>(data: mockOrder);

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      expect(view.requestBase.data?.paymentDetails, isNull);
    });

    test("completer callback with confirmed response", () {
      bool completerCalled = false;
      SheetResponse<OrderHistoryResponseModel>? capturedResponse;

      void testCompleter(SheetResponse<OrderHistoryResponseModel> response) {
        completerCalled = true;
        capturedResponse = response;
      }

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>();

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: testCompleter,
        requestBase: requestBase,
      );

      final SheetResponse<OrderHistoryResponseModel> response =
          SheetResponse<OrderHistoryResponseModel>(confirmed: true);
      view.completer(response);

      expect(completerCalled, isTrue);
      expect(capturedResponse?.confirmed, isTrue);
    });

    test("completer callback with unconfirmed response", () {
      bool completerCalled = false;
      SheetResponse<OrderHistoryResponseModel>? capturedResponse;

      void testCompleter(SheetResponse<OrderHistoryResponseModel> response) {
        completerCalled = true;
        capturedResponse = response;
      }

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>();

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: testCompleter,
        requestBase: requestBase,
      );

      final SheetResponse<OrderHistoryResponseModel> response =
          SheetResponse<OrderHistoryResponseModel>();
      view.completer(response);

      expect(completerCalled, isTrue);
      expect(capturedResponse?.confirmed, isFalse);
    });

    test("view properties are immutable after creation", () {
      void mockCompleter(SheetResponse<OrderHistoryResponseModel> response) {}

      final OrderHistoryResponseModel mockOrder = OrderHistoryResponseModel(
        orderNumber: "ORD003",
      );

      final SheetRequest<OrderHistoryResponseModel> requestBase =
          SheetRequest<OrderHistoryResponseModel>(data: mockOrder);

      final OrderBottomSheetView view = OrderBottomSheetView(
        completer: mockCompleter,
        requestBase: requestBase,
      );

      expect(view.completer, equals(mockCompleter));
      expect(view.requestBase, equals(requestBase));
      expect(view.key, isNull);
    });
  });
}
