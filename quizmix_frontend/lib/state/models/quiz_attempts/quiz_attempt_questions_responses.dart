import 'package:json_annotation/json_annotation.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';

part 'quiz_attempt_questions_responses.g.dart';

@JsonSerializable()
class QuizAttemptQuestionsResponses {
  QuizAttemptQuestionsResponses({
    required this.questions,
    required this.responses,
  });

  @JsonKey(name: 'questions')
  final List<Question> questions;

  @JsonKey(name: 'responses')
  final List<String> responses;

  /// Base quiz creation; call this if you need to reference an empty quiz.
  QuizAttemptQuestionsResponses.base()
      : questions = [],
        responses = [];

  factory QuizAttemptQuestionsResponses.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptQuestionsResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$QuizAttemptQuestionsResponsesToJson(this);
}
