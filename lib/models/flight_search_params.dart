import 'dart:ui';

import 'package:intl/intl.dart';

import '../constants/endpoints.dart';

class FlightSearchParameters {
  final String originSkyId;
  final String destinationSkyId;
  final String originEntityId;
  final String destinationEntityId;
  final DateTime departureDate;
  final DateTime? returnDate;
  final String? cabinClass;
  final int adultsCount;
  final int? childrenCount;
  final int? infantsCount;
  final int? limit;
  final String? carriersIds;
  final String? sortBy;
  final Locale? market;
  final String? countryCode;

  FlightSearchParameters({
    required this.originSkyId,
    required this.destinationSkyId,
    required this.originEntityId,
    required this.destinationEntityId,
    required this.departureDate,
    this.returnDate,
    this.cabinClass,
    this.adultsCount = 1,
    this.childrenCount,
    this.infantsCount,
    this.limit,
    this.carriersIds,
    this.sortBy,
    this.market = const Locale('en-US'),
    this.countryCode = 'US',
  });

  // Method to build the URL string
  String buildUrl() {
    final dateFormatter = DateFormat('yyyy-MM-dd');

    String url = getFlightSearchUrl
        .replaceFirst('{originSkyId}', originSkyId)
        .replaceFirst('{destinationSkyId}', destinationSkyId)
        .replaceFirst('{originEntityId}', originEntityId)
        .replaceFirst('{destinationEntityId}', destinationEntityId)
        .replaceFirst('{date}', dateFormatter.format(departureDate));

    if (returnDate != null) {
      // Makes no sense to add a default value within a null check
      url += '&returnDate=${dateFormatter.format(returnDate!)}';
    }
    if (cabinClass != null) {
      url += '&cabinClass=$cabinClass';
    }
    url += '&adultsCount=$adultsCount';
    if (childrenCount != null) {
      url += '&childrenCount=$childrenCount';
    }
    if (infantsCount != null) {
      url += '&infantsCount=$infantsCount';
    }
    if (limit != null) {
      url += '&limit=$limit';
    }
    if (carriersIds != null) {
      url += '&carriersIds=$carriersIds';
    }
    if (sortBy != null) {
      url += '&sortBy=$sortBy';
    }
    if (market != null) {
      url += '&market=$market';
    }
    url += '&countryCode=$countryCode';
    url += '&market=${market?.languageCode}';

    return url;
  }
}
