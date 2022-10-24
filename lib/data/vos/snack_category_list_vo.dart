import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';
part 'snack_category_list_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SNACK_CATEGORY_VO,adapterName: "SnackCategoryVOAdapter")
class SnackCategoryVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "title")
  @HiveField(1)
  String? title;

  @JsonKey(name: "title_mm")
  @HiveField(2)
  String? titleMn;

  @JsonKey(name: "is_active")
  @HiveField(3)
  int? isActive;

  @JsonKey(name: "created_at")
  @HiveField(4)
  String? createdAt;

  @JsonKey(name: "updated_at")
  @HiveField(5)
  String? updatedAt;

  SnackCategoryVO(this.id, this.title, this.titleMn, this.isActive, this.createdAt,
      this.updatedAt);

  factory SnackCategoryVO.fromJson(Map<String, dynamic> json) =>
      _$SnackCategoryVOFromJson(json);
  Map<String, dynamic> toJson() => _$SnackCategoryVOToJson(this);

  @override
  String toString() {
    return 'SnackCategoryVO{id: $id, title: $title, titleMn: $titleMn, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
