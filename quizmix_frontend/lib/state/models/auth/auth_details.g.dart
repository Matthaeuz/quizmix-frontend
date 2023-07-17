// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthDetails _$AuthDetailsFromJson(Map<String, dynamic> json) => AuthDetails(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthDetailsToJson(AuthDetails instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
