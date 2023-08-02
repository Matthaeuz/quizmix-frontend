// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionDetails _$QuestionDetailsFromJson(Map<String, dynamic> json) =>
    QuestionDetails(
      attempt: json['attempt'] as int,
      question: json['question'] as int,
      revieweeAnswer: json['reviewee_answer'] as String,
      difficultyScore: json['difficulty_score'] as int,
    );

Map<String, dynamic> _$QuestionDetailsToJson(QuestionDetails instance) =>
    <String, dynamic>{
      'attempt': instance.attempt,
      'question': instance.question,
      'reviewee_answer': instance.revieweeAnswer,
      'difficulty_score': instance.difficultyScore,
    };
