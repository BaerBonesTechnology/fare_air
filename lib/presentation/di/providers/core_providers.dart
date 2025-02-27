import 'package:fare_air/presentation/di/service_controllers/airport_service_controller.dart';
import 'package:fare_air/presentation/di/service_controllers/location_state_controller.dart';
import 'package:fare_air/services/client_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
