// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_search_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightSearchData _$FlightSearchDataFromJson(Map<String, dynamic> json) =>
    FlightSearchData(
      itineraries: (json['itineraries'] as List<dynamic>)
          .map((e) => Itinerary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
