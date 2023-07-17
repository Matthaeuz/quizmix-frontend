import 'package:json_annotation/json_annotation.dart';

part 'signup_details.g.dart';

@JsonSerializable()
class SignUpDetails {
  const SignUpDetails({
    required this.email,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.password,
  });

  final String email;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String password;
  
  factory SignUpDetails.fromJson(Map<String, dynamic> json) => _$SignUpDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpDetailsToJson(this);
}