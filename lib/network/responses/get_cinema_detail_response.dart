import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cinema_detail_vo.dart';
part 'get_cinema_detail_response.g.dart';
@JsonSerializable()
class GetCinemaDetailResponse {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<CinemaDetailVO?>? data;

  @JsonKey(name: "latest_time")
  String? latestTime;

  GetCinemaDetailResponse(this.code, this.message, this.data, this.latestTime);

  factory GetCinemaDetailResponse.fromJson(Map<String,dynamic> json) => _$GetCinemaDetailResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetCinemaDetailResponseToJson(this);
}
