// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_month.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarMonth _$CalendarMonthFromJson(Map<String, dynamic> json) =>
    CalendarMonth(
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      days: (json['days'] as List<dynamic>)
          .map((e) => CalendarWeek.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CalendarMonthToJson(CalendarMonth instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
      'days': instance.days,
    };
