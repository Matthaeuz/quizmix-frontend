import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable()
class Role {
  const Role({
    required this.id,
    required this.name,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  /// Base Role creation; call this if you need to reference an empty Role.
  Role.base()
      : id = 0,
        name = '';

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
