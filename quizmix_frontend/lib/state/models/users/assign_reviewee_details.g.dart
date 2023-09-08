// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_reviewee_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignRevieweeDetails _$AssignRevieweeDetailsFromJson(
        Map<String, dynamic> json) =>
    AssignRevieweeDetails(
      revieweeId: json['reviewee_id'] as int,
      reviewerId: json['reviewer_id'] as int,
    );

Map<String, dynamic> _$AssignRevieweeDetailsToJson(
        AssignRevieweeDetails instance) =>
    <String, dynamic>{
      'reviewee_id': instance.revieweeId,
      'reviewer_id': instance.reviewerId,
    };
