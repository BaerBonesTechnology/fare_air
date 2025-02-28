// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightSearchResponse _$FlightSearchResponseFromJson(
        Map<String, dynamic> json) =>
    FlightSearchResponse(
      status: json['status'] as bool,
      timestamp: (json['timestamp'] as num).toInt(),
      data: FlightSearchData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FlightSearchResponseToJson(
        FlightSearchResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'timestamp': instance.timestamp,
      'data': instance.data,
    };
