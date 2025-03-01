import 'package:json_annotation/json_annotation.dart';

import 'relevant_flight_params.dart';
import 'relevant_hotel_params.dart';

part 'navigation_data.g.dart';

@JsonSerializable()
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

  static empty() {
    return NavigationData(
        entityId: '',
        entityType: '',
        localizedName: '',
        relevantFlightParams: RelevantFlightParams.empty());
  }
}
