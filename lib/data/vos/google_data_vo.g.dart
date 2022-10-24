// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleDataVO _$GoogleDataVOFromJson(Map<String, dynamic> json) => GoogleDataVO(
      json['id'] as int?,
      json['name'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['total_expense'] as int?,
      json['profile_image'] as String?,
    );

Map<String, dynamic> _$GoogleDataVOToJson(GoogleDataVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'total_expense': instance.totalExpense,
      'profile_image': instance.profileImage,
    };
