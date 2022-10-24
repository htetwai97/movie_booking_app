// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_google_signin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostGoogleSignInResponse _$PostGoogleSignInResponseFromJson(
        Map<String, dynamic> json) =>
    PostGoogleSignInResponse(
      json['code'] as int?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : GoogleDataVO.fromJson(json['data'] as Map<String, dynamic>),
      json['token'] as String?,
    );

Map<String, dynamic> _$PostGoogleSignInResponseToJson(
        PostGoogleSignInResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };
