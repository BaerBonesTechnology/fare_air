import 'package:fare_air/models/current_airport_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airport_data.g.dart';

@JsonSerializable()
@JsonValue('data')
class AirportData {
  AirportData({
    this.current,
    this.nearby,
    this.recent,
  });

  CurrentAirportData? current;
  List<dynamic>? nearby;
  List<dynamic>? recent;

  factory AirportData.fromJson(Map<String, dynamic> json) =>
      _$AirportDataFromJson(json);

  Map<String, dynamic> toJson() => _$AirportDataToJson(this);
}
