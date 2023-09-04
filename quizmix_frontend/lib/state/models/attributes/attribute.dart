import 'package:json_annotation/json_annotation.dart';

part 'attribute.g.dart';

@JsonSerializable()
class Attribute {
  const Attribute({
    required this.id,
    required this.name,
    required this.dataType,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'data_type')
  final String dataType;

  /// Base Attribute creation; call this if you need to reference an empty Attribute.
  Attribute.base()
      : id = 0,
        name = '',
        dataType = '';

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);
  Map<String, dynamic> toJson() => _$AttributeToJson(this);
}
