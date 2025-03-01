import 'package:json_annotation/json_annotation.dart';

import 'airport.dart';
import 'carrier.dart';

part 'leg.g.dart';

@JsonSerializable()
class Leg {
  Airport? origin;
  Airport? destination;
  Duration? durationInMinutes;
  int? stopCount;
  DateTime? departure;
  DateTime? arrival;
  Carrier? carriers;
  List<Leg>? segments;

  Leg({
    this.origin,
    this.destination,
    this.durationInMinutes,
    this.stopCount,
    this.departure,
    this.arrival,
    this.carriers,
    this.segments = const [],
  });

  factory Leg.fromJson(Map<String, dynamic> json) => _$LegFromJson(json);

  Map<String, dynamic> toJson() => _$LegToJson(this);
}
