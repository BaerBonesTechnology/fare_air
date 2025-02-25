import 'package:json_annotation/json_annotation.dart';

import 'calendar_event.dart';

part 'calendar_date.g.dart';

@JsonSerializable()
class CalendarDate {
  final DateTime date;
  final List<CalendarEvent> events;

  CalendarDate({
    required this.date,
    this.events = const [],
  });

  factory CalendarDate.fromJson(Map<String, dynamic> json) =>
      _$CalendarDateFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarDateToJson(this);

  CalendarDate copyWith({
    DateTime? date,
    List<CalendarEvent>? events,
  }) {
    return CalendarDate(
      date: date ?? this.date,
      events: events ?? this.events,
    );
  }
}
