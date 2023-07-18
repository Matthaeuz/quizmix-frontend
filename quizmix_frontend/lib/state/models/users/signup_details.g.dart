// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpDetails _$SignUpDetailsFromJson(Map<String, dynamic> json) =>
    SignUpDetails(
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      middleName: json['middle_name'] as String?,
      lastName: json['last_name'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignUpDetailsToJson(SignUpDetails instance) =>
    <String, dynamic>{
      'email': instance.email,
      'first_name': instance.firstName,
      'middle_name': instance.middleName,
      'last_name': instance.lastName,
      'password': instance.password,
    };
