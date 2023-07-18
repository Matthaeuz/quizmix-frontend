// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reviewee _$RevieweeFromJson(Map<String, dynamic> json) => Reviewee(
      id: json['id'] as int,
      user: json['user'] as int,
      belongsTo: json['belongs_to'] as int?,
      categoryScores: (json['category_scores'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$RevieweeToJson(Reviewee instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'belongs_to': instance.belongsTo,
      'category_scores': instance.categoryScores,
    };
