import 'package:json_annotation/json_annotation.dart';

part 'auth_details.g.dart';

@JsonSerializable()
class AuthDetails {
  AuthDetails({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  /// Base token creation; call this if you need to reference an empty AuthToken (fresh user or logged out).
  AuthDetails.base()
      : email = '',
        password = '';

  factory AuthDetails.fromJson(Map<String, dynamic> json) =>
      _$AuthDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$AuthDetailsToJson(this);
}
