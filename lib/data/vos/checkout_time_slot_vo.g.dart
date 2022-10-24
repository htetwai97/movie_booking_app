// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_time_slot_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutTimeSlotVO _$CheckOutTimeSlotVOFromJson(Map<String, dynamic> json) =>
    CheckOutTimeSlotVO(
      json['cinema_day_timeslot_id'] as int?,
      json['start_time'] as String?,
    );

Map<String, dynamic> _$CheckOutTimeSlotVOToJson(CheckOutTimeSlotVO instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.cinemaDayTimeSlotId,
      'start_time': instance.startTime,
    };
