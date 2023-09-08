import 'package:json_annotation/json_annotation.dart';

part 'reviewee_quizzes_details.g.dart';

@JsonSerializable()
class RevieweeQuizzesDetails {
  RevieweeQuizzesDetails({
    required this.revieweeId,
  });

  @JsonKey(name: 'reviewee_id')
  final int revieweeId;

  factory RevieweeQuizzesDetails.fromJson(Map<String, dynamic> json) =>
      _$RevieweeQuizzesDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$RevieweeQuizzesDetailsToJson(this);
}
