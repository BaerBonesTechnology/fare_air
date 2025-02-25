import 'package:json_annotation/json_annotation.dart';

part 'calendar_event.g.dart';

@JsonSerializable()
class CalendarEvent {
  final String name;
  final String description;
  final DateTime date;
  final bool completed;

  CalendarEvent({
    required this.name,
    required this.description,
    required this.date,
    required this.completed
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) => _$CalendarEventFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);

  CalendarEvent copyWith({
    String? name,
    String? description,
    DateTime? date,
    bool? completed
  }) {
    return CalendarEvent(
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      completed: completed ?? this.completed
    );
  }
}