import 'package:fare_air/models/airport_query_response.dart';
import 'package:fare_air/models/nearby_airports_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/airport_search_service.dart';

class AirportServiceController
    extends StateController<AsyncValue<NearbyAirportResponse?>> {
  AirportServiceController(this._controller) : super(AsyncLoading());

  final AirportSearchService? _controller;
  AsyncValue<AirportQueryResponse?> queryResponse = const AsyncLoading();

  Future<AsyncValue<NearbyAirportResponse?>> getAirports() async {
    state = const AsyncLoading();
    await _controller?.getNearbyAirports().then((value) {
      state = value;
    });

    return state;
  }

  Future<AsyncValue<AirportQueryResponse?>> searchAirports(String query) async {
    queryResponse = const AsyncLoading();
    await _controller?.searchForAirport(query).then((value) {
      queryResponse = value;
    });

    return queryResponse;
  }
}
