import "package:esim_open_source/data/remote/responses/auth/auth_response_model.dart";
import "package:esim_open_source/domain/repository/api_auth_repository.dart";
import "package:esim_open_source/domain/repository/services/app_configuration_service.dart";
import "package:esim_open_source/domain/util/resource.dart";
import "package:esim_open_source/presentation/enums/login_type.dart";
import "package:esim_open_source/presentation/views/home_flow_views/profile_view/profile_view_sections/account_information_view/account_information_view.dart";
import "package:esim_open_source/presentation/views/home_flow_views/profile_view/profile_view_sections/account_information_view/account_information_view_model.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";

import "../../../../../../helpers/view_helper.dart";
import "../../../../../../helpers/view_model_helper.dart";
import "../../../../../../locator_test.dart";

Future<void> main() async {
  await prepareTest();
  late AccountInformationViewModel viewModel;

  setUp(() async {
    await setupTest();
    viewModel = locator<AccountInformationViewModel>();
  });

  tearDown(() async {
    await tearDownTest();
  });

  tearDownAll(() async {
    await tearDownAllTest();
  });

  group("AccountInformationView Tests", () {
    testWidgets("widget renders without exceptions",
        (WidgetTester tester) async {
      when(locator<AppConfigurationService>().getLoginType)
          .thenReturn(LoginType.email);
      onViewModelReadyMock(viewName: "AccountInformationView");
      when(locator<ApiAuthRepository>().updateUserInfo(
        msisdn: "+961",
        firstName: "",
        lastName: "",
        isNewsletterSubscribed: true,
      ),).thenAnswer((_) => Resource<AuthResponseModel>.success(
          AuthResponseModel(),
          message: "",),);
      await tester.pumpWidget(
        createTestableWidget(
          const AccountInformationView(),
        ),
      );

      // Let the widget tree settle
      await tester.pumpAndSettle();

      await tester.tap(find.byType(MainButton));
      await tester.pumpAndSettle();
    });

    testWidgets("widget renders with different login type",
        (WidgetTester tester) async {
      onViewModelReadyMock(viewName: "AccountInformationView");
      when(locator<AppConfigurationService>().getLoginType)
          .thenReturn(LoginType.phoneNumber);
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        createTestableWidget(
          const AccountInformationView(),
        ),
      );

      // Let the widget tree settle
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    test("routeName constant", () {
      expect(
          AccountInformationView.routeName, equals("AccountInformationView"),);
    });

    test("widget constructor", () {
      const AccountInformationView widget = AccountInformationView();
      expect(widget, isNotNull);
    });

    test("build method returns widget", () {
      const AccountInformationView widget = AccountInformationView();
      final BuildContext context =
          MaterialApp(home: Container()).createElement();
      final Widget result = widget.build(context);
      expect(result, isNotNull);
    });

    testWidgets("getSpacersWidgets method returns correct widgets",
        (WidgetTester tester) async {
      const AccountInformationView widget = AccountInformationView();

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (BuildContext context) => widget.getSpacersWidgets(context),
          ),
        ),
      );

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets("widget renders keyboard visibility logic",
        (WidgetTester tester) async {
      when(locator<AppConfigurationService>().getLoginType)
          .thenReturn(LoginType.emailAndPhone);
      onViewModelReadyMock(viewName: "AccountInformationView");

      await tester.pumpWidget(
        createTestableWidget(
          const AccountInformationView(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(AccountInformationView), findsOneWidget);
    });
  });
}
