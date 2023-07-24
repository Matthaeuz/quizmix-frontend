import 'package:json_annotation/json_annotation.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/models/reviewers/reviewer.dart';

part 'quiz.g.dart';

@JsonSerializable()
class Quiz {
  const Quiz({
    required this.id,
    required this.madeBy,
    required this.title,
    this.image,
    required this.createdOn,
    required this.questions,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'made_by')
  final Reviewer madeBy;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'created_on')
  final DateTime createdOn;

  @JsonKey(name: 'questions')
  final List<Question> questions;
  
  /// Base quiz creation; call this if you need to reference an empty quiz.
  Quiz.base()
      : id = 0,
        madeBy = Reviewer.base(),
        title = '',
        image = '',
        createdOn = DateTime.now(),
        questions = [];

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}
