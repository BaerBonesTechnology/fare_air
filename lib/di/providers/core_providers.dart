import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/client_service.dart';
import '../service_controllers/airport_service_controller.dart';
import '../service_controllers/location_state_controller.dart';

final Provider<SharedPreferences?> sharedPreferencesProvider =
    Provider<SharedPreferences?>((ref) {
  return null;
});

final Provider<ClientService?> clientProvider = Provider<ClientService?>((ref) {
  return null;
});

final StateProvider<LocationStateController?> locationProvider =
    StateProvider<LocationStateController?>((ref) {
  return null;
});

StateProvider<AirportServiceController?> airportServiceControllerProvider =
    StateProvider<AirportServiceController?>((ref) {
  return null;
});
