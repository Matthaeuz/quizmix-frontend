// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleAttribute _$RoleAttributeFromJson(Map<String, dynamic> json) =>
    RoleAttribute(
      id: json['id'] as int,
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
      attribute: Attribute.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoleAttributeToJson(RoleAttribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'attribute': instance.attribute,
    };
