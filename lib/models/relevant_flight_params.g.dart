// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relevant_flight_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelevantFlightParams _$RelevantFlightParamsFromJson(
        Map<String, dynamic> json) =>
    RelevantFlightParams(
      skyId: json['skyId'] as String?,
      entityId: json['entityId'] as String?,
      flightPlaceType: json['flightPlaceType'] as String?,
      localizedName: json['localizedName'] as String?,
    );

Map<String, dynamic> _$RelevantFlightParamsToJson(
        RelevantFlightParams instance) =>
    <String, dynamic>{
      'skyId': instance.skyId,
      'entityId': instance.entityId,
      'flightPlaceType': instance.flightPlaceType,
      'localizedName': instance.localizedName,
    };
