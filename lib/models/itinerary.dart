import 'package:json_annotation/json_annotation.dart';

import 'leg.dart';
import 'price.dart';

part 'itinerary.g.dart';

@JsonSerializable()
class Itinerary {
  Itinerary({
    required this.price,
    required this.legs,
  });

  Price price;
  List<Leg> legs;

  factory Itinerary.fromJson(Map<String, dynamic> json) =>
      _$ItineraryFromJson(json);

  Map<String, dynamic> toJson() => _$ItineraryToJson(this);
}
