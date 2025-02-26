// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presentation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Presentation _$PresentationFromJson(Map<String, dynamic> json) => Presentation(
      title: json['title'] as String?,
      suggestionTitle: json['suggestionTitle'] as String?,
      subtitle: json['subtitle'] as String?,
    );

Map<String, dynamic> _$PresentationToJson(Presentation instance) =>
    <String, dynamic>{
      'title': instance.title,
      'suggestionTitle': instance.suggestionTitle,
      'subtitle': instance.subtitle,
    };
