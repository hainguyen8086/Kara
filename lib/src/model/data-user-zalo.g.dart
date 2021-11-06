// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data-user-zalo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataUserZalo _$DataUserZaloFromJson(Map<String, dynamic> json) => DataUserZalo(
      referenceId: json['reference_id'] as String,
      muId: json['m_u_id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$DataUserZaloToJson(DataUserZalo instance) =>
    <String, dynamic>{
      'reference_id': instance.referenceId,
      'm_u_id': instance.muId,
      'name': instance.name,
      'phone': instance.phone,
    };
