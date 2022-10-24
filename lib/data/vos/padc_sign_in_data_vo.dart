import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';
part 'padc_sign_in_data_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PADC_SIGN_IN_DATA_VO,adapterName: "PaDcSignInDataVOAdapter")
class PaDcSignInDataVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "email")
  @HiveField(2)
  String? email;

  @JsonKey(name: "phone")
  @HiveField(3)
  String? phone;

  @JsonKey(name: "total_expense")
  @HiveField(4)
  int? totalExpense;

  @JsonKey(name: "profile_image")
  @HiveField(5)
  String? profileImage;

  @HiveField(6)
  String? token ;


  PaDcSignInDataVO(this.id, this.name, this.email, this.phone,
      this.totalExpense, this.profileImage, this.token);

  @override
  String toString() {
    return 'PaDcSignInDataVO{id: $id, name: $name, email: $email, phone: $phone, totalExpense: $totalExpense, profileImage: $profileImage, token: $token}';
  }

  factory PaDcSignInDataVO.fromJson(Map<String, dynamic> json) =>
      _$PaDcSignInDataVOFromJson(json);
  Map<String, dynamic> toJson() => _$PaDcSignInDataVOToJson(this);
}

