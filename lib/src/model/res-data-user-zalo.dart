import 'package:json_annotation/json_annotation.dart';

import 'data-user-zalo.dart';
part 'res-data-user-zalo.g.dart';

@JsonSerializable()
class ResDataUserZalo {
  @JsonKey(name: "data")
  DataUserZalo data;
  @JsonKey(name: "return_code")
  String returnCode;
  @JsonKey(name: "return_message")
  String returnMessage;
  @JsonKey(name: "sub_return_code")
  Object subReturnCode;
  @JsonKey(name: "sub_return_message")
  Object subReturnMessage;

  ResDataUserZalo(this.data, this.returnCode, this.returnMessage,
      this.subReturnCode, this.subReturnMessage);

  factory ResDataUserZalo.fromJson(Map<String, dynamic> json) =>
      _$ResDataUserZaloFromJson(json);
  Map<String, dynamic> toJson() => _$ResDataUserZaloToJson(this);
}
