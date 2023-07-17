import 'package:json_annotation/json_annotation.dart';

part 'reviewee.g.dart';

@JsonSerializable()
class Reviewee {
  const Reviewee({
    required this.id,
    required this.user,
    this.belongsTo,
    required this.categoryScores,
  });

  final int id;
  final int user;
  final int? belongsTo;
  final List<int> categoryScores;

  /// Base reviewee creation; call this if you need to reference an empty reviewee.
  Reviewee.base()
      : id = 0,
        user = 0,
        belongsTo = 0,
        categoryScores = [];

  factory Reviewee.fromJson(Map<String, dynamic> json) => _$RevieweeFromJson(json);
  Map<String, dynamic> toJson() => _$RevieweeToJson(this);
}