import 'package:json_annotation/json_annotation.dart';

part 'relevant_flight_params.g.dart';

@JsonSerializable()
@JsonValue('relevantFlightParams')
class RelevantFlightParams {
  RelevantFlightParams({
    this.skyId,
    this.entityId,
    this.flightPlaceType,
    this.localizedName,
  });

  String? skyId;
  String? entityId;
  String? flightPlaceType;
  String? localizedName;

  factory RelevantFlightParams.fromJson(Map<String, dynamic> json) =>
      _$RelevantFlightParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RelevantFlightParamsToJson(this);

  static empty() {
    return RelevantFlightParams(
      skyId: '',
      entityId: '',
      flightPlaceType: '',
      localizedName: '',
    );
  }
}
