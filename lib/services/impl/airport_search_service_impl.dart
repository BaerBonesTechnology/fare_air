import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/defaults.dart';
import '../../constants/environment_constants.dart';
import '../../models/airport_query_response.dart';
import '../../models/airport_search_params.dart';
import '../../models/flight_search_params.dart';
import '../../models/flight_search_response.dart';
import '../../models/nearby_airports_response.dart';
import '../airport_search_service.dart';
import '../client_service.dart';
import '../location_service.dart';

class AirportSearchServiceImpl implements AirportSearchService {
  AirportSearchServiceImpl(
      this._locationService, this._clientService, this._sharedPreferences);

  final LocationService? _locationService;
  final ClientService? _clientService;
  final SharedPreferences? _sharedPreferences;

  @override
  Future<AsyncValue<NearbyAirportResponse?>> getNearbyAirports(
      {bool checkCache = true}) async {
    // I want to first check if the location service is enabled
    try {
      if (_getCachedAirportResponse() != null && checkCache) {
        if (_getCachedAirportResponse()?.data?.current != null) {
          return AsyncData(_getCachedAirportResponse());
        }
      }

      AsyncValue<NearbyAirportResponse?> nearbyAirports = const AsyncLoading();

      await _locationService?.checkPermissions().then((currentLocation) async {
        if (currentLocation != null) {
          final AirportSearchParams params = AirportSearchParams(
            latitude: currentLocation.latitude ?? 0.0,
            longitude: currentLocation.longitude ?? 0.0,
          );

          await _clientService?.get(params.buildUrl(), rapidApiHeaders).then(
              (value) {
            final NearbyAirportResponse response =
                NearbyAirportResponse.fromJson(value);

            nearbyAirports = AsyncData(response);
          }, onError: (e) {
            return AsyncError(e, StackTrace.current);
          });
        }
        if (nearbyAirports is! AsyncData) {
          final homeLocation = _locationService.loadLastSearchedHomeLocation();
          if (homeLocation == null) {
            return AsyncData(NearbyAirportResponse.empty());
          }

          await _clientService
              ?.get(AirportSearchParams.buildQueryUrl(homeLocation),
                  rapidApiHeaders)
              .then((value) {
            final NearbyAirportResponse naResponse =
                NearbyAirportResponse.fromJson(value);
            nearbyAirports = AsyncData(naResponse);
          }, onError: (e) {
            nearbyAirports = AsyncError(e, StackTrace.current);
          });
        }
      });

      if (nearbyAirports is AsyncData) {
        _cacheAirportResponse(nearbyAirports.value);
      }

      return nearbyAirports;
    } catch (e) {
      if (checkCache) {
        // This is most likely a cache error if reached, clear cache and set checkCache to false
        _sharedPreferences?.remove(nearbyAirportKey);
        return getNearbyAirports(checkCache: false);
      }

      return AsyncError(e, StackTrace.current);
    }
  }

  void _cacheAirportResponse(response) async {
    // I want to cache the response
    _sharedPreferences?.setString(
        nearbyAirportKey, jsonEncode(response?.toJson().toString() ?? ''));
  }

  NearbyAirportResponse? _getCachedAirportResponse() {
    // I want to get the cached response
    final response = _sharedPreferences?.getString(nearbyAirportKey);

    if (response != null) {
      return NearbyAirportResponse.fromJson(jsonDecode(response));
    }
    return null;
  }

  @override
  Future<AsyncData<AirportQueryResponse>> searchForAirport(String query) async {
    final content = AsyncData(AirportQueryResponse.empty());

    await _clientService
        ?.get(
      query,
      rapidApiHeaders,
    )
        .then((value) {
      if (value.isNotEmpty) {
        final response = AirportQueryResponse.fromJson(value);
        content.value.data.addAll(response.data);
      }
    }, onError: (e) {
      return AsyncError(e, StackTrace.current);
    });

    return content;
  }

  @override
  Future<AsyncValue<FlightSearchResponse?>> searchForFlights(
      FlightSearchParameters params) async {
    AsyncValue<FlightSearchResponse?> content = const AsyncLoading();

    await _clientService
        ?.get(
      params.buildUrl(),
      rapidApiHeaders,
    )
        .then((value) {
      if (value.isNotEmpty) {
        final response = FlightSearchResponse.fromJson(value);
        content = AsyncData(response);
      }
    }, onError: (e) {
      content = AsyncError(e, StackTrace.current);
    });
    return content;
  }
}
