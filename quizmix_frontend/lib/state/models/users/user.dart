import 'package:json_annotation/json_annotation.dart';
import 'package:quizmix_frontend/state/models/roles/role.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.email,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.image,
    required this.isActive,
    required this.createdOn,
    required this.role,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'middle_name')
  final String? middleName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'is_active')
  final bool isActive;

  @JsonKey(name: 'created_on')
  final DateTime createdOn;

  @JsonKey(name: 'role')
  final Role role;

  /// Base user creation; call this if you need to reference an empty user.
  User.base()
      : id = 0,
        email = '',
        firstName = '',
        middleName = null,
        lastName = '',
        image = null,
        isActive = false,
        createdOn = DateTime.now(),
        role = Role.base();

  String get fullName => (middleName == null || middleName!.isEmpty)
      ? '$firstName $lastName'
      : '$firstName $middleName $lastName';

  String get roleName => role.name;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
