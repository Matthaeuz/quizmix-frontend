// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mix.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mix _$MixFromJson(Map<String, dynamic> json) => Mix(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String?,
      madeBy: Reviewee.fromJson(json['made_by'] as Map<String, dynamic>),
      createdOn: DateTime.parse(json['created_on'] as String),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MixToJson(Mix instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'made_by': instance.madeBy,
      'created_on': instance.createdOn.toIso8601String(),
      'questions': instance.questions,
    };
