import 'package:json_annotation/json_annotation.dart';

part 'habit.g.dart';

@JsonSerializable()
class Habit {
  final String namme;
  final String description;
  final int streak;
  final int target;
  final bool completed;
  final bool makeHabit;
  final Duration interval;

  Habit({
    required this.namme,
    required this.description,
    required this.streak,
    required this.target,
    required this.completed,
    required this.makeHabit,
    required this.interval
  });

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);

  Habit copyWith({
    String? namme,
    String? description,
    int? streak,
    int? target,
    bool? completed,
    bool? makeHabit,
    Duration? interval
  }) {
    return Habit(
      namme: namme ?? this.namme,
      description: description ?? this.description,
      streak: streak ?? this.streak,
      target: target ?? this.target,
      completed: completed ?? this.completed,
      makeHabit: makeHabit ?? this.makeHabit,
      interval: interval ?? this.interval
    );
  }
}