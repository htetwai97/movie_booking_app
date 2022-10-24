import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';
part 'facility_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_FACILITY_VO,adapterName: "FacilityVOAdapter")
class FacilityVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "title")
  @HiveField(1)
  String? title;

  @JsonKey(name: "img")
  @HiveField(2)
  String? img;

  FacilityVO(this.id, this.title, this.img);

  factory FacilityVO.fromJson(Map<String, dynamic> json) =>
      _$FacilityVOFromJson(json);
  Map<String, dynamic> toJson() => _$FacilityVOToJson(this);

  @override
  String toString() {
    return 'FacilityVO{id: $id, title: $title, img: $img}';
  }
}

