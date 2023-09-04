// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_attribute_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAttributeValue _$UserAttributeValueFromJson(Map<String, dynamic> json) =>
    UserAttributeValue(
      id: json['id'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      roleAttribute: RoleAttribute.fromJson(
          json['role_attribute'] as Map<String, dynamic>),
      value: json['value'] as String,
    );

Map<String, dynamic> _$UserAttributeValueToJson(UserAttributeValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'role_attribute': instance.roleAttribute,
      'value': instance.value,
    };
