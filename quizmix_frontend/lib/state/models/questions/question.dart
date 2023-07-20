import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  const Question({
    required this.id,
    required this.question,
    required this.image,
    required this.answer,
    required this.choices,
    required this.category,
    required this.solution,
    required this.parameters,
    required this.responses,
    required this.thetas,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'question')
  final String question;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'answer')
  final String answer;

  @JsonKey(name: 'choices')
  final List<String> choices;

  @JsonKey(name: 'category')
  final String category;

  @JsonKey(name: 'solution')
  final String? solution;

  @JsonKey(name: 'parameters')
  final List<int> parameters;

  @JsonKey(name: 'responses')
  final List<int> responses;

  @JsonKey(name: 'thetas')
  final List<double> thetas;

  /// Base question creation; call this if you need to reference an empty question.
  Question.base()
      : id = 0,
        question = '',
        image = '',
        answer = '',
        choices = [],
        category = '',
        solution = '',
        parameters = [],
        responses = [],
        thetas = [];

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
