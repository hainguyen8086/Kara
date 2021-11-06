// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'res-data-user-zalo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResDataUserZalo _$ResDataUserZaloFromJson(Map<String, dynamic> json) =>
    ResDataUserZalo(
      DataUserZalo.fromJson(json['data'] as Map<String, dynamic>),
      json['return_code'] as String,
      json['return_message'] as String,
      json['sub_return_code'] as Object,
      json['sub_return_message'] as Object,
    );

Map<String, dynamic> _$ResDataUserZaloToJson(ResDataUserZalo instance) =>
    <String, dynamic>{
      'data': instance.data,
      'return_code': instance.returnCode,
      'return_message': instance.returnMessage,
      'sub_return_code': instance.subReturnCode,
      'sub_return_message': instance.subReturnMessage,
    };
