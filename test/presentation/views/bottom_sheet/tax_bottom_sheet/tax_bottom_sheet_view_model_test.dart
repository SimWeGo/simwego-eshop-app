import "package:esim_open_source/presentation/enums/view_state.dart";
import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/tax_bottom_sheet/tax_bottom_sheet_view_model.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();
  late TaxBottomSheetViewModel viewModel;
  late SheetRequest<TaxBottomRequest> testRequest;
  late TaxBottomRequest testData;

  setUp(() async {
    await setupTest();
    onViewModelReadyMock(viewName: "TaxBottomSheet");

    testData = TaxBottomRequest(
      subTotal: r"$25.00",
      estimatedTax: r"$2.50",
      total: r"$27.50",
    );

    testRequest = SheetRequest<TaxBottomRequest>(
      data: testData,
    );

    void completer(SheetResponse<EmptyBottomSheetResponse> response) {}

    viewModel = TaxBottomSheetViewModel(
      request: testRequest,
      completer: completer,
    );
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("TaxBottomSheetViewModel Tests", () {
    test("initializes with correct default values", () {
      expect(viewModel.request, equals(testRequest));
      expect(viewModel.completer, isNotNull);
      expect(viewModel.viewState, equals(ViewState.idle));
    });

    test("extends BaseModel correctly", () {
      expect(viewModel.viewState, isA<ViewState>());
      expect(viewModel.isBusy, isA<bool>());
      expect(viewModel.hasError, isA<bool>());
      expect(viewModel.themeColor, isA<Color>());
      expect(viewModel.userService, isNotNull);
      expect(viewModel.analyticsService, isNotNull);
    });

    test("request property is accessible", () {
      expect(viewModel.request, isNotNull);
      expect(viewModel.request.data, equals(testData));
      expect(viewModel.request.data?.subTotal, equals(r"$25.00"));
      expect(viewModel.request.data?.estimatedTax, equals(r"$2.50"));
      expect(viewModel.request.data?.total, equals(r"$27.50"));
    });

    test("completer function can be called", () {
      bool completerCalled = false;

      void testCompleter(SheetResponse<EmptyBottomSheetResponse> response) {
        completerCalled = true;
      }

      final TaxBottomSheetViewModel testViewModel = TaxBottomSheetViewModel(
        request: testRequest,
        completer: testCompleter,
      );

      testViewModel.completer(SheetResponse<EmptyBottomSheetResponse>());

      expect(completerCalled, isTrue);
    });

    test("handles different request data correctly", () {
      final TaxBottomRequest customData = TaxBottomRequest(
        subTotal: r"$100.99",
        estimatedTax: r"$8.50",
        total: r"$109.49",
      );

      final SheetRequest<TaxBottomRequest> customRequest =
          SheetRequest<TaxBottomRequest>(
        data: customData,
      );

      void customCompleter(SheetResponse<EmptyBottomSheetResponse> response) {}

      final TaxBottomSheetViewModel customViewModel = TaxBottomSheetViewModel(
        request: customRequest,
        completer: customCompleter,
      );

      expect(customViewModel.request.data?.subTotal, equals(r"$100.99"));
      expect(customViewModel.request.data?.estimatedTax, equals(r"$8.50"));
      expect(customViewModel.request.data?.total, equals(r"$109.49"));
    });

    test("handles null request data gracefully", () {
      final SheetRequest<TaxBottomRequest> nullRequest =
          SheetRequest<TaxBottomRequest>(
        
      );

      void nullCompleter(SheetResponse<EmptyBottomSheetResponse> response) {}

      final TaxBottomSheetViewModel nullViewModel = TaxBottomSheetViewModel(
        request: nullRequest,
        completer: nullCompleter,
      );

      expect(nullViewModel.request.data, isNull);
    });

    test("inherits BaseModel functionality", () {
      // Test inherited properties and methods
      expect(viewModel.localStorageService, isNotNull);
      expect(viewModel.analyticsService, isNotNull);
      expect(viewModel.themeService, isNotNull);
      expect(viewModel.userService, isNotNull);
      expect(viewModel.paymentService, isNotNull);
      expect(viewModel.redirectionsHandlerService, isNotNull);
    });

    test("maintains view state consistency", () {
      expect(viewModel.viewState, equals(ViewState.idle));
      expect(viewModel.isBusy, isFalse);
      expect(viewModel.hasError, isFalse);
    });

    test("completer with confirmed response", () {
      bool completerCalled = false;
      SheetResponse<EmptyBottomSheetResponse>? response;

      void confirmedCompleter(SheetResponse<EmptyBottomSheetResponse> res) {
        completerCalled = true;
        response = res;
      }

      final TaxBottomSheetViewModel confirmedViewModel = TaxBottomSheetViewModel(
        request: testRequest,
        completer: confirmedCompleter,
      );

      confirmedViewModel.completer(
        SheetResponse<EmptyBottomSheetResponse>(confirmed: true),
      );

      expect(completerCalled, isTrue);
      expect(response, isNotNull);
      expect(response?.confirmed, isTrue);
    });

    test("completer without confirmation", () {
      bool completerCalled = false;
      SheetResponse<EmptyBottomSheetResponse>? response;

      void unconfirmedCompleter(SheetResponse<EmptyBottomSheetResponse> res) {
        completerCalled = true;
        response = res;
      }

      final TaxBottomSheetViewModel unconfirmedViewModel =
          TaxBottomSheetViewModel(
        request: testRequest,
        completer: unconfirmedCompleter,
      );

      unconfirmedViewModel.completer(
        SheetResponse<EmptyBottomSheetResponse>(),
      );

      expect(completerCalled, isTrue);
      expect(response, isNotNull);
      // SheetResponse defaults confirmed to false when not explicitly set
      expect(response?.confirmed, anyOf(isNull, isFalse));
    });

    test("request with custom properties", () {
      final SheetRequest<TaxBottomRequest> customRequest =
          SheetRequest<TaxBottomRequest>(
        data: testData,
      );

      void customCompleter(SheetResponse<EmptyBottomSheetResponse> response) {}

      final TaxBottomSheetViewModel customViewModel = TaxBottomSheetViewModel(
        request: customRequest,
        completer: customCompleter,
      );

      expect(customViewModel.request, equals(customRequest));
      expect(customViewModel.request.data, equals(testData));
    });

    test("ViewModel initialization without throwing errors", () {
      expect(() {
        TaxBottomSheetViewModel(
          request: testRequest,
          completer: viewModel.completer,
        );
      }, returnsNormally,);
    });

    test("handles empty string values in request data", () {
      final TaxBottomRequest emptyData = TaxBottomRequest(
        subTotal: "",
        estimatedTax: "",
        total: "",
      );

      final SheetRequest<TaxBottomRequest> emptyRequest =
          SheetRequest<TaxBottomRequest>(
        data: emptyData,
      );

      void emptyCompleter(SheetResponse<EmptyBottomSheetResponse> response) {}

      final TaxBottomSheetViewModel emptyViewModel = TaxBottomSheetViewModel(
        request: emptyRequest,
        completer: emptyCompleter,
      );

      expect(emptyViewModel.request.data?.subTotal, isEmpty);
      expect(emptyViewModel.request.data?.estimatedTax, isEmpty);
      expect(emptyViewModel.request.data?.total, isEmpty);
    });

    test("handles special character values in request data", () {
      final TaxBottomRequest specialData = TaxBottomRequest(
        subTotal: "€50.00",
        estimatedTax: "¥500",
        total: "£45.99",
      );

      final SheetRequest<TaxBottomRequest> specialRequest =
          SheetRequest<TaxBottomRequest>(
        data: specialData,
      );

      void specialCompleter(SheetResponse<EmptyBottomSheetResponse> response) {}

      final TaxBottomSheetViewModel specialViewModel = TaxBottomSheetViewModel(
        request: specialRequest,
        completer: specialCompleter,
      );

      expect(specialViewModel.request.data?.subTotal, equals("€50.00"));
      expect(specialViewModel.request.data?.estimatedTax, equals("¥500"));
      expect(specialViewModel.request.data?.total, equals("£45.99"));
    });
  });
}
