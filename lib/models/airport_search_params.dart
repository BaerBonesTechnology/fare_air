import 'dart:ui';

import 'package:fare_air/constants/endpoints.dart';

class AirportSearchParams {
  double latitude;
  double longitude;
  static Locale locale = const Locale('en-US');

  AirportSearchParams(
      {required this.latitude,
      required this.longitude,
      locale = const Locale('en-US')});

  String buildUrl() {
    return getNearbyAirportsUrl
        .replaceAll('{lat}', latitude.toString())
        .replaceAll('{lon}', longitude.toString())
        .replaceAll('{locale}', locale.languageCode);
  }

  static String buildQueryUrl(String query) {
    return getAirportByQueryUrl
        .replaceAll('{query}', query)
        .replaceAll('{locale}', locale.languageCode);
  }
}
