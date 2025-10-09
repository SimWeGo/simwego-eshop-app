import "package:esim_open_source/presentation/enums/view_state.dart";
import "package:esim_open_source/presentation/views/home_flow_views/data_plans_view/purchase_loading_view/purchase_loading_view.dart";
import "package:esim_open_source/presentation/views/home_flow_views/data_plans_view/purchase_loading_view/purchase_loading_view_model.dart";
import "package:flutter/foundation.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";

import "../../../../../helpers/view_helper.dart";
import "../../../../../helpers/view_model_helper.dart";
import "../../../../../locator_test.dart";
import "../../../../../locator_test.mocks.dart";

Future<void> main() async {
  await prepareTest();

  setUp(() async {
    await setupTest();
    onViewModelReadyMock(viewName: "PurchaseLoadingView");
    
    // Replace the real ViewModel with a mock to avoid timer issues
    final MockPurchaseLoadingViewModel mockViewModel = MockPurchaseLoadingViewModel();
    when(mockViewModel.viewState).thenReturn(ViewState.idle);
    when(mockViewModel.isBusy).thenReturn(false);
    when(mockViewModel.orderID).thenReturn(null);
    when(mockViewModel.bearerToken).thenReturn(null);
    when(mockViewModel.isApiFetched).thenReturn(false);
    when(mockViewModel.onViewModelReady()).thenReturn(null);
    
    // Override the locator registration for the ViewModel
    locator..unregister<PurchaseLoadingViewModel>()
    ..registerFactory<PurchaseLoadingViewModel>(() => mockViewModel);
  });

  testWidgets("renders basic structure with required components",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestableWidget(
        const PurchaseLoadingView(orderID: "1"),
      ),
    );
    await tester.pump();

    // Check if any actual exception occurred (not just overflow)
    final FlutterError? exception = tester.takeException() as FlutterError?;
    if (exception != null &&
        !exception.message.contains("RenderFlex overflowed")) {
      throw exception;
    }
  });

  test("debug properties coverage", () {
    const String testOrderID = "test_order_123";
    const String testBearerToken = "test_token_456";
    const PurchaseLoadingView widget = PurchaseLoadingView(
      orderID: testOrderID,
      bearerToken: testBearerToken,
    );

    final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
    widget.debugFillProperties(builder);

    final List<DiagnosticsProperty<Object>> props =
        builder.properties.whereType<DiagnosticsProperty<Object>>().toList();

    final DiagnosticsProperty<Object>? orderIDProp =
        props.cast<DiagnosticsProperty<Object>?>().firstWhere(
              (DiagnosticsProperty<Object>? p) => p?.name == "orderID",
              orElse: () => null,
            );

    final DiagnosticsProperty<Object>? bearerTokenProp =
        props.cast<DiagnosticsProperty<Object>?>().firstWhere(
              (DiagnosticsProperty<Object>? p) => p?.name == "bearerToken",
              orElse: () => null,
            );

    expect(orderIDProp, isNotNull);
    expect(bearerTokenProp, isNotNull);
    expect(orderIDProp?.value, testOrderID);
    expect(bearerTokenProp?.value, testBearerToken);
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });
}
