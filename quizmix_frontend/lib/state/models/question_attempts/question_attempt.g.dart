// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionAttempt _$QuestionAttemptFromJson(Map<String, dynamic> json) =>
    QuestionAttempt(
      id: json['id'] as int,
      attempt: QuizAttempt.fromJson(json['attempt'] as Map<String, dynamic>),
      question: Question.fromJson(json['question'] as Map<String, dynamic>),
      revieweeAnswer: json['reviewee_answer'] as String,
      isCorrect: json['is_correct'] as bool,
    );

Map<String, dynamic> _$QuestionAttemptToJson(QuestionAttempt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attempt': instance.attempt,
      'question': instance.question,
      'reviewee_answer': instance.revieweeAnswer,
      'is_correct': instance.isCorrect,
    };
