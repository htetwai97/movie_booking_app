import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';
part 'banner_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BANNER_VO,adapterName: "BannerVOAdapter")
class BannerVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "title")
  @HiveField(1)
  String? title;

  @JsonKey(name: "url")
  @HiveField(2)
  String? url;

  @JsonKey(name: "is_active")
  @HiveField(3)
  int? isActive;

  @JsonKey(name: "created_at")
  @HiveField(4)
  String? createdAt;

  @JsonKey(name: "updated_at")
  @HiveField(5)
  String? updatedAt;

  BannerVO(this.id, this.title, this.url, this.isActive, this.createdAt,
      this.updatedAt);

  factory BannerVO.fromJson(Map<String, dynamic> json) =>
      _$BannerVOFromJson(json);
  Map<String, dynamic> toJson() => _$BannerVOToJson(this);

  @override
  String toString() {
    return 'BannerVO{id: $id, title: $title, url: $url, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

