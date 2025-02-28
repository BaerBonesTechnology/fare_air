import 'package:fare_air/models/airport_query_response.dart';
import 'package:fare_air/models/nearby_airports_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/airport_search_service.dart';

class AirportServiceController
    extends StateController<AsyncValue<NearbyAirportResponse?>> {
  AirportServiceController(this._service) : super(const AsyncLoading());

  final AirportSearchService? _service;
  AsyncValue<AirportQueryResponse?> queryResponse = const AsyncLoading();

  Future<AsyncValue<NearbyAirportResponse?>> getAirports() async {
    state = const AsyncLoading();
    await _service?.getNearbyAirports().then((value) {
      state = value;
    });

    return state;
  }

  Future<AsyncValue<AirportQueryResponse?>> searchForAirport(
      String query) async {
    await _service?.searchForAirport(query).then((value) {
      queryResponse = value;
    });
    return queryResponse;
  }
}
