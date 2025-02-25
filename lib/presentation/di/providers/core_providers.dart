import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service_controllers/auth_state_controller.dart';

final Provider<SharedPreferences?> sharedPreferencesProvider =
    Provider<SharedPreferences?>((ref) {
  return null;
});

final StateProvider<AuthStateController?> authProvider =
    StateProvider<AuthStateController?>((ref) {
  return null;
});
