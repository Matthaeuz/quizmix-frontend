// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attempt_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttemptScore _$AttemptScoreFromJson(Map<String, dynamic> json) => AttemptScore(
      quizName: json['quiz_title'] as String,
      numQuestions: json['num_questions'] as int,
      score: json['score'] as int,
    );

Map<String, dynamic> _$AttemptScoreToJson(AttemptScore instance) =>
    <String, dynamic>{
      'quiz_title': instance.quizName,
      'num_questions': instance.numQuestions,
      'score': instance.score,
    };
