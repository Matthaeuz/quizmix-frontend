// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reviewee _$RevieweeFromJson(Map<String, dynamic> json) => Reviewee(
      id: json['id'] as int,
      user: json['user'] as int,
      belongsTo: json['belongsTo'] as int?,
      categoryScores: (json['categoryScores'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$RevieweeToJson(Reviewee instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'belongsTo': instance.belongsTo,
      'categoryScores': instance.categoryScores,
    };
