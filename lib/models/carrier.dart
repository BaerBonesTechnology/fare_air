import 'package:json_annotation/json_annotation.dart';

import 'marketing.dart';

part 'carrier.g.dart';

@JsonSerializable()
class Carrier {
  Carrier({
    this.name,
    this.marketing = const [],
  });

  final String? name;
  final List<Marketing> marketing;

  factory Carrier.fromJson(Map<String, dynamic> json) =>
      _$CarrierFromJson(json);

  Map<String, dynamic> toJson() => _$CarrierToJson(this);
}
