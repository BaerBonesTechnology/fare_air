import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';

import '../tracker.dart';

class TrackerImpl implements Tracker {
  final FirebaseAnalytics? _firebaseAnalytics;

  TrackerImpl(this._firebaseAnalytics);

  @override
  void logEvent(String name, {Map<String, Object>? parameters}) {
    const String appEventTag = 'Track_Event: ';
    debugPrint(appEventTag + name);
    _firebaseAnalytics?.logEvent(name: name, parameters: parameters);
  }

  @override
  void setCurrentScreen(String screenName) {
    const String setScreenTag = 'Track_Screen: ';
    debugPrintStack(label: setScreenTag + screenName);
    _firebaseAnalytics?.logEvent(
        name: setScreenTag, parameters: {'screenNameKey': 'screenName'});
  }
}
