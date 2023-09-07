import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  const Category({
    required this.id,
    required this.name,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  /// Base Category creation; call this if you need to reference an empty Category.
  Category.base()
      : id = 0,
        name = '';

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
