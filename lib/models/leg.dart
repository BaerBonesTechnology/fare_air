import 'package:json_annotation/json_annotation.dart';

import 'airport.dart';

part 'leg.g.dart';

@JsonSerializable()
class Leg {
  Airport origin;
  Airport destination;
  Duration durationInMinutes;
  int stopCount;
  DateTime departureTime;
  DateTime arrivalTime;

  Leg(
      {required this.origin,
      required this.destination,
      required this.durationInMinutes,
      required this.stopCount,
      required this.departureTime,
      required this.arrivalTime});

  factory Leg.fromJson(Map<String, dynamic> json) => _$LegFromJson(json);

  Map<String, dynamic> toJson() => _$LegToJson(this);
}
