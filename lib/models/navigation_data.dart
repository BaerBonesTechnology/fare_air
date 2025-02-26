import 'package:fare_air/models/relevant_flight_params.dart';
import 'package:fare_air/models/relevant_hotel_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'navigation_data.g.dart';

@JsonSerializable()
@JsonValue('navigation')
class NavigationData {
  NavigationData({
    this.entityId,
    this.entityType,
    this.localizedName,
    this.relevantFlightParams,
    this.relevantHotelParams,
  });

  String? entityId;
  String? entityType;
  String? localizedName;
  RelevantFlightParams? relevantFlightParams;
  RelevantHotelParams? relevantHotelParams;

  factory NavigationData.fromJson(Map<String, dynamic> json) =>
      _$NavigationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NavigationDataToJson(this);
}
