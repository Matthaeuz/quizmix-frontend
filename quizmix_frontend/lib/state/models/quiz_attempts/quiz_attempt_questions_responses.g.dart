// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_attempt_questions_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAttemptQuestionsResponses _$QuizAttemptQuestionsResponsesFromJson(
        Map<String, dynamic> json) =>
    QuizAttemptQuestionsResponses(
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      responses:
          (json['responses'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$QuizAttemptQuestionsResponsesToJson(
        QuizAttemptQuestionsResponses instance) =>
    <String, dynamic>{
      'questions': instance.questions,
      'responses': instance.responses,
    };
