import "package:esim_open_source/app/environment/app_environment.dart";
import "package:esim_open_source/presentation/enums/login_type.dart";
import "package:esim_open_source/presentation/helpers/route_wrapper.dart";
import "package:esim_open_source/presentation/shared/in_app_redirection_heper.dart";
import "package:esim_open_source/presentation/views/pre_sign_in/continue_with_email_view/continue_with_email_view.dart";
import "package:esim_open_source/presentation/views/pre_sign_in/login_view/login_view.dart";
import "package:stacked/stacked.dart";
import "package:stacked_services/stacked_services.dart";

class NavigationServiceRoute {
  NavigationServiceRoute({
    required this.routeName,
    this.arguments,
  });

  final String routeName;
  dynamic arguments;
}

extension NavigationServiceExtensions on NavigationService {
  Future<void> clearStackAndNavigate(
    List<NavigationServiceRoute> routes,
  ) async {
    if (routes.isEmpty) {
      return;
    }

    clearStackAndShow(routes.first.routeName);

    // Future<void>.delayed(Duration.zero, () {
    _navigateNext(1, routes);
    //});
  }

  Future<void> _navigateNext(
    int index,
    List<NavigationServiceRoute> routes,
  ) async {
    if (index < routes.length) {
      navigateTo(routes[index].routeName);
      _navigateNext(index + 1, routes);
    }
  }

  Future<void> clearStackAndNavigateWithArgs(
    List<NavigationServiceRoute> routes,
  ) async {
    if (routes.isEmpty) {
      return;
    }

    clearStackAndShow(
      routes.first.routeName,
      arguments: routes.first.arguments,
    );
    _navigateNextWithArgs(1, routes);
  }

  Future<void> _navigateNextWithArgs(
    int index,
    List<NavigationServiceRoute> routes,
  ) async {
    if (index < routes.length) {
      navigateTo(
        routes[index].routeName,
        arguments: routes[index].arguments,
      );

      _navigateNextWithArgs(index + 1, routes);
    }
  }
}

extension NavigationExtension on NavigationService {
  Future<dynamic>? navigateToLoginScreen({
    InAppRedirection? redirection,
    LoginType? localLoginType,
  }) {
    bool shouldShowSocialLoginScreen = true;

    switch (AppEnvironment.appEnvironmentHelper.loginType) {
      case LoginType.email:
        shouldShowSocialLoginScreen = true;
      case LoginType.phoneNumber:
      case LoginType.emailAndPhone:
        shouldShowSocialLoginScreen = false;
    }

    if (!shouldShowSocialLoginScreen) {
      final ContinueWithEmailViewArgs args = ContinueWithEmailViewArgs(
        redirection: redirection,
        localLoginType: localLoginType,
      );

      return navigateTo(
        ContinueWithEmailView.routeName,
        arguments: RouteWrapper<ContinueWithEmailViewArgs?>(
          instance: args,
          transitionsBuilder: TransitionsBuilders.slideBottom,
        ),
      );
    }

    return navigateTo(
      LoginView.routeName,
      arguments: redirection,
    );
  }
}
