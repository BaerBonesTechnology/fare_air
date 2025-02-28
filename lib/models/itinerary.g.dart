// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Itinerary _$ItineraryFromJson(Map<String, dynamic> json) => Itinerary(
      price: json['price'] == null
          ? null
          : Price.fromJson(json['price'] as Map<String, dynamic>),
      legs: (json['legs'] as List<dynamic>?)
              ?.map((e) => Leg.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ItineraryToJson(Itinerary instance) => <String, dynamic>{
      'price': instance.price,
      'legs': instance.legs,
    };
