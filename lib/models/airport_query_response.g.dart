// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_query_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportQueryResponse _$AirportQueryResponseFromJson(
        Map<String, dynamic> json) =>
    AirportQueryResponse(
      status: json['status'] as bool,
      timestamp: (json['timestamp'] as num).toInt(),
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => AirportData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AirportQueryResponseToJson(
        AirportQueryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'timestamp': instance.timestamp,
      'data': instance.data,
    };
