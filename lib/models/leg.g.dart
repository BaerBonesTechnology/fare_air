// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leg _$LegFromJson(Map<String, dynamic> json) => Leg(
      origin: json['origin'] == null
          ? null
          : Airport.fromJson(json['origin'] as Map<String, dynamic>),
      destination: json['destination'] == null
          ? null
          : Airport.fromJson(json['destination'] as Map<String, dynamic>),
      durationInMinutes: json['durationInMinutes'] == null
          ? null
          : Duration(microseconds: (json['durationInMinutes'] as num).toInt()),
      stopCount: (json['stopCount'] as num?)?.toInt(),
      departure: json['departure'] == null
          ? null
          : DateTime.parse(json['departure'] as String),
      arrival: json['arrival'] == null
          ? null
          : DateTime.parse(json['arrival'] as String),
      carriers: json['carriers'] == null
          ? null
          : Carrier.fromJson(json['carriers'] as Map<String, dynamic>),
      segments: (json['segments'] as List<dynamic>?)
              ?.map((e) => Leg.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LegToJson(Leg instance) => <String, dynamic>{
      'origin': instance.origin,
      'destination': instance.destination,
      'durationInMinutes': instance.durationInMinutes?.inMicroseconds,
      'stopCount': instance.stopCount,
      'departure': instance.departure?.toIso8601String(),
      'arrival': instance.arrival?.toIso8601String(),
      'carriers': instance.carriers,
      'segments': instance.segments,
    };
