import 'package:fare_air/models/navigation_data.dart';
import 'package:fare_air/models/presentation_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_airport_data.g.dart';

@JsonSerializable()
@JsonValue('current')
class CurrentAirportData {
  CurrentAirportData({
    this.presentation,
    this.navigation,
  });

  Presentation? presentation;
  NavigationData? navigation;

  factory CurrentAirportData.fromJson(Map<String, dynamic> json) =>
      _$CurrentAirportDataFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentAirportDataToJson(this);
}
