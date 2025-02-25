// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarDate _$CalendarDateFromJson(Map<String, dynamic> json) => CalendarDate(
      date: DateTime.parse(json['date'] as String),
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CalendarDateToJson(CalendarDate instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'events': instance.events,
    };
