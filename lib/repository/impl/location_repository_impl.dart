import 'package:fare_air/constants/environment_constants.dart';
import 'package:fare_air/models/airport_search_params.dart';
import 'package:fare_air/repository/itinerary_repository.dart';

import '../../models/nearby_airports_response.dart';
import '../../services/client_service.dart';
import '../../services/location_service.dart';

class ItineraryRepositoryImpl implements ItineraryRepository {
  ItineraryRepositoryImpl(this._locationService, this._clientService);

  LocationService _locationService;
  ClientService _clientService;

  @override
  Future<NearbyAirportResponse> getNearbyAirports() async {
    // I want to first check if the location service is enabled
    await _locationService.checkPermissions().then((currentLocation) {
      if (currentLocation != null) {
        final AirportSearchParams params = AirportSearchParams(
          latitude: currentLocation.latitude ?? 0.0,
          longitude: currentLocation.longitude ?? 0.0,
        );
        _clientService.get(params.buildUrl(), rapidApiHeaders).then((value) {
          final NearbyAirportResponse response =
              NearbyAirportResponse.fromJson(value);
          return response;
        });
      }
      final homeLocation = _locationService.loadLastSearchedHomeLocation();
      if (homeLocation == null) {
        return NearbyAirportResponse.empty();
      }

      _clientService
          .get(AirportSearchParams.buildQueryUrl(homeLocation), rapidApiHeaders)
          .then((value) {
        final NearbyAirportResponse response =
            NearbyAirportResponse.fromJson(value);
        return response;
      });
    });
    return NearbyAirportResponse.empty();
  }
}
