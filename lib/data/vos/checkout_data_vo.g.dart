// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutDataVO _$CheckOutDataVOFromJson(Map<String, dynamic> json) =>
    CheckOutDataVO(
      json['id'] as int?,
      json['booking_no'] as String?,
      json['booking_date'] as String?,
      json['row'] as String?,
      json['seat'] as String?,
      json['total_seat'] as int?,
      json['total'] as String?,
      json['movie_id'] as int?,
      json['cinema_id'] as int?,
      json['username'] as String?,
      json['timeslot'] == null
          ? null
          : CheckOutTimeSlotVO.fromJson(
              json['timeslot'] as Map<String, dynamic>),
      (json['snacks'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CheckOutSnackVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['qr_code'] as String?,
    );

Map<String, dynamic> _$CheckOutDataVOToJson(CheckOutDataVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_no': instance.bookingNo,
      'booking_date': instance.bookingDate,
      'row': instance.row,
      'seat': instance.seat,
      'total_seat': instance.totalSeat,
      'total': instance.total,
      'movie_id': instance.movieId,
      'cinema_id': instance.cinemaId,
      'username': instance.userName,
      'timeslot': instance.timeSlot,
      'snacks': instance.snacks,
      'qr_code': instance.qrCode,
    };
