// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seating_plan_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatingPlanVO _$SeatingPlanVOFromJson(Map<String, dynamic> json) =>
    SeatingPlanVO(
      json['id'] as int?,
      json['type'] as String?,
      json['seat_name'] as String?,
      json['symbol'] as String?,
      json['price'] as int?,
    );

Map<String, dynamic> _$SeatingPlanVOToJson(SeatingPlanVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'seat_name': instance.seatName,
      'symbol': instance.symbol,
      'price': instance.price,
    };
