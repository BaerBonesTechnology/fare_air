import 'package:json_annotation/json_annotation.dart';

part 'airport.g.dart';

@JsonSerializable()
class Airport {
  Airport({
    this.id,
    this.entityId,
    this.displayCode,
    this.city,
    this.country,
    this.isHighlighted,
  });

  String? id;
  String? entityId;
  String? displayCode;
  String? city;
  String? country;
  bool? isHighlighted;

  factory Airport.fromJson(Map<String, dynamic> json) =>
      _$AirportFromJson(json);

  Map<String, dynamic> toJson() => _$AirportToJson(this);
}
