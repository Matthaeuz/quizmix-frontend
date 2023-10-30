import 'package:json_annotation/json_annotation.dart';

part 'jsonresponse.g.dart';

@JsonSerializable()
class JSONResponse {
  const JSONResponse({
    required this.message,
  });

  @JsonKey(name: 'message')
  final String message;

  factory JSONResponse.fromJson(Map<String, dynamic> json) => _$JSONResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JSONResponseToJson(this);
}