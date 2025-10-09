import "package:esim_open_source/presentation/setup_dialog_ui.dart";
import "package:esim_open_source/presentation/views/dialog/main_dialog_model.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../helpers/view_helper.dart";
import "../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();
  late MainDialogViewModel viewModel;

  setUp(() async {
    await setupTest();
    onViewModelReadyMock(viewName: "MainDialogView");
    viewModel = MainDialogViewModel();
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("MainDialogViewModel Tests", () {
    test("initializeData initializes correctly", () {
      viewModel.initializeData();

      expect(viewModel.themeColor, isNotNull);
    });

    test("closeClicked completes with default response", () {
      bool completed = false;
      MainDialogResponse? response;

      void completer(DialogResponse<MainDialogResponse> dialogResponse) {
        completed = true;
        response = dialogResponse.data;
      }

      viewModel.closeClicked(completer);

      expect(completed, isTrue);
      expect(response, isNotNull);
      expect(response?.tag, equals(""));
      expect(response?.canceled, isTrue);
    });

    test("cancelClicked completes with default response", () {
      bool completed = false;
      MainDialogResponse? response;

      void completer(DialogResponse<MainDialogResponse> dialogResponse) {
        completed = true;
        response = dialogResponse.data;
      }

      viewModel.cancelClicked(completer);

      expect(completed, isTrue);
      expect(response, isNotNull);
      expect(response?.tag, equals(""));
      expect(response?.canceled, isTrue);
    });

    test("mainButtonClicked completes with request tag", () {
      bool completed = false;
      MainDialogResponse? response;
      const String testTag = "test_main_button";

      const MainDialogRequest request = MainDialogRequest(
        mainButtonTag: testTag,
      );

      void completer(DialogResponse<MainDialogResponse> dialogResponse) {
        completed = true;
        response = dialogResponse.data;
      }

      viewModel.mainButtonClicked(completer: completer, request: request);

      expect(completed, isTrue);
      expect(response, isNotNull);
      expect(response?.tag, equals(testTag));
      expect(response?.canceled, isFalse);
    });

    test("mainButtonClicked handles null tag", () {
      bool completed = false;
      MainDialogResponse? response;

      const MainDialogRequest request = MainDialogRequest(
        
      );

      void completer(DialogResponse<MainDialogResponse> dialogResponse) {
        completed = true;
        response = dialogResponse.data;
      }

      viewModel.mainButtonClicked(completer: completer, request: request);

      expect(completed, isTrue);
      expect(response, isNotNull);
      expect(response?.tag, equals(""));
      expect(response?.canceled, isFalse);
    });

    test("secondaryButtonClicked completes with request tag", () {
      bool completed = false;
      MainDialogResponse? response;
      const String testTag = "test_secondary_button";

      const MainDialogRequest request = MainDialogRequest(
        secondaryButtonTag: testTag,
      );

      void completer(DialogResponse<MainDialogResponse> dialogResponse) {
        completed = true;
        response = dialogResponse.data;
      }

      viewModel.secondaryButtonClicked(completer: completer, request: request);

      expect(completed, isTrue);
      expect(response, isNotNull);
      expect(response?.tag, equals(testTag));
      expect(response?.canceled, isFalse);
    });

    test("secondaryButtonClicked handles null tag", () {
      bool completed = false;
      MainDialogResponse? response;

      const MainDialogRequest request = MainDialogRequest(
        
      );

      void completer(DialogResponse<MainDialogResponse> dialogResponse) {
        completed = true;
        response = dialogResponse.data;
      }

      viewModel.secondaryButtonClicked(completer: completer, request: request);

      expect(completed, isTrue);
      expect(response, isNotNull);
      expect(response?.tag, equals(""));
      expect(response?.canceled, isFalse);
    });
  });
}
