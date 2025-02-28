import 'package:json_annotation/json_annotation.dart';

part 'marketing.g.dart';

@JsonSerializable()
class Marketing {
  Marketing({
    this.logoUrl,
    this.name,
  });

  String? name;
  String? logoUrl;

  factory Marketing.fromJson(Map<String, dynamic> json) =>
      _$MarketingFromJson(json);

  Map<String, dynamic> toJson() => _$MarketingToJson(this);
}
