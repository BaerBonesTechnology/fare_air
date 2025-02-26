// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_airport_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentAirportData _$CurrentAirportDataFromJson(Map<String, dynamic> json) =>
    CurrentAirportData(
      presentation: json['presentation'] == null
          ? null
          : Presentation.fromJson(json['presentation'] as Map<String, dynamic>),
      navigation: json['navigation'] == null
          ? null
          : NavigationData.fromJson(json['navigation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrentAirportDataToJson(CurrentAirportData instance) =>
    <String, dynamic>{
      'presentation': instance.presentation,
      'navigation': instance.navigation,
    };
