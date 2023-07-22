import 'package:json_annotation/json_annotation.dart';
import 'package:quizmix_frontend/state/models/reviewers/reviewer.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';

part 'reviewee.g.dart';

@JsonSerializable()
class Reviewee {
  const Reviewee({
    required this.id,
    required this.user,
    this.belongsTo,
    required this.categoryScores,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'user')
  final User user;

  @JsonKey(name: 'belongs_to')
  final Reviewer? belongsTo;

  @JsonKey(name: 'category_scores')
  final List<double> categoryScores;

  /// Base reviewee creation; call this if you need to reference an empty reviewee.
  Reviewee.base()
      : id = 0,
        user = User.base(),
        belongsTo = Reviewer.base(),
        categoryScores = [];

  factory Reviewee.fromJson(Map<String, dynamic> json) => _$RevieweeFromJson(json);
  Map<String, dynamic> toJson() => _$RevieweeToJson(this);
}