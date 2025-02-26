import 'package:json_annotation/json_annotation.dart';

import 'airport_data.dart';

part 'nearby_airports_response.g.dart';

@JsonSerializable()
class NearbyAirportResponse {
  NearbyAirportResponse({
    this.status,
    this.timestamp,
    this.data,
  });

  bool? status;
  num? timestamp;
  AirportData? data;

  factory NearbyAirportResponse.fromJson(Map<String, dynamic> json) =>
      _$NearbyAirportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyAirportResponseToJson(this);

  factory NearbyAirportResponse.empty() {
    return NearbyAirportResponse(
        status: false,
        timestamp: 0,
        data: AirportData(current: null, nearby: [], recent: []));
  }
}
