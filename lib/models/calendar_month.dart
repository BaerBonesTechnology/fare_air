import 'package:json_annotation/json_annotation.dart';

import 'calendar_week.dart';

part 'calendar_month.g.dart';

@JsonSerializable()
class CalendarMonth {
  final int month;
  final int year;
  final List<CalendarWeek> days;

  CalendarMonth({
    required this.month,
    required this.year,
    required this.days,
  });

  factory CalendarMonth.fromJson(Map<String, dynamic> json) =>
      _$CalendarMonthFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarMonthToJson(this);
}
