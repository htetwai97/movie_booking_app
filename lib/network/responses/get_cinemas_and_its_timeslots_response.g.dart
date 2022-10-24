// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cinemas_and_its_timeslots_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetCinemasAndDayTimeSlotsResponseAdapter
    extends TypeAdapter<GetCinemasAndDayTimeSlotsResponse> {
  @override
  final int typeId = 20;

  @override
  GetCinemasAndDayTimeSlotsResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetCinemasAndDayTimeSlotsResponse(
      fields[0] as int?,
      fields[1] as String?,
      (fields[2] as List?)?.cast<CinemaVO?>(),
      fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GetCinemasAndDayTimeSlotsResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.dateForHiveKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetCinemasAndDayTimeSlotsResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCinemasAndDayTimeSlotsResponse _$GetCinemasAndDayTimeSlotsResponseFromJson(
        Map<String, dynamic> json) =>
    GetCinemasAndDayTimeSlotsResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : CinemaVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['dateForHiveKey'] as String?,
    );

Map<String, dynamic> _$GetCinemasAndDayTimeSlotsResponseToJson(
        GetCinemasAndDayTimeSlotsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'dateForHiveKey': instance.dateForHiveKey,
    };
