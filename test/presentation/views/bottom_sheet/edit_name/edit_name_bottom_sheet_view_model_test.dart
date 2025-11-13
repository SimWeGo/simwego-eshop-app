import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/edit_name/edit_name_bottom_sheet_view_model.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

Future<void> main() async {
  late EditNameBottomSheetViewModel viewModel;

  setUpAll(() async {
    await prepareTest();
  });

  setUp(() async {
    await setupTest();
    onViewModelReadyMock(viewName: "EditNameBottomSheetView");

    viewModel = EditNameBottomSheetViewModel();
  });

  tearDown(() async {
    viewModel.controller.dispose();
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("EditNameBottomSheetViewModel Tests", () {
    test("initialization test", () {
      expect(viewModel, isNotNull);
      expect(viewModel, isA<EditNameBottomSheetViewModel>());
      expect(viewModel.controller, isNotNull);
      expect(viewModel.isButtonEnabled, isFalse);
    });

    test("onViewModelReady initializes controller with request data name", () {
      viewModel..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Test Name"),
      )

      ..onViewModelReady();

      expect(viewModel.controller.text, equals("Test Name"));
    });

    test(
        "onViewModelReady initializes controller with empty string when name is null",
        () {
      viewModel..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(),
      )

      ..onViewModelReady();

      expect(viewModel.controller.text, equals(""));
    });

    test(
        "onViewModelReady initializes controller with empty string when data is null",
        () {
      viewModel..request = SheetRequest<BundleEditNameRequest>()

      ..onViewModelReady();

      expect(viewModel.controller.text, equals(""));
    });

    test("closeBottomSheet calls completer with empty SheetResponse", () {
      bool completerCalled = false;
      SheetResponse<MainBottomSheetResponse>? capturedResponse;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        completerCalled = true;
        capturedResponse = response;
      }

      viewModel..completer = testCompleter

      ..closeBottomSheet();

      expect(completerCalled, isTrue);
      expect(capturedResponse, isNotNull);
      expect(capturedResponse?.data, isNull);
    });

    test("inputTextListener when text is empty sets isButtonEnabled to false",
        () {
      viewModel..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Initial"),
      )
      ..onViewModelReady();

      // Initially has text, so button should be enabled
      expect(viewModel.isButtonEnabled, isTrue);

      // Clear the text
      viewModel.controller.text = "";

      // Wait for listener to trigger
      expect(viewModel.isButtonEnabled, isFalse);
    });

    test(
        "inputTextListener when text is not empty sets isButtonEnabled to true",
        () {
      viewModel..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: ""),
      )
      ..onViewModelReady();

      // Initially empty, so button should be disabled
      expect(viewModel.isButtonEnabled, isFalse);

      // Add some text
      viewModel.controller.text = "New Name";

      // Wait for listener to trigger
      expect(viewModel.isButtonEnabled, isTrue);
    });

    test(
        "onSaveClick calls completer with MainBottomSheetResponse containing the text",
        () {
      bool completerCalled = false;
      SheetResponse<MainBottomSheetResponse>? capturedResponse;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        completerCalled = true;
        capturedResponse = response;
      }

      viewModel..completer = testCompleter
      ..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Test"),
      )
      ..onViewModelReady();

      viewModel.controller.text = "Updated Name";

      viewModel.onSaveClick();

      expect(completerCalled, isTrue);
      expect(capturedResponse, isNotNull);
      expect(capturedResponse?.data, isNotNull);
      expect(capturedResponse?.data?.tag, equals("Updated Name"));
      expect(capturedResponse?.data?.canceled, isFalse);
    });

    test("onSaveClick with empty text still calls completer", () {
      bool completerCalled = false;
      SheetResponse<MainBottomSheetResponse>? capturedResponse;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        completerCalled = true;
        capturedResponse = response;
      }

      viewModel..completer = testCompleter
      ..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: ""),
      )
      ..onViewModelReady()

      ..onSaveClick();

      expect(completerCalled, isTrue);
      expect(capturedResponse?.data?.tag, equals(""));
      expect(capturedResponse?.data?.canceled, isFalse);
    });

    test("controller listener updates isButtonEnabled correctly", () async {
      viewModel..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: ""),
      )
      ..onViewModelReady();

      expect(viewModel.isButtonEnabled, isFalse);

      // Add text - button should be enabled
      viewModel.controller.text = "Some text";
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(viewModel.isButtonEnabled, isTrue);

      // Clear text - button should be disabled
      viewModel.controller.text = "";
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(viewModel.isButtonEnabled, isFalse);

      // Add text again - button should be enabled
      viewModel.controller.text = "More text";
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(viewModel.isButtonEnabled, isTrue);
    });

    test("request property can be set", () {
      final SheetRequest<BundleEditNameRequest> testRequest =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Test Name"),
      );

      viewModel.request = testRequest;

      expect(viewModel.request, equals(testRequest));
      expect(viewModel.request.data?.name, equals("Test Name"));
    });

    test("completer property can be set", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      viewModel.completer = mockCompleter;

      expect(viewModel.completer, equals(mockCompleter));
    });

    test("completer can be invoked when set", () {
      bool completerCalled = false;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        completerCalled = true;
      }

      viewModel.completer = testCompleter;
      viewModel.completer(SheetResponse<MainBottomSheetResponse>());

      expect(completerCalled, isTrue);
    });

    test("onViewModelReady adds listener to controller", () {
      viewModel..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Test"),
      )

      ..onViewModelReady();

      // Change text to verify listener is working
      viewModel.controller.text = "New Value";

      expect(viewModel.isButtonEnabled, isTrue);
    });

    test("isButtonEnabled reflects controller text state", () {
      viewModel..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: ""),
      )
      ..onViewModelReady();

      // Initially empty
      expect(viewModel.isButtonEnabled, isFalse);

      // Add single character
      viewModel.controller.text = "A";
      expect(viewModel.isButtonEnabled, isTrue);

      // Add more text
      viewModel.controller.text = "A longer name";
      expect(viewModel.isButtonEnabled, isTrue);

      // Clear text
      viewModel.controller.text = "";
      expect(viewModel.isButtonEnabled, isFalse);
    });

    test("multiple text changes update isButtonEnabled correctly", () {
      viewModel..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: ""),
      )
      ..onViewModelReady();

      expect(viewModel.isButtonEnabled, isFalse);

      viewModel.controller.text = "First";
      expect(viewModel.isButtonEnabled, isTrue);

      viewModel.controller.text = "Second";
      expect(viewModel.isButtonEnabled, isTrue);

      viewModel.controller.text = "";
      expect(viewModel.isButtonEnabled, isFalse);

      viewModel.controller.text = "Third";
      expect(viewModel.isButtonEnabled, isTrue);
    });

    test("closeBottomSheet does not modify controller text", () {
      viewModel..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Test Name"),
      )
      ..onViewModelReady();

      final String originalText = viewModel.controller.text;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {}
      viewModel..completer = testCompleter

      ..closeBottomSheet();

      expect(viewModel.controller.text, equals(originalText));
    });

    test("onSaveClick preserves controller text value", () {
      viewModel..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Original"),
      )
      ..onViewModelReady();

      viewModel.controller.text = "Updated Name";
      final String textBeforeSave = viewModel.controller.text;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {}
      viewModel..completer = testCompleter

      ..onSaveClick();

      expect(viewModel.controller.text, equals(textBeforeSave));
    });

    test("controller text with whitespace enables button", () {
      viewModel..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: ""),
      )
      ..onViewModelReady();

      expect(viewModel.isButtonEnabled, isFalse);

      viewModel.controller.text = "   ";
      expect(viewModel.isButtonEnabled, isTrue);
    });

    test("onSaveClick with special characters in text", () {
      SheetResponse<MainBottomSheetResponse>? capturedResponse;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        capturedResponse = response;
      }

      viewModel..completer = testCompleter
      ..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: ""),
      )
      ..onViewModelReady();

      viewModel.controller.text = r"Name with @#$ special chars!";

      viewModel.onSaveClick();

      expect(
        capturedResponse?.data?.tag,
        equals(r"Name with @#$ special chars!"),
      );
    });

    test("onViewModelReady with very long name", () {
      final String longName = "A" * 500;
      viewModel..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: longName),
      )

      ..onViewModelReady();

      expect(viewModel.controller.text, equals(longName));
      expect(viewModel.isButtonEnabled, isTrue);
    });

    test("completer is called exactly once per closeBottomSheet call", () {
      int callCount = 0;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        callCount++;
      }

      viewModel..completer = testCompleter

      ..closeBottomSheet();
      expect(callCount, equals(1));

      viewModel.closeBottomSheet();
      expect(callCount, equals(2));
    });

    test("completer is called exactly once per onSaveClick call", () {
      int callCount = 0;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        callCount++;
      }

      viewModel..completer = testCompleter
      ..request = SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Test"),
      )
      ..onViewModelReady()

      ..onSaveClick();
      expect(callCount, equals(1));

      viewModel.onSaveClick();
      expect(callCount, equals(2));
    });
  });
}
