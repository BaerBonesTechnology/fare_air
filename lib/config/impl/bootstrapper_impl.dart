import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/providers/core_providers.dart';
import '../../di/service_controllers/airport_service_controller.dart';
import '../../di/service_controllers/location_state_controller.dart';
import '../../services/client_service.dart';
import '../../services/impl/airport_search_service_impl.dart';
import '../../services/impl/location_service_impl.dart';
import '../bootstrapper.dart';

class BootstrapperImpl implements Bootstrapper {
  @override
  Future<ProviderContainer> boot({
    bool useEmulators = false,
  }) async {
    debugPrint('Starting application');
    WidgetsFlutterBinding.ensureInitialized();

    final prefs = await SharedPreferences.getInstance();

    ProviderContainer container = ProviderContainer(overrides: [
      // Add provider overrides here
      sharedPreferencesProvider.overrideWith((ref) => prefs),
      clientProvider.overrideWith((ref) => ClientService()),
      locationProvider.overrideWith(
        (ref) => LocationStateController(
          LocationServiceImpl(ref.read(sharedPreferencesProvider)),
        ),
      ),
      airportServiceControllerProvider
          .overrideWith((ref) => AirportServiceController(
                AirportSearchServiceImpl(
                    ref.read(locationProvider)?.service,
                    ref.read(clientProvider),
                    ref.read(sharedPreferencesProvider)),
              )),
    ]);

    await container.read(locationProvider)?.checkPermissions();

    return container;
  }
}
