import 'package:json_annotation/json_annotation.dart';

part 'top_scores.g.dart';

@JsonSerializable()
class TopScores {
  const TopScores({
    required this.categories,
    required this.scores,
  });

  @JsonKey(name: 'categories')
  final List<String> categories;

  @JsonKey(name: 'scores')
  final List<double> scores;

  /// Base topscores creation; call this if you need to reference an empty topscores.
  TopScores.base()
      : categories = [],
        scores = [];

  factory TopScores.fromJson(Map<String, dynamic> json) =>
      _$TopScoresFromJson(json);
  Map<String, dynamic> toJson() => _$TopScoresToJson(this);
}
