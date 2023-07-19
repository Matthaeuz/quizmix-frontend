import 'package:json_annotation/json_annotation.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';

part 'reviewer.g.dart';

@JsonSerializable()
class Reviewer {
  const Reviewer({required this.id, required this.user});

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'user')
  final User user;

  Reviewer.base() : id = 0, user = User.base();

  factory Reviewer.fromJson(Map<String, dynamic> json) =>
      _$ReviewerFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewerToJson(this);
}
