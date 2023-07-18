import 'package:json_annotation/json_annotation.dart';

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
  });

  final int id;
  final String email;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? image;
  final bool isActive;
  final DateTime createdOn;

  /// Base user creation; call this if you need to reference an empty user.
  User.base()
      : id = 0,
        email = '',
        firstName = '',
        middleName = null,
        lastName = '',
        image = null,
        isActive = false,
        createdOn = DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
