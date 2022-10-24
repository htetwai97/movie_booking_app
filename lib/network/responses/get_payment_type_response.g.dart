// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_payment_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPaymentTypeResponse _$GetPaymentTypeResponseFromJson(
        Map<String, dynamic> json) =>
    GetPaymentTypeResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : PaymentVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPaymentTypeResponseToJson(
        GetPaymentTypeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
