import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/facility_vo.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';
part 'cinema_detail_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_DETAIL_VO,adapterName: "CinemaDetailVOAdapter")
class CinemaDetailVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "phone")
  @HiveField(2)
  String? phone;

  @JsonKey(name: "email")
  @HiveField(3)
  String? email;

  @JsonKey(name: "address")
  @HiveField(4)
  String? address;

  @JsonKey(name: "promo_vdo_url")
  @HiveField(5)
  String? promoVdoUrl;

  @JsonKey(name: "facilities")
  @HiveField(6)
  List<FacilityVO?>? facilities;

  @JsonKey(name: "safety")
  @HiveField(7)
  List<String>? safety;

  CinemaDetailVO(this.id, this.name, this.phone, this.email, this.address,
      this.promoVdoUrl, this.facilities, this.safety);

  factory CinemaDetailVO.fromJson(Map<String, dynamic> json) =>
      _$CinemaDetailVOFromJson(json);
  Map<String, dynamic> toJson() => _$CinemaDetailVOToJson(this);

  @override
  String toString() {
    return 'CinemaDetailVO{id: $id, name: $name, phone: $phone, email: $email, address: $address, promoVdoUrl: $promoVdoUrl, facilities: $facilities, safety: $safety}';
  }
}

