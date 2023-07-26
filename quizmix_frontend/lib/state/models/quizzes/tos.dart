import 'package:json_annotation/json_annotation.dart';

part 'tos.g.dart';

@JsonSerializable()
class TOS {
  const TOS({
    required this.madeBy,
    required this.title,
    required this.categories,
    required this.quantities,
    required this.difficulties,
  });

  @JsonKey(name: 'made_by')
  final int madeBy;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'categories')
  final List<String> categories;
  
  @JsonKey(name: 'quantities')
  final List<int> quantities;

  @JsonKey(name: 'difficulties')
  final List<int> difficulties;

  factory TOS.fromJson(Map<String, dynamic> json) => _$TOSFromJson(json);
  Map<String, dynamic> toJson() => _$TOSToJson(this);
}