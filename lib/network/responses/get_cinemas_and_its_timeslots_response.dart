import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';
part 'get_cinemas_and_its_timeslots_response.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_GET_CINEMA_TIMESLOT_RESPONSE,
    adapterName: "GetCinemasAndDayTimeSlotsResponseAdapter")
class GetCinemasAndDayTimeSlotsResponse {
  @JsonKey(name: "code")
  @HiveField(0)
  int? code;

  @JsonKey(name: "message")
  @HiveField(1)
  String? message;

  @JsonKey(name: "data")
  @HiveField(2)
  List<CinemaVO?>? data;

  @HiveField(3)
  String? dateForHiveKey;

  GetCinemasAndDayTimeSlotsResponse(
      this.code, this.message, this.data, this.dateForHiveKey);

  factory GetCinemasAndDayTimeSlotsResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetCinemasAndDayTimeSlotsResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetCinemasAndDayTimeSlotsResponseToJson(this);
}
