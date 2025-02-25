// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) => Habit(
      namme: json['namme'] as String,
      description: json['description'] as String,
      streak: (json['streak'] as num).toInt(),
      target: (json['target'] as num).toInt(),
      completed: json['completed'] as bool,
      makeHabit: json['makeHabit'] as bool,
      interval: Duration(microseconds: (json['interval'] as num).toInt()),
    );

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'namme': instance.namme,
      'description': instance.description,
      'streak': instance.streak,
      'target': instance.target,
      'completed': instance.completed,
      'makeHabit': instance.makeHabit,
      'interval': instance.interval.inMicroseconds,
    };
