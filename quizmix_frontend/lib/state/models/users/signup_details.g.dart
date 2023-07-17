// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpDetails _$SignUpDetailsFromJson(Map<String, dynamic> json) =>
    SignUpDetails(
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignUpDetailsToJson(SignUpDetails instance) =>
    <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'password': instance.password,
    };
