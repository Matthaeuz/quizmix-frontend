// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reviewee _$RevieweeFromJson(Map<String, dynamic> json) => Reviewee(
      id: json['id'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      belongsTo: json['belongs_to'] == null
          ? null
          : Reviewer.fromJson(json['belongs_to'] as Map<String, dynamic>),
      categoryScores: (json['category_scores'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$RevieweeToJson(Reviewee instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'belongs_to': instance.belongsTo,
      'category_scores': instance.categoryScores,
    };
