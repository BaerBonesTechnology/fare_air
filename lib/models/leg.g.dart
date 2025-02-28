// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leg _$LegFromJson(Map<String, dynamic> json) => Leg(
      origin: Airport.fromJson(json['origin'] as Map<String, dynamic>),
      destination:
          Airport.fromJson(json['destination'] as Map<String, dynamic>),
      durationInMinutes:
          Duration(microseconds: (json['durationInMinutes'] as num).toInt()),
      stopCount: (json['stopCount'] as num).toInt(),
      departureTime: DateTime.parse(json['departureTime'] as String),
      arrivalTime: DateTime.parse(json['arrivalTime'] as String),
    );

Map<String, dynamic> _$LegToJson(Leg instance) => <String, dynamic>{
      'origin': instance.origin,
      'destination': instance.destination,
      'durationInMinutes': instance.durationInMinutes.inMicroseconds,
      'stopCount': instance.stopCount,
      'departureTime': instance.departureTime.toIso8601String(),
      'arrivalTime': instance.arrivalTime.toIso8601String(),
    };
