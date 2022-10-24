import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';
part 'config_time_slot_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_CONFIG_TIME_SLOT_VO,
    adapterName: "ConfigTimeSlotVOAdapter")
class ConfigTimeSlotVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "key")
  @HiveField(1)
  String? key;

  @JsonKey(name: "value")
  @HiveField(2)
  dynamic value;

  ConfigTimeSlotVO(this.id, this.key, this.value);

  factory ConfigTimeSlotVO.fromJson(Map<String, dynamic> json) =>
      _$ConfigTimeSlotVOFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigTimeSlotVOToJson(this);

  @override
  String toString() {
    return 'ConfigTimeSlotVO{id: $id, key: $key, value: $value}';
  }
}
