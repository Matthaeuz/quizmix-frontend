// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAttempt _$QuizAttemptFromJson(Map<String, dynamic> json) => QuizAttempt(
      id: json['id'] as int,
      attemptedBy: User.fromJson(json['attempted_by'] as Map<String, dynamic>),
      quiz: Quiz.fromJson(json['quiz'] as Map<String, dynamic>),
      createdOn: DateTime.parse(json['created_on'] as String),
      timeStarted: DateTime.parse(json['time_started'] as String),
      timeFinished: json['time_finished'] == null
          ? null
          : DateTime.parse(json['time_finished'] as String),
      attemptScore: json['attempt_score'] as int,
    );

Map<String, dynamic> _$QuizAttemptToJson(QuizAttempt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attempted_by': instance.attemptedBy,
      'quiz': instance.quiz,
      'created_on': instance.createdOn.toIso8601String(),
      'time_started': instance.timeStarted.toIso8601String(),
      'time_finished': instance.timeFinished?.toIso8601String(),
      'attempt_score': instance.attemptScore,
    };
