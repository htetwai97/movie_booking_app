// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padc_sign_in_data_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaDcSignInDataVOAdapter extends TypeAdapter<PaDcSignInDataVO> {
  @override
  final int typeId = 1;

  @override
  PaDcSignInDataVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaDcSignInDataVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as int?,
      fields[5] as String?,
      fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaDcSignInDataVO obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.totalExpense)
      ..writeByte(5)
      ..write(obj.profileImage)
      ..writeByte(6)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaDcSignInDataVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaDcSignInDataVO _$PaDcSignInDataVOFromJson(Map<String, dynamic> json) =>
    PaDcSignInDataVO(
      json['id'] as int?,
      json['name'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['total_expense'] as int?,
      json['profile_image'] as String?,
      json['token'] as String?,
    );

Map<String, dynamic> _$PaDcSignInDataVOToJson(PaDcSignInDataVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'total_expense': instance.totalExpense,
      'profile_image': instance.profileImage,
      'token': instance.token,
    };
