import 'package:json_annotation/json_annotation.dart';

part 'question_details.g.dart';

@JsonSerializable()
class QuestionDetails {
  const QuestionDetails({
    required this.attempt,
    required this.question,
    required this.revieweeAnswer,
  });

  @JsonKey(name: 'attempt')
  final int attempt;

  @JsonKey(name: 'question')
  final int question;

  @JsonKey(name: 'reviewee_answer')
  final String revieweeAnswer;

  /// Base quiz creation; call this if you need to reference an empty quiz.
  QuestionDetails.base()
      : attempt = 0,
        question = 0,
        revieweeAnswer = '';

  factory QuestionDetails.fromJson(Map<String, dynamic> json) =>
      _$QuestionDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionDetailsToJson(this);
}
