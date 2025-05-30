import "dart:async";

import "package:esim_open_source/data/remote/apis/api_provider.dart";
import "package:esim_open_source/data/remote/apis/notifications/notifications_apis.dart";
import "package:esim_open_source/data/remote/responses/base_response_model.dart";
import "package:esim_open_source/data/remote/responses/empty_response.dart";
import "package:esim_open_source/domain/data/api_notifications.dart";

class ApiNotificationsImpl extends APIService implements APINotifications {
  ApiNotificationsImpl._privateConstructor() : super.privateConstructor();

  static ApiNotificationsImpl? _instance;

  static ApiNotificationsImpl get instance {
    if (_instance == null) {
      _instance = ApiNotificationsImpl._privateConstructor();
      _instance?._initialise();
    }
    return _instance!;
  }

  void _initialise() {}

  @override
  FutureOr<dynamic> getConsumptionLimit() async {
    ResponseMain<EmptyResponse?> response = await sendRequest(
      endPoint: createAPIEndpoint(
        endPoint: NotificationsApis.consumptionLimit,
      ),
      fromJson: EmptyResponse.fromJson,
    );

    return response;
  }
}
