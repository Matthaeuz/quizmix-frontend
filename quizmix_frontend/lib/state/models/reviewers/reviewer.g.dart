// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reviewer _$ReviewerFromJson(Map<String, dynamic> json) => Reviewer(
      id: json['id'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewerToJson(Reviewer instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
    };
