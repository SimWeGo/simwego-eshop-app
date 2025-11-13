import "package:esim_open_source/presentation/widgets/qr_scanner/qr_scanner_view_model.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../helpers/view_helper.dart";
import "../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();

  late QrScannerViewModel viewModel;

  setUp(() async {
    await setupTest();
    onViewModelReadyMock();

    viewModel = QrScannerViewModel();
  });

  tearDown(() async {
    await tearDownTest();
  });

  group("QrScannerViewModel Initialization Tests", () {
    test("initializes with correct default values", () {
      expect(viewModel.isFlashEnabled, isFalse);
      expect(viewModel.qrKey, isNotNull);
    });

    test("qrKey is a GlobalKey", () {
      expect(viewModel.qrKey, isA<GlobalKey>());
    });

    test("flash status starts as disabled", () {
      expect(viewModel.isFlashEnabled, equals(false));
    });

    test("ViewModel properties are accessible", () {
      expect(viewModel.isFlashEnabled, isA<bool>());
      expect(viewModel.qrKey, isA<GlobalKey>());
    });
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });
}
