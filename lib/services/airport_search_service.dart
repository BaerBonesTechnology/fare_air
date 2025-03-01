import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/airport_query_response.dart';
import '../models/flight_search_params.dart';
import '../models/flight_search_response.dart';
import '../models/nearby_airports_response.dart';

class AirportSearchService {
  Future<AsyncValue<NearbyAirportResponse?>> getNearbyAirports() async {
    return AsyncData(NearbyAirportResponse.empty());
  }

  Future<AsyncValue<AirportQueryResponse?>> searchForAirport(
      String query) async {
    return AsyncData(AirportQueryResponse.empty());
  }

  Future<AsyncValue<FlightSearchResponse?>> searchForFlights(
      FlightSearchParameters params) async {
    return AsyncData(FlightSearchResponse.empty());
  }
}
