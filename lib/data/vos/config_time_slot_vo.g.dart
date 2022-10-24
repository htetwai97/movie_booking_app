// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_time_slot_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigTimeSlotVOAdapter extends TypeAdapter<ConfigTimeSlotVO> {
  @override
  final int typeId = 8;

  @override
  ConfigTimeSlotVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConfigTimeSlotVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, ConfigTimeSlotVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.key)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigTimeSlotVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigTimeSlotVO _$ConfigTimeSlotVOFromJson(Map<String, dynamic> json) =>
    ConfigTimeSlotVO(
      json['id'] as int?,
      json['key'] as String?,
      json['value'],
    );

Map<String, dynamic> _$ConfigTimeSlotVOToJson(ConfigTimeSlotVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'value': instance.value,
    };
