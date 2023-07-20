// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as int,
      question: json['question'] as String,
      image: json['image'] as String?,
      answer: json['answer'] as String,
      choices:
          (json['choices'] as List<dynamic>).map((e) => e as String).toList(),
      category: json['category'] as String,
      solution: json['solution'] as String?,
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      responses:
          (json['responses'] as List<dynamic>).map((e) => e as int).toList(),
      thetas: (json['thetas'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'image': instance.image,
      'answer': instance.answer,
      'choices': instance.choices,
      'category': instance.category,
      'solution': instance.solution,
      'parameters': instance.parameters,
      'responses': instance.responses,
      'thetas': instance.thetas,
    };
