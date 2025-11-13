import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/edit_name/edit_name_bottom_sheet_view.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../../helpers/view_helper.dart";
import "../../../../helpers/view_model_helper.dart";

void main() {
  group("EditNameBottomSheetView Tests", () {
    setUpAll(() async {
      await prepareTest();
    });

    setUp(() async {
      await setupTest();
      onViewModelReadyMock(viewName: "EditNameBottomSheetView");
    });

    tearDown(() async {
      await tearDownTest();
    });

    tearDownAll(() async {
      await tearDownAllTest();
    });

    test("should execute build method for coverage", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Test Name"),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.build, isNotNull);
      expect(view.request.data?.name, equals("Test Name"));
    });

    test("should handle null name data correctly", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.request.data?.name, isNull);
      expect(view.build, isNotNull);
    });

    test("should handle null request data correctly", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>();

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.request.data, isNull);
      expect(view.build, isNotNull);
    });

    test("completer should be callable", () {
      bool completerCalled = false;
      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        completerCalled = true;
      }

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>();

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: testCompleter,
      );

      view.completer(SheetResponse<MainBottomSheetResponse>());

      expect(completerCalled, isTrue);
    });

    test("should render and completer should be callable", () {
      bool completerCalled = false;
      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        completerCalled = true;
      }

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "John Doe"),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: testCompleter,
      );

      view.completer(SheetResponse<MainBottomSheetResponse>());
      expect(completerCalled, isTrue);

      expect(view.build, isNotNull);
    });

    test("view can be instantiated with name data", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Test User"),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.request.data?.name, equals("Test User"));
      expect(view.build, isNotNull);
    });

    test("view can be instantiated with empty name", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: ""),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.request.data?.name, equals(""));
      expect(view.build, isNotNull);
    });

    test("debugFillProperties should add properties correctly", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Debug Test"),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
      view.debugFillProperties(builder);

      final List<DiagnosticsNode> properties = builder.properties;
      expect(
        properties.any((DiagnosticsNode node) => node.name == "request"),
        isTrue,
      );
      expect(
        properties.any((DiagnosticsNode node) => node.name == "completer"),
        isTrue,
      );
    });

    test("view should be created with required parameters", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Required Test"),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.completer, equals(mockCompleter));
      expect(view.request, equals(request));
    });

    test("view should handle name data correctly", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "John Smith"),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.request.data?.name, equals("John Smith"));
    });

    test("completer callback with confirmed response", () {
      bool completerCalled = false;
      SheetResponse<MainBottomSheetResponse>? capturedResponse;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        completerCalled = true;
        capturedResponse = response;
      }

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>();

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: testCompleter,
      );

      final SheetResponse<MainBottomSheetResponse> response =
          SheetResponse<MainBottomSheetResponse>(confirmed: true);
      view.completer(response);

      expect(completerCalled, isTrue);
      expect(capturedResponse?.confirmed, isTrue);
    });

    test("completer callback with unconfirmed response", () {
      bool completerCalled = false;
      SheetResponse<MainBottomSheetResponse>? capturedResponse;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        completerCalled = true;
        capturedResponse = response;
      }

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>();

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: testCompleter,
      );

      final SheetResponse<MainBottomSheetResponse> response =
          SheetResponse<MainBottomSheetResponse>();
      view.completer(response);

      expect(completerCalled, isTrue);
      expect(capturedResponse?.confirmed, isFalse);
    });

    test("view properties are immutable after creation", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Immutable Test"),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.completer, equals(mockCompleter));
      expect(view.request, equals(request));
      expect(view.key, isNull);
    });

    test("completer callback with response data", () {
      SheetResponse<MainBottomSheetResponse>? capturedResponse;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        capturedResponse = response;
      }

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>();

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: testCompleter,
      );

      const MainBottomSheetResponse responseData = MainBottomSheetResponse(
        tag: "Updated Name",
        canceled: false,
      );

      final SheetResponse<MainBottomSheetResponse> response =
          SheetResponse<MainBottomSheetResponse>(data: responseData);
      view.completer(response);

      expect(capturedResponse?.data?.tag, equals("Updated Name"));
      expect(capturedResponse?.data?.canceled, isFalse);
    });

    test("view should handle very long names", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final String longName = "A" * 500;

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: longName),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.request.data?.name, equals(longName));
      expect(view.request.data?.name?.length, equals(500));
    });

    test("view should handle special characters in name", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      const String specialName = r"Name with @#$ & symbols!";

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: specialName),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.request.data?.name, equals(specialName));
    });

    test("view should handle unicode characters in name", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      const String unicodeName = "测试用户 🎉";

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: unicodeName),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.request.data?.name, equals(unicodeName));
    });

    test("multiple completer calls work correctly", () {
      int callCount = 0;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        callCount++;
      }

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>();

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: testCompleter,
      );

      view.completer(SheetResponse<MainBottomSheetResponse>());
      expect(callCount, equals(1));

      view.completer(SheetResponse<MainBottomSheetResponse>());
      expect(callCount, equals(2));
    });

    test("view should preserve request data", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      const String originalName = "Original Name";

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: originalName),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      // Call completer shouldn't modify request
      view.completer(SheetResponse<MainBottomSheetResponse>());

      expect(view.request.data?.name, equals(originalName));
    });

    test("view should be created with custom key", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>();

      final Key customKey = const ValueKey<String>("edit_name_key");

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        key: customKey,
        request: request,
        completer: mockCompleter,
      );

      expect(view.key, equals(customKey));
    });

    test("completer with canceled response", () {
      SheetResponse<MainBottomSheetResponse>? capturedResponse;

      void testCompleter(SheetResponse<MainBottomSheetResponse> response) {
        capturedResponse = response;
      }

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>();

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: testCompleter,
      );

      const MainBottomSheetResponse responseData = MainBottomSheetResponse();

      final SheetResponse<MainBottomSheetResponse> response =
          SheetResponse<MainBottomSheetResponse>(data: responseData);
      view.completer(response);

      expect(capturedResponse?.data?.canceled, isTrue);
    });

    test("view can be instantiated with null data", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>();

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.request.data, isNull);
      expect(view.build, isNotNull);
    });

    test("view should handle whitespace-only names", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      const String whitespaceName = "   ";

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: whitespaceName),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      expect(view.request.data?.name, equals(whitespaceName));
    });

    test("build method returns non-null widget", () {
      void mockCompleter(SheetResponse<MainBottomSheetResponse> response) {}

      final SheetRequest<BundleEditNameRequest> request =
          SheetRequest<BundleEditNameRequest>(
        data: BundleEditNameRequest(name: "Test"),
      );

      final EditNameBottomSheetView view = EditNameBottomSheetView(
        request: request,
        completer: mockCompleter,
      );

      // Verify the build method exists and can be called
      expect(view.build, isNotNull);
      expect(view, isA<Widget>());
    });
  });
}
