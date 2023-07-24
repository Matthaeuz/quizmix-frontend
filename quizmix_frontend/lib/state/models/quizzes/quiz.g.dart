// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
      id: json['id'] as int,
      madeBy: Reviewer.fromJson(json['made_by'] as Map<String, dynamic>),
      title: json['title'] as String,
      image: json['image'] as String?,
      createdOn: DateTime.parse(json['created_on'] as String),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'id': instance.id,
      'made_by': instance.madeBy,
      'title': instance.title,
      'image': instance.image,
      'created_on': instance.createdOn.toIso8601String(),
      'questions': instance.questions,
    };
