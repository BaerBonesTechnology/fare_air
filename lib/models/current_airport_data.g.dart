// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_airport_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportData _$AirportDataFromJson(Map<String, dynamic> json) => AirportData(
      skyId: json['skyId'] as String?,
      entityId: json['entityId'] as String?,
      presentation: json['presentation'] == null
          ? null
          : Presentation.fromJson(json['presentation'] as Map<String, dynamic>),
      navigation: json['navigation'] == null
          ? null
          : NavigationData.fromJson(json['navigation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AirportDataToJson(AirportData instance) =>
    <String, dynamic>{
      'skyId': instance.skyId,
      'entityId': instance.entityId,
      'presentation': instance.presentation,
      'navigation': instance.navigation,
    };
