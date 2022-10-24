
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';
part 'time_slot_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_TIME_SLOT_VO,adapterName: "TimeSlotVOAdapter")
class TimeSlotVO{
  @JsonKey(name: "cinema_day_timeslot_id")
  @HiveField(0)
  int? cinemaDayTimeSlotId;

  @JsonKey(name: "start_time")
  @HiveField(1)
  String? startTime;

  @JsonKey(name: "status")
  @HiveField(2)
  int? status;

  TimeSlotVO(this.cinemaDayTimeSlotId, this.startTime, this.status);

  factory TimeSlotVO.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotVOFromJson(json);
  Map<String, dynamic> toJson() => _$TimeSlotVOToJson(this);

  @override
  String toString() {
    return 'TimeSlotVO{cinemaDayTimeSlotId: $cinemaDayTimeSlotId, startTime: $startTime, status: $status}';
  }
}

