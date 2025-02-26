// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_airports_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearbyAirportResponse _$NearbyAirportResponseFromJson(
        Map<String, dynamic> json) =>
    NearbyAirportResponse(
      status: json['status'] as bool?,
      timestamp: json['timestamp'] as num?,
      data: json['data'] == null
          ? null
          : AirportData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NearbyAirportResponseToJson(
        NearbyAirportResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'timestamp': instance.timestamp,
      'data': instance.data,
    };
