import 'package:fare_air/models/airport_query_response.dart';
import 'package:fare_air/models/current_airport_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/environment_constants.dart';
import '../../../models/content/home_screen_content.dart';
import '../../../models/nearby_airports_response.dart';
import '../../di/providers/core_providers.dart';
import 'base_screen_controller.dart';

class HomeScreenController extends BaseScreenController {
  HomeScreenController(super.ref) : super();

  HomeScreenContent? _content;
  String? _header;
  String? _initialSearchLocation = '';
  List<AirportData> _searchResults = [];

  HomeScreenContent? get content => _content;
  double bottomSheetSize = 0.0;

  @override
  Future<void> initialize() async {
    // Set content for the home screen
    _header = 'Welcome to $appName';

    await ref.read(airportServiceControllerProvider)?.getAirports().then(
        (value) {
      tracker.logEvent('nearby_airports_loaded: ${value.value?.data}');
      if (value is AsyncData) {
        final AsyncValue<NearbyAirportResponse?> data = value;
        if (data.hasValue) {
          _initialSearchLocation = data.value?.data?.nearby?.first.navigation
                  ?.relevantFlightParams?.skyId ??
              '';
          _searchResults = data.value?.data?.nearby ?? [];
        }
      }
    }, onError: (e) {
      tracker.logEvent('nearby_airports_error: $e');
    });

    _content = HomeScreenContent(
      header: _header,
      initialSearchLocation: _initialSearchLocation,
      searchResults: _searchResults,
    );

    tracker.logEvent('home_screen_opened: ${_content?.toString()}');
  }

  @override
  HomeScreenContent? build(BuildContext context) {
    return null;
  }

  Future<AsyncValue<AirportQueryResponse?>?> searchAirports(
      String query) async {
    final response =
        await ref.read(airportServiceControllerProvider)?.searchAirports(query);
    switch (response) {
      case AsyncLoading _:
        tracker.logEvent('searching_for_airport: $query');
        break;
      case AsyncData data:
        tracker.logEvent('searched_for_airport: ${data.value?.data}');
        return response;
      case AsyncError error:
        tracker.logEvent('search_for_airport_error: ${error.error}');
        break;
      default:
        tracker.logEvent('search_for_airport_error: ${response?.error}');
        break;
    }
    return response;
  }
}
