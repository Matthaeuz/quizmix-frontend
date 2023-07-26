// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TOS _$TOSFromJson(Map<String, dynamic> json) => TOS(
      madeBy: json['made_by'] as int,
      title: json['title'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      quantities:
          (json['quantities'] as List<dynamic>).map((e) => e as int).toList(),
      difficulties:
          (json['difficulties'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$TOSToJson(TOS instance) => <String, dynamic>{
      'made_by': instance.madeBy,
      'title': instance.title,
      'categories': instance.categories,
      'quantities': instance.quantities,
      'difficulties': instance.difficulties,
    };
