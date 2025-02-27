import 'dart:convert';

import 'package:fare_air/constants/defaults.dart';
import 'package:fare_air/constants/environment_constants.dart';
import 'package:fare_air/models/airport_query_response.dart';
import 'package:fare_air/models/airport_search_params.dart';
import 'package:fare_air/models/current_airport_data.dart';
import 'package:fare_air/services/airport_search_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/nearby_airports_response.dart';
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
      if (getCachedAirportResponse() != null && checkCache) {
        if (getCachedAirportResponse()?.data?.current != null) {
          return AsyncData(getCachedAirportResponse());
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
        cacheAirportResponse(nearbyAirports.value);
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

    return AsyncError(Exception('Something went wrong'), StackTrace.current);
  }

  @override
  void cacheAirportResponse(response) async {
    // I want to cache the response
    _sharedPreferences?.setString(
        nearbyAirportKey, jsonEncode(response?.toJson().toString() ?? ''));
  }

  @override
  NearbyAirportResponse? getCachedAirportResponse() {
    // I want to get the cached response
    final response = _sharedPreferences?.getString(nearbyAirportKey);

    if (response != null) {
      return NearbyAirportResponse.fromJson(jsonDecode(response));
    }
    return null;
  }

  @override
  Future<AsyncValue<AirportData?>> getAirportDetails(String id) {
    // TODO: implement getAirportDetails
    throw UnimplementedError();
  }

  @override
  Future<AsyncValue<AirportQueryResponse?>> searchForAirport(String query) {
    // TODO: implement searchForAirport
    throw UnimplementedError();
  }
}
