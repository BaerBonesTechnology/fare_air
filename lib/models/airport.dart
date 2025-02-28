import 'package:json_annotation/json_annotation.dart';

part 'airport.g.dart';

@JsonSerializable()
class Airport {
  Airport({
    required this.id,
    required this.entityId,
    required this.displayCode,
    required this.city,
    required this.country,
    required this.isHighlighted,
  });

  String id;
  String entityId;
  String displayCode;
  String city;
  String country;
  bool isHighlighted;

  factory Airport.fromJson(Map<String, dynamic> json) =>
      _$AirportFromJson(json);

  Map<String, dynamic> toJson() => _$AirportToJson(this);
}
