import 'package:json_annotation/json_annotation.dart';

part 'presentation_data.g.dart';

@JsonSerializable()
@JsonValue('presentation')
class Presentation {
  Presentation({
    this.title,
    this.suggestionTitle,
    this.subtitle,
  });

  String? title;
  String? suggestionTitle;
  String? subtitle;

  factory Presentation.fromJson(Map<String, dynamic> json) =>
      _$PresentationFromJson(json);

  Map<String, dynamic> toJson() => _$PresentationToJson(this);

  static empty() {
    return Presentation(
      title: '',
      suggestionTitle: '',
      subtitle: '',
    );
  }
}
