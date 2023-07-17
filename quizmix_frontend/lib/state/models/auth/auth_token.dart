import 'package:json_annotation/json_annotation.dart';

part 'auth_token.g.dart';

@JsonSerializable()
class AuthToken {
  AuthToken({
    required this.refresh,
    required this.access,
  });

  String? refresh;
  String? access;

  /// Base token creation; call this if you need to reference an empty AuthToken (fresh user or logged out).
  AuthToken.base()
      : refresh = '',
        access = '';

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);
  Map<String, dynamic> toJson() => _$AuthTokenToJson(this);
}
