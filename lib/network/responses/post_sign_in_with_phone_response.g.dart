// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sign_in_with_phone_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSignInWithPhoneResponse _$PostSignInWithPhoneResponseFromJson(
        Map<String, dynamic> json) =>
    PostSignInWithPhoneResponse(
      json['code'] as int?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : PaDcSignInDataVO.fromJson(json['data'] as Map<String, dynamic>),
      json['token'] as String?,
    );

Map<String, dynamic> _$PostSignInWithPhoneResponseToJson(
        PostSignInWithPhoneResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };
