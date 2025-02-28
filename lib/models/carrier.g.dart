// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carrier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Carrier _$CarrierFromJson(Map<String, dynamic> json) => Carrier(
      name: json['name'] as String?,
      marketing: (json['marketing'] as List<dynamic>?)
              ?.map((e) => Marketing.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CarrierToJson(Carrier instance) => <String, dynamic>{
      'name': instance.name,
      'marketing': instance.marketing,
    };
