import "package:esim_open_source/presentation/widgets/qr_scanner/qr_scanner_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../helpers/view_helper.dart";
import "../../../helpers/view_model_helper.dart";

Future<void> main() async {
  await prepareTest();

  setUp(() async {
    await setupTest();
    onViewModelReadyMock(viewName: "QrScannerView");
  });

  tearDown(() async {
    await tearDownTest();
  });

  group("QrScannerView Widget Tests", () {
    test("routeName constant is correctly defined", () {
      expect(QrScannerView.routeName, equals("QrScannerViewRoute"));
    });

    test("widget can be instantiated", () {
      const QrScannerView widget = QrScannerView();
      expect(widget, isNotNull);
      expect(widget.key, isNull);
    });

    test("widget with key can be instantiated", () {
      const Key testKey = ValueKey<String>("test_key");
      const QrScannerView widget = QrScannerView(key: testKey);
      expect(widget, isNotNull);
      expect(widget.key, equals(testKey));
    });
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });
}
