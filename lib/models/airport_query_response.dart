import 'package:fare_air/models/current_airport_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airport_query_response.g.dart';

@JsonSerializable()
class AirportQueryResponse {
  AirportQueryResponse({
    required this.status,
    required this.timestamp,
    this.data = const [],
  });

  final bool status;
  final int timestamp;
  final List<AirportData> data;

  factory AirportQueryResponse.fromJson(Map<String, dynamic> json) =>
      _$AirportQueryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AirportQueryResponseToJson(this);

  static AirportQueryResponse? empty() {
    return AirportQueryResponse(
      status: false,
      timestamp: 0,
      data: [],
    );
  }
}
