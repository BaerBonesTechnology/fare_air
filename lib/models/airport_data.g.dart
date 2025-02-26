// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportData _$AirportDataFromJson(Map<String, dynamic> json) => AirportData(
      current: json['current'] == null
          ? null
          : CurrentAirportData.fromJson(
              json['current'] as Map<String, dynamic>),
      nearby: json['nearby'] as List<dynamic>?,
      recent: json['recent'] as List<dynamic>?,
    );

Map<String, dynamic> _$AirportDataToJson(AirportData instance) =>
    <String, dynamic>{
      'current': instance.current,
      'nearby': instance.nearby,
      'recent': instance.recent,
    };
