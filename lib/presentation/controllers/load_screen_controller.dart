import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/providers/core_providers.dart';
import '../di/service_controllers/auth_state_controller.dart';
import 'base_screen_controller.dart';

class InitialLoadScreenController extends BaseScreenController {
  InitialLoadScreenController(super.ref, this.context) : super();

  final BuildContext context;
  SharedPreferences? prefs;

  @override
  void initialize() async {
    final AuthStateController? auth = ref.read(authProvider);
    prefs ??= await SharedPreferences.getInstance();
    if (auth?.state == null) {
      await auth?.signInAnonymously().then(
        (value) {
          if (value != null) {
            prefs?.setBool('anonymous_user', true);
            prefs?.setString('anonymous_user_key', value.uid);
          }
        },
      );

      tracker.logEvent('anonymous_user_signed_in');
    }
    build();
  }

  @override
  void build() async {
    try {
      final AuthStateController? auth = ref.read(authProvider);
      if (auth?.state != null) {
        context.go('/');
        tracker.logEvent('Navigating to home screen');
      } else {
        await Future.delayed(const Duration(seconds: 2), () {
          tracker.logEvent('Retrying to navigate to home screen');
          initialize();
        });
      }
    } catch (e) {
      tracker.logEvent('Error navigating to home screen');
    }
  }
}
