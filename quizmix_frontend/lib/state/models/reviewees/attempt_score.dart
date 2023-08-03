import 'package:json_annotation/json_annotation.dart';

part 'attempt_score.g.dart';

@JsonSerializable()
class AttemptScore {
  const AttemptScore({
    required this.quizName,
    required this.numQuestions,
    required this.score,
  });

  @JsonKey(name: 'quiz_title')
  final String quizName;

  @JsonKey(name: 'num_questions')
  final int numQuestions;

  @JsonKey(name: 'score')
  final int score;

  /// Base reviewee creation; call this if you need to reference an empty reviewee.
  AttemptScore.base()
      : quizName = "",
        numQuestions = 0,
        score = 0;

  factory AttemptScore.fromJson(Map<String, dynamic> json) =>
      _$AttemptScoreFromJson(json);
  Map<String, dynamic> toJson() => _$AttemptScoreToJson(this);
}
