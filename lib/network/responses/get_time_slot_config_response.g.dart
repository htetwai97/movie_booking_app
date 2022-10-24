// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_time_slot_config_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTimeSlotConfigResponse _$GetTimeSlotConfigResponseFromJson(
        Map<String, dynamic> json) =>
    GetTimeSlotConfigResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ConfigTimeSlotVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetTimeSlotConfigResponseToJson(
        GetTimeSlotConfigResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
