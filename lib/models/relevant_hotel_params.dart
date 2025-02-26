import 'package:json_annotation/json_annotation.dart';

part 'relevant_hotel_params.g.dart';

@JsonSerializable()
@JsonValue('relevantHotelParams')
class RelevantHotelParams {
  RelevantHotelParams({
    this.entityId,
    this.entityType,
    this.localizedName,
  });

  String? entityId;
  String? entityType;
  String? localizedName;

  factory RelevantHotelParams.fromJson(Map<String, dynamic> json) =>
      _$RelevantHotelParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RelevantHotelParamsToJson(this);
}
