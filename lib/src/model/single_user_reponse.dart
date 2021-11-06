import 'package:json_annotation/json_annotation.dart';
import 'package:kara/src/model/user.dart';

part 'single_user_reponse.g.dart';

@JsonSerializable()
class SingleUserResponse {
  SingleUserResponse({required this.user});

  @JsonKey(name: "data")
  User user;

  factory SingleUserResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SingleUserResponseToJson(this);
}
