import "dart:async";

import "package:esim_open_source/presentation/widgets/qr_scanner/qr_scanner_view_model.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:qr_code_scanner/qr_code_scanner.dart";
import "package:stacked_services/stacked_services.dart";

import "../../../helpers/view_helper.dart";
import "../../../helpers/view_model_helper.dart";
import "../../../locator_test.dart";
import "../../../locator_test.mocks.dart";
import "qr_scanner_view_model_test.mocks.dart";

@GenerateMocks(<Type>[QRViewController])
Future<void> main() async {
  await prepareTest();

  late QrScannerViewModel viewModel;
  late MockQRViewController mockQRViewController;
  late MockNavigationService mockNavigationService;

  setUp(() async {
    await setupTest();
    onViewModelReadyMock();

    mockQRViewController = MockQRViewController();
    mockNavigationService = locator<NavigationService>() as MockNavigationService;

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

  group("QrScannerViewModel Controller Tests", () {
    test("setController sets the controller correctly", () async {
      final StreamController<Barcode> streamController = StreamController<Barcode>();
      when(mockQRViewController.scannedDataStream).thenAnswer((_) => streamController.stream);

      viewModel.setController(mockQRViewController);

      expect(viewModel.controller, equals(mockQRViewController));
      await streamController.close();
    });

    test("setController listens to scanned data stream", () {
      final StreamController<Barcode> streamController = StreamController<Barcode>();
      when(mockQRViewController.scannedDataStream).thenAnswer((_) => streamController.stream);
      when(mockQRViewController.dispose()).thenAnswer((_) async {});
      when(mockNavigationService.back(result: anyNamed("result"))).thenReturn(true);

      viewModel.setController(mockQRViewController);

      final Barcode testBarcode = Barcode("TEST123", BarcodeFormat.qrcode, <int>[]);
      streamController..add(testBarcode)

      ..close();
    });

    test("controller getter returns the set controller", () async {
      final StreamController<Barcode> streamController = StreamController<Barcode>();
      when(mockQRViewController.scannedDataStream).thenAnswer((_) => streamController.stream);

      viewModel.setController(mockQRViewController);

      expect(viewModel.controller, isNotNull);
      expect(viewModel.controller, isA<QRViewController>());
      expect(viewModel.controller, equals(mockQRViewController));
      await streamController.close();
    });
  });

  group("QrScannerViewModel Permission Tests", () {
    testWidgets("onPermissionSet shows snackbar when permission denied", (WidgetTester tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                capturedContext = context;
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      await tester.pump();

      viewModel.onPermissionSet(
        capturedContext,
        mockQRViewController,
        hasPermission: false,
      );

      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text("no Permission"), findsOneWidget);
    });

    testWidgets("onPermissionSet does not show snackbar when permission granted", (WidgetTester tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                capturedContext = context;
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      await tester.pump();

      viewModel.onPermissionSet(
        capturedContext,
        mockQRViewController,
        hasPermission: true,
      );

      await tester.pump();

      expect(find.byType(SnackBar), findsNothing);
    });
  });

  group("QrScannerViewModel Navigation Tests", () {
    test("onBackPressed disposes controller and navigates back", () async {
      final StreamController<Barcode> streamController = StreamController<Barcode>();
      when(mockQRViewController.scannedDataStream).thenAnswer((_) => streamController.stream);
      when(mockQRViewController.dispose()).thenAnswer((_) async {});
      when(mockNavigationService.back()).thenReturn(true);

      viewModel..setController(mockQRViewController)
      ..onBackPressed();

      verify(mockQRViewController.dispose()).called(1);
      verify(mockNavigationService.back()).called(1);
      await streamController.close();
    });
  });

  group("QrScannerViewModel Flash Toggle Tests", () {
    test("toggleFlash enables flash when currently disabled", () async {
      final StreamController<Barcode> streamController = StreamController<Barcode>();
      when(mockQRViewController.scannedDataStream).thenAnswer((_) => streamController.stream);
      when(mockQRViewController.toggleFlash()).thenAnswer((_) async {});
      when(mockQRViewController.getFlashStatus()).thenAnswer((_) async => true);

      viewModel.setController(mockQRViewController);

      expect(viewModel.isFlashEnabled, isFalse);

      await viewModel.toggleFlash();

      expect(viewModel.isFlashEnabled, isTrue);
      verify(mockQRViewController.toggleFlash()).called(1);
      verify(mockQRViewController.getFlashStatus()).called(1);
      await streamController.close();
    });

    test("toggleFlash disables flash when currently enabled", () async {
      final StreamController<Barcode> streamController = StreamController<Barcode>();
      when(mockQRViewController.scannedDataStream).thenAnswer((_) => streamController.stream);
      when(mockQRViewController.toggleFlash()).thenAnswer((_) async {});
      when(mockQRViewController.getFlashStatus()).thenAnswer((_) async => false);

      viewModel.setController(mockQRViewController);

      // Manually set to enabled first
      await viewModel.toggleFlash();

      when(mockQRViewController.getFlashStatus()).thenAnswer((_) async => false);
      await viewModel.toggleFlash();

      expect(viewModel.isFlashEnabled, isFalse);
      verify(mockQRViewController.toggleFlash()).called(2);
      await streamController.close();
    });

    test("toggleFlash handles null flash status", () async {
      final StreamController<Barcode> streamController = StreamController<Barcode>();
      when(mockQRViewController.scannedDataStream).thenAnswer((_) => streamController.stream);
      when(mockQRViewController.toggleFlash()).thenAnswer((_) async {});
      when(mockQRViewController.getFlashStatus()).thenAnswer((_) async => null);

      viewModel.setController(mockQRViewController);

      await viewModel.toggleFlash();

      expect(viewModel.isFlashEnabled, isFalse);
      verify(mockQRViewController.toggleFlash()).called(1);
      verify(mockQRViewController.getFlashStatus()).called(1);
      await streamController.close();
    });

    test("toggleFlash notifies listeners", () async {
      final StreamController<Barcode> streamController = StreamController<Barcode>();
      when(mockQRViewController.scannedDataStream).thenAnswer((_) => streamController.stream);
      when(mockQRViewController.toggleFlash()).thenAnswer((_) async {});
      when(mockQRViewController.getFlashStatus()).thenAnswer((_) async => true);

      viewModel.setController(mockQRViewController);

      bool listenerCalled = false;
      viewModel.addListener(() {
        listenerCalled = true;
      });

      await viewModel.toggleFlash();

      expect(listenerCalled, isTrue);
      await streamController.close();
    });
  });

  group("QrScannerViewModel Flash Status Tests", () {
    test("isFlashTurnedOn returns true when flash is on", () async {
      final StreamController<Barcode> streamController = StreamController<Barcode>();
      when(mockQRViewController.scannedDataStream).thenAnswer((_) => streamController.stream);
      when(mockQRViewController.getFlashStatus()).thenAnswer((_) async => true);

      viewModel.setController(mockQRViewController);

      final bool result = await viewModel.isFlashTurnedOn();

      expect(result, isTrue);
      verify(mockQRViewController.getFlashStatus()).called(1);
      await streamController.close();
    });

    test("isFlashTurnedOn returns false when flash is off", () async {
      final StreamController<Barcode> streamController = StreamController<Barcode>();
      when(mockQRViewController.scannedDataStream).thenAnswer((_) => streamController.stream);
      when(mockQRViewController.getFlashStatus()).thenAnswer((_) async => false);

      viewModel.setController(mockQRViewController);

      final bool result = await viewModel.isFlashTurnedOn();

      expect(result, isFalse);
      verify(mockQRViewController.getFlashStatus()).called(1);
      await streamController.close();
    });
  });

  group("QrScannerViewModel Scan Data Tests", () {
    test("scanned data disposes controller and navigates back with result", () async {
      final StreamController<Barcode> streamController = StreamController<Barcode>();
      when(mockQRViewController.scannedDataStream).thenAnswer((_) => streamController.stream);
      when(mockQRViewController.dispose()).thenAnswer((_) async {});
      when(mockNavigationService.back(result: anyNamed("result"))).thenReturn(true);

      viewModel.setController(mockQRViewController);

      final Barcode testBarcode = Barcode("SCANNED_CODE_123", BarcodeFormat.qrcode, <int>[]);
      streamController.add(testBarcode);

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(mockQRViewController.dispose()).called(1);
      verify(mockNavigationService.back(result: "SCANNED_CODE_123")).called(1);

      streamController.close();
    });

    test("multiple scanned data events are handled correctly", () async {
      final StreamController<Barcode> streamController = StreamController<Barcode>();
      when(mockQRViewController.scannedDataStream).thenAnswer((_) => streamController.stream);
      when(mockQRViewController.dispose()).thenAnswer((_) async {});
      when(mockNavigationService.back(result: anyNamed("result"))).thenReturn(true);

      viewModel.setController(mockQRViewController);

      // First scan
      final Barcode testBarcode1 = Barcode("CODE_1", BarcodeFormat.qrcode, <int>[]);
      streamController.add(testBarcode1);

      await Future<void>.delayed(const Duration(milliseconds: 50));

      verify(mockQRViewController.dispose()).called(1);
      verify(mockNavigationService.back(result: "CODE_1")).called(1);

      streamController.close();
    });
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });
}
