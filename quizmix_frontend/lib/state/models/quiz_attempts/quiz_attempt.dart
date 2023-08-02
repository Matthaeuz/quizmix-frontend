import 'package:json_annotation/json_annotation.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart';

part 'quiz_attempt.g.dart';

@JsonSerializable()
class QuizAttempt {
  QuizAttempt({
    required this.id,
    required this.attemptedBy,
    required this.quiz,
    required this.createdOn,
    required this.timeStarted,
    this.timeFinished,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'attempted_by')
  final Reviewee attemptedBy;

  @JsonKey(name: 'quiz')
  final Quiz quiz;

  @JsonKey(name: 'created_on')
  final DateTime createdOn;

  @JsonKey(name: 'time_started')
  final DateTime timeStarted;

  @JsonKey(name: 'time_finished')
  DateTime? timeFinished;
  
  /// Base quiz creation; call this if you need to reference an empty quiz.
  QuizAttempt.base()
      : id = 0,
        attemptedBy = Reviewee.base(),
        quiz = Quiz.base(),
        createdOn = DateTime.now(),
        timeStarted = DateTime.now(),
        timeFinished = DateTime.now();

  factory QuizAttempt.fromJson(Map<String, dynamic> json) => _$QuizAttemptFromJson(json);
  Map<String, dynamic> toJson() => _$QuizAttemptToJson(this);
}
