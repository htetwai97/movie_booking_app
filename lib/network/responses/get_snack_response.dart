import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/snack_item_vo.dart';
part 'get_snack_response.g.dart';
@JsonSerializable()
class GetSnackResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<SnackVO?>? data;

  GetSnackResponse(this.code, this.message, this.data);

  factory GetSnackResponse.fromJson(Map<String,dynamic> json) => _$GetSnackResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetSnackResponseToJson(this);
}