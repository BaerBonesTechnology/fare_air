import 'package:json_annotation/json_annotation.dart';

import 'current_airport_data.dart';

part 'airport_data_groups.g.dart';

@JsonSerializable()
class AirportDataGroups {
  AirportDataGroups({
    this.current,
    this.nearby,
    this.recent,
  });

  AirportData? current;
  List<AirportData>? nearby;
  List<AirportData>? recent;

  factory AirportDataGroups.fromJson(Map<String, dynamic> json) =>
      _$AirportDataGroupsFromJson(json);

  Map<String, dynamic> toJson() => _$AirportDataGroupsToJson(this);

  @override
  String toString() {
    return {
      'current': current,
      'nearby': nearby,
      'recent': recent,
    }.toString();
  }
}
