// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBannerResponse _$GetBannerResponseFromJson(Map<String, dynamic> json) =>
    GetBannerResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : BannerVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBannerResponseToJson(GetBannerResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
