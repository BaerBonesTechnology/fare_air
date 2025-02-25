import 'package:json_annotation/json_annotation.dart';

import 'calendar_date.dart';

part 'calendar_week.g.dart';

@JsonSerializable()
class CalendarWeek {
  final int weekNumber;
  final List<CalendarDate> days;

  CalendarWeek({
    required this.weekNumber,
    required this.days,
  });

  factory CalendarWeek.fromJson(Map<String, dynamic> json) => _$CalendarWeekFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarWeekToJson(this);

  CalendarWeek copyWith({
    int? weekNumber,
    List<CalendarDate>? days,
  }) {
    return CalendarWeek(
      weekNumber: weekNumber ?? this.weekNumber,
      days: days ?? this.days,
    );
  }
}