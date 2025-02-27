// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_data_groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportDataGroups _$AirportDataGroupsFromJson(Map<String, dynamic> json) =>
    AirportDataGroups(
      current: json['current'] == null
          ? null
          : AirportData.fromJson(json['current'] as Map<String, dynamic>),
      nearby: (json['nearby'] as List<dynamic>?)
          ?.map((e) => AirportData.fromJson(e as Map<String, dynamic>))
          .toList(),
      recent: (json['recent'] as List<dynamic>?)
          ?.map((e) => AirportData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AirportDataGroupsToJson(AirportDataGroups instance) =>
    <String, dynamic>{
      'current': instance.current,
      'nearby': instance.nearby,
      'recent': instance.recent,
    };
