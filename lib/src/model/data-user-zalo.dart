import 'package:json_annotation/json_annotation.dart';
part 'data-user-zalo.g.dart';

@JsonSerializable()
class DataUserZalo {
  @JsonKey(name: "reference_id")
  String referenceId;
  @JsonKey(name: "m_u_id")
  String muId;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "phone")
  String phone;

  DataUserZalo(
      {required this.referenceId,
      required this.muId,
      required this.name,
      required this.phone});
  factory DataUserZalo.fromJson(Map<String, dynamic> json) =>
      _$DataUserZaloFromJson(json);
  Map<String, dynamic> toJson() => _$DataUserZaloToJson(this);
}
