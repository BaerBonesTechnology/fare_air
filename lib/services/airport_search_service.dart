import 'package:fare_air/models/airport_query_response.dart';
import 'package:fare_air/models/nearby_airports_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirportSearchService {
  Future<AsyncValue<NearbyAirportResponse?>> getNearbyAirports() async {
    return AsyncData(NearbyAirportResponse.empty());
  }

  Future<AsyncValue<AirportQueryResponse?>> searchForAirport(
      String query) async {
    return AsyncData(AirportQueryResponse.empty());
  }
}
