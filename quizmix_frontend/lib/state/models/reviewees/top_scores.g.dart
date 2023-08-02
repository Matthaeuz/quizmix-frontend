// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_scores.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopScores _$TopScoresFromJson(Map<String, dynamic> json) => TopScores(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      scores: (json['scores'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$TopScoresToJson(TopScores instance) => <String, dynamic>{
      'categories': instance.categories,
      'scores': instance.scores,
    };
