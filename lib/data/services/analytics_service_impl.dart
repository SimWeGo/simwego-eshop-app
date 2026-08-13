import "dart:developer";

import "package:esim_open_source/domain/repository/services/analytics_service.dart";
import "package:facebook_app_events/facebook_app_events.dart";
import "package:firebase_analytics/firebase_analytics.dart";

class AnalyticsServiceImpl extends AnalyticsService {
  bool _useFirebaseAnalytics = true;
  bool _useFacebookAnalytics = true;

  final FacebookAppEvents _facebookAppEvents = FacebookAppEvents();
  final FirebaseAnalytics _firebaseAppEvents = FirebaseAnalytics.instance;

  static AnalyticsServiceImpl? _instance;

  static AnalyticsServiceImpl get instance {
    if (_instance == null) {
      _instance = AnalyticsServiceImpl();
      log("Initialize Analytics Logging Service");
    }
    return _instance!;
  }

  @override
  Future<void> configure({
    bool firebaseAnalytics = true,
    bool facebookAnalytics = true,
  }) async {
    _useFirebaseAnalytics = firebaseAnalytics;
    _useFacebookAnalytics = facebookAnalytics;
    log("Analytics service initialized with Facebook Events: $facebookAnalytics and Firebase Events: $firebaseAnalytics");
    // No ATT request here: the app declares no tracking (App Privacy) and
    // Info.plist has no NSUserTrackingUsageDescription, so any
    // AppTrackingTransparency call is killed by iOS (TCC) on first launch.
  }

  @override
  Future<void> logEvent({
    required AnalyticEvent event,
  }) async {
    log("Logging event of type ${event.eventName}");
    if (_useFirebaseAnalytics) {
      logFireBaseEvent(event: event);
    }

    if (_useFacebookAnalytics) {
      logFaceBookEvent(event: event);
    }
  }

  Future<void> logFireBaseEvent({
    required AnalyticEvent event,
  }) async {
    await _firebaseAppEvents.logEvent(
      name: event.eventName,
      parameters: event.parameters,
    );
  }

  Future<void> logFaceBookEvent({
    required AnalyticEvent event,
  }) async {
    try {
      await _facebookAppEvents.logEvent(
        name: event.eventName,
        parameters: event.parameters,
      );
    } on Object catch (ex) {
      log("Error exception: $ex");
    }
  }
}
