import 'package:json_annotation/json_annotation.dart';
part 'google_data_vo.g.dart';
@JsonSerializable()
class GoogleDataVO{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "total_expense")
  int? totalExpense;

  @JsonKey(name: "profile_image")
  String? profileImage;

  GoogleDataVO(this.id, this.name, this.email, this.phone, this.totalExpense,
      this.profileImage);

  factory GoogleDataVO.fromJson(Map<String, dynamic> json) =>
      _$GoogleDataVOFromJson(json);
  Map<String, dynamic> toJson() => _$GoogleDataVOToJson(this);
}

// "id": 2561,
// "name": null,
// "email": null,
// "phone": null,
// "total_expense": 0,
// "profile_image": "/img/avatar2.png"