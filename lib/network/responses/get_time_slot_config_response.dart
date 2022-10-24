import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/config_time_slot_vo.dart';
part 'get_time_slot_config_response.g.dart';
@JsonSerializable()
class GetTimeSlotConfigResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
 List<ConfigTimeSlotVO?>? data;

  GetTimeSlotConfigResponse(this.code, this.message, this.data);

  factory GetTimeSlotConfigResponse.fromJson(Map<String,dynamic> json) => _$GetTimeSlotConfigResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetTimeSlotConfigResponseToJson(this);
}

// "code": 200,
// "message": "Success",
// "data": [
// {
// "id": 1,
// "key": "cinema_updated_time",
// "value": "2022-09-28 13:09:46"
// },
// {
// "id": 2,
// "key": "cinema_timeslot_status",
// "value": [
// {
// "id": 1,
// "title": "Availible",
// "color": "#00FFA3"
// },
// {
// "id": 2,
// "title": "Filling Fast",
// "color": "#FF7A00"
// },
// {
// "id": 3,
// "title": "Almost Full",
// "color": "#FF00B8"
// }
// ]
// }
// ]
// }