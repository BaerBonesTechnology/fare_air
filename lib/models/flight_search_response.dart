import 'package:json_annotation/json_annotation.dart';

import 'flight_search_data.dart';

part 'flight_search_response.g.dart';

@JsonSerializable()
class FlightSearchResponse {
  FlightSearchResponse({
    required this.status,
    required this.timestamp,
    required this.data,
  });

  bool status;
  int timestamp;
  FlightSearchData data;

  factory FlightSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$FlightSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FlightSearchResponseToJson(this);
}
