import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/flight_search_params.dart';
import '../../../models/flight_search_response.dart';
import '../../../services/airport_search_service.dart';
import '../../models/airport_query_response.dart';
import '../../models/nearby_airports_response.dart';

class AirportServiceController
    extends StateController<AsyncValue<NearbyAirportResponse?>> {
  AirportServiceController(this._service) : super(const AsyncLoading());

  final AirportSearchService? _service;

  Future<AsyncValue<NearbyAirportResponse?>> getAirports() async {
    state = const AsyncLoading();
    await _service?.getNearbyAirports().then((value) {
      state = value;
    });

    return state;
  }

  Future<AsyncValue<AirportQueryResponse?>> searchForAirport(
      String query) async {
    AsyncValue<AirportQueryResponse?> queryResponse = const AsyncLoading();

    await _service?.searchForAirport(query).then((value) {
      queryResponse = value;
    });
    return queryResponse;
  }

  Future<AsyncValue<FlightSearchResponse?>> searchForFlights(
      FlightSearchParameters params) async {
    AsyncValue<FlightSearchResponse?> flightSearchResponse =
        const AsyncLoading();
    await _service?.searchForFlights(params).then((value) {
      flightSearchResponse = value;
    });
    return flightSearchResponse;
  }
}
