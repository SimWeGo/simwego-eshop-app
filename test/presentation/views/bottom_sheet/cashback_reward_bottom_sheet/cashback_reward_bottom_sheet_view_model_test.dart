import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/cashback_reward_bottom_sheet/cashback_reward_bottom_sheet_view_model.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();

  late CashbackRewardBottomSheetViewModel viewModel;

  setUp(() async {
    await setupTest();
    onViewModelReadyMock(viewName: "CashbackRewardBottomSheet");

    viewModel = CashbackRewardBottomSheetViewModel();
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("CashbackRewardBottomSheetViewModel Tests", () {
    test("initialization test", () {
      expect(viewModel, isNotNull);
      expect(viewModel, isA<CashbackRewardBottomSheetViewModel>());
    });

    test("request property can be set and accessed", () {
      // Arrange
      final SheetRequest<CashbackRewardBottomRequest> testRequest =
          SheetRequest<CashbackRewardBottomRequest>(
        data: CashbackRewardBottomRequest(
          title: "Test Title",
          percent: "10%",
          description: "Test Description",
          imagePath: "assets/test.png",
        ),
      );

      // Act
      viewModel.request = testRequest;

      // Assert
      expect(viewModel.request, equals(testRequest));
      expect(viewModel.request.data?.title, equals("Test Title"));
      expect(viewModel.request.data?.percent, equals("10%"));
      expect(viewModel.request.data?.description, equals("Test Description"));
      expect(viewModel.request.data?.imagePath, equals("assets/test.png"));
    });

    test("completer property can be set and accessed", () {
      // Arrange
      void testCompleter(SheetResponse<EmptyBottomSheetResponse> response) {
        // Mock completer function
      }

      // Act
      viewModel.completer = testCompleter;

      // Assert
      expect(viewModel.completer, equals(testCompleter));
    });

    test("request with null data properties", () {
      // Arrange
      final SheetRequest<CashbackRewardBottomRequest> testRequest =
          SheetRequest<CashbackRewardBottomRequest>(
        
      );

      // Act
      viewModel.request = testRequest;

      // Assert
      expect(viewModel.request, equals(testRequest));
      expect(viewModel.request.data, isNull);
    });

    test("request with empty string values", () {
      // Arrange
      final SheetRequest<CashbackRewardBottomRequest> testRequest =
          SheetRequest<CashbackRewardBottomRequest>(
        data: CashbackRewardBottomRequest(
          title: "",
          percent: "",
          description: "",
          imagePath: "",
        ),
      );

      // Act
      viewModel.request = testRequest;

      // Assert
      expect(viewModel.request.data?.title, isEmpty);
      expect(viewModel.request.data?.percent, isEmpty);
      expect(viewModel.request.data?.description, isEmpty);
      expect(viewModel.request.data?.imagePath, isEmpty);
    });

    test("request with typical cashback values", () {
      // Arrange
      final SheetRequest<CashbackRewardBottomRequest> testRequest =
          SheetRequest<CashbackRewardBottomRequest>(
        data: CashbackRewardBottomRequest(
          title: "Cashback Reward",
          percent: "15%",
          description: "You earned 15% cashback on your purchase",
          imagePath: "assets/images/cashback_icon.png",
        ),
      );

      // Act
      viewModel.request = testRequest;

      // Assert
      expect(viewModel.request.data?.title, equals("Cashback Reward"));
      expect(viewModel.request.data?.percent, equals("15%"));
      expect(
        viewModel.request.data?.description,
        equals("You earned 15% cashback on your purchase"),
      );
      expect(
        viewModel.request.data?.imagePath,
        equals("assets/images/cashback_icon.png"),
      );
    });

    test("completer can be called with confirmed response", () {
      // Arrange
      bool completerCalled = false;
      void testCompleter(SheetResponse<EmptyBottomSheetResponse> response) {
        completerCalled = true;
      }

      viewModel.completer = testCompleter;

      // Act
      viewModel.completer(
        SheetResponse<EmptyBottomSheetResponse>(confirmed: true),
      );

      // Assert
      expect(completerCalled, isTrue);
    });

    test("completer can be called with empty response", () {
      // Arrange
      bool completerCalled = false;
      void testCompleter(SheetResponse<EmptyBottomSheetResponse> response) {
        completerCalled = true;
      }

      viewModel.completer = testCompleter;

      // Act
      viewModel.completer(SheetResponse<EmptyBottomSheetResponse>());

      // Assert
      expect(completerCalled, isTrue);
    });
  });
}
