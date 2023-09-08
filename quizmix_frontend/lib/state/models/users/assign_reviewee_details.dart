import 'package:json_annotation/json_annotation.dart';

part 'assign_reviewee_details.g.dart';

@JsonSerializable()
class AssignRevieweeDetails {
  AssignRevieweeDetails({
    required this.revieweeId,
    required this.reviewerId,
  });

  @JsonKey(name: 'reviewee_id')
  final int revieweeId;

  @JsonKey(name: 'reviewer_id')
  final int reviewerId;

  factory AssignRevieweeDetails.fromJson(Map<String, dynamic> json) =>
      _$AssignRevieweeDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$AssignRevieweeDetailsToJson(this);
}
