// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationData _$NavigationDataFromJson(Map<String, dynamic> json) =>
    NavigationData(
      entityId: json['entityId'] as String?,
      entityType: json['entityType'] as String?,
      localizedName: json['localizedName'] as String?,
      relevantFlightParams: json['relevantFlightParams'] == null
          ? null
          : RelevantFlightParams.fromJson(
              json['relevantFlightParams'] as Map<String, dynamic>),
      relevantHotelParams: json['relevantHotelParams'] == null
          ? null
          : RelevantHotelParams.fromJson(
              json['relevantHotelParams'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NavigationDataToJson(NavigationData instance) =>
    <String, dynamic>{
      'entityId': instance.entityId,
      'entityType': instance.entityType,
      'localizedName': instance.localizedName,
      'relevantFlightParams': instance.relevantFlightParams,
      'relevantHotelParams': instance.relevantHotelParams,
    };
