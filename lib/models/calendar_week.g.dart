// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_week.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarWeek _$CalendarWeekFromJson(Map<String, dynamic> json) => CalendarWeek(
      weekNumber: (json['weekNumber'] as num).toInt(),
      days: (json['days'] as List<dynamic>)
          .map((e) => CalendarDate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CalendarWeekToJson(CalendarWeek instance) =>
    <String, dynamic>{
      'weekNumber': instance.weekNumber,
      'days': instance.days,
    };
