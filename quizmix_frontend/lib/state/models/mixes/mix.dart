import 'package:json_annotation/json_annotation.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';

part 'mix.g.dart';

@JsonSerializable()
class Mix {
  const Mix({
    required this.id,
    required this.title,
    required this.image,
    required this.madeBy,
    required this.createdOn,
    required this.questions,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'made_by')
  final User madeBy;

  @JsonKey(name: 'created_on')
  final DateTime createdOn;

  @JsonKey(name: 'questions')
  final List<Question> questions;

  /// Base question creation; call this if you need to reference an empty question.
  Mix.base()
      : id = 0,
        title = '',
        image = '',
        madeBy = User.base(),
        createdOn = DateTime.now(),
        questions = [];

  factory Mix.fromJson(Map<String, dynamic> json) => _$MixFromJson(json);
  Map<String, dynamic> toJson() => _$MixToJson(this);
}
