import 'package:json_annotation/json_annotation.dart';
import 'package:quizmix_frontend/state/models/attributes/attribute.dart';
import 'package:quizmix_frontend/state/models/roles/role.dart';

part 'role_attribute.g.dart';

@JsonSerializable()
class RoleAttribute {
  const RoleAttribute({
    required this.id,
    required this.role,
    required this.attribute,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'role')
  final Role role;

  @JsonKey(name: 'attribute')
  final Attribute attribute;

  /// Base RoleAttribute creation; call this if you need to reference an empty RoleAttribute.
  RoleAttribute.base()
      : id = 0,
        role = Role.base(),
        attribute = Attribute.base();

  factory RoleAttribute.fromJson(Map<String, dynamic> json) =>
      _$RoleAttributeFromJson(json);
  Map<String, dynamic> toJson() => _$RoleAttributeToJson(this);
}
