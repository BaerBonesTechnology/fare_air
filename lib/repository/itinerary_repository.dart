import 'package:fare_air/models/nearby_airports_response.dart';

class ItineraryRepository {
  Future<NearbyAirportResponse> getNearbyAirports() async {
    return NearbyAirportResponse.empty();
  }
}
