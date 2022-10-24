// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cinema_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCinemaDetailResponse _$GetCinemaDetailResponseFromJson(
        Map<String, dynamic> json) =>
    GetCinemaDetailResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CinemaDetailVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['latest_time'] as String?,
    );

Map<String, dynamic> _$GetCinemaDetailResponseToJson(
        GetCinemaDetailResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'latest_time': instance.latestTime,
    };
