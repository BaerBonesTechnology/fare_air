import 'package:fare_air/models/airport_query_response.dart';
import 'package:fare_air/models/current_airport_data.dart';
import 'package:fare_air/models/nearby_airports_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirportSearchService {
  Future<AsyncValue<NearbyAirportResponse?>> getNearbyAirports() async {
    return AsyncData(NearbyAirportResponse.empty());
  }

  void cacheAirportResponse(NearbyAirportResponse? response) async {}

  NearbyAirportResponse? getCachedAirportResponse() {
    return null;
  }

  Future<AsyncValue<AirportQueryResponse?>> searchForAirport(
      String query) async {
    return AsyncData(AirportQueryResponse.empty());
  }

  Future<AsyncValue<AirportData?>> getAirportDetails(String id) async {
    return AsyncData(AirportData.empty());
  }
}
