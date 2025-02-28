// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Airport _$AirportFromJson(Map<String, dynamic> json) => Airport(
      id: json['id'] as String?,
      entityId: json['entityId'] as String?,
      displayCode: json['displayCode'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      isHighlighted: json['isHighlighted'] as bool?,
    );

Map<String, dynamic> _$AirportToJson(Airport instance) => <String, dynamic>{
      'id': instance.id,
      'entityId': instance.entityId,
      'displayCode': instance.displayCode,
      'city': instance.city,
      'country': instance.country,
      'isHighlighted': instance.isHighlighted,
    };
