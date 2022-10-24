import 'package:json_annotation/json_annotation.dart';
part 'time_slot_status_vo.g.dart';
@JsonSerializable()
class TimeSlotStatusVO{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "color")
  String? color;

  TimeSlotStatusVO(this.id, this.title, this.color);

  factory TimeSlotStatusVO.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotStatusVOFromJson(json);
  Map<String, dynamic> toJson() => _$TimeSlotStatusVOToJson(this);

  @override
  String toString() {
    return 'TimeSlotStatusVO{id: $id, title: $title, color: $color}';
  }
}

