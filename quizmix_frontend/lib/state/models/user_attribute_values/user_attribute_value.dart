import 'package:json_annotation/json_annotation.dart';
import 'package:quizmix_frontend/state/models/role_attributes/role_attribute.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';

part 'user_attribute_value.g.dart';

@JsonSerializable()
class UserAttributeValue {
  const UserAttributeValue({
    required this.id,
    required this.user,
    required this.roleAttribute,
    required this.value,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'user')
  final User user;

  @JsonKey(name: 'role_attribute')
  final RoleAttribute roleAttribute;

  @JsonKey(name: 'value')
  final String value;

  /// Base UserAttributeValue creation; call this if you need to reference an empty UserAttributeValue.
  UserAttributeValue.base()
      : id = 0,
        user = User.base(),
        roleAttribute = RoleAttribute.base(),
        value = '';

  factory UserAttributeValue.fromJson(Map<String, dynamic> json) =>
      _$UserAttributeValueFromJson(json);
  Map<String, dynamic> toJson() => _$UserAttributeValueToJson(this);
}
