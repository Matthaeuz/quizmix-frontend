import 'package:json_annotation/json_annotation.dart';

part 'signup_details.g.dart';

@JsonSerializable()
class SignUpDetails {
  SignUpDetails({
    required this.email,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.password,
  });

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'middle_name')
  String? middleName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'password')
  final String password;

  factory SignUpDetails.fromJson(Map<String, dynamic> json) =>
      _$SignUpDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpDetailsToJson(this);
}
