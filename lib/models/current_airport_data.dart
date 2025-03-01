import 'package:json_annotation/json_annotation.dart';

import 'navigation_data.dart';
import 'presentation_data.dart';

part 'current_airport_data.g.dart';

@JsonSerializable()
class AirportData {
  AirportData({
    this.skyId,
    this.entityId,
    this.presentation,
    this.navigation,
  });

  String? skyId;
  String? entityId;
  Presentation? presentation;
  NavigationData? navigation;

  factory AirportData.fromJson(Map<String, dynamic> json) =>
      _$AirportDataFromJson(json);

  Map<String, dynamic> toJson() => _$AirportDataToJson(this);

  static AirportData? empty() {
    return AirportData(
      skyId: '',
      entityId: '',
      presentation: Presentation.empty(),
      navigation: NavigationData.empty(),
    );
  }
}
