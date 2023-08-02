import 'package:json_annotation/json_annotation.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';

part 'question_attempt.g.dart';

@JsonSerializable()
class QuestionAttempt {
  QuestionAttempt({
    required this.id,
    required this.attempt,
    required this.question,
    required this.revieweeAnswer,
    required this.difficultyScore,
    required this.isCorrect,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'attempt')
  final QuizAttempt attempt;

  @JsonKey(name: 'question')
  final Question question;

  @JsonKey(name: 'reviewee_answer')
  final String revieweeAnswer;

  @JsonKey(name: 'difficulty_score')
  final int difficultyScore;

  @JsonKey(name: 'is_correct')
  final bool isCorrect;
  
  /// Base quiz creation; call this if you need to reference an empty quiz.
  QuestionAttempt.base()
      : id = 0,
        attempt = QuizAttempt.base(),
        question = Question.base(),
        revieweeAnswer = '',
        difficultyScore = 0,
        isCorrect = false;

  factory QuestionAttempt.fromJson(Map<String, dynamic> json) => _$QuestionAttemptFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionAttemptToJson(this);
}
