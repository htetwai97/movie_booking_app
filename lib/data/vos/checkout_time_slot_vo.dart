import 'package:json_annotation/json_annotation.dart';
part 'checkout_time_slot_vo.g.dart';
@JsonSerializable()
class CheckOutTimeSlotVO{
  @JsonKey(name: "cinema_day_timeslot_id")
  int? cinemaDayTimeSlotId;

  @JsonKey(name: "start_time")
  String? startTime;

  CheckOutTimeSlotVO(this.cinemaDayTimeSlotId, this.startTime);

  factory CheckOutTimeSlotVO.fromJson(Map<String, dynamic> json) =>
      _$CheckOutTimeSlotVOFromJson(json);
  Map<String, dynamic> toJson() => _$CheckOutTimeSlotVOToJson(this);

  @override
  String toString() {
    return 'CheckOutTimeSlotVO{cinemaDayTimeSlotId: $cinemaDayTimeSlotId, startTime: $startTime}';
  }
}



// {
// "code": 200,
// "message": "Success",
// "data": {
// "id": 2131,
// "booking_no": "JCTV-1337-2081",
// "booking_date": "2022-10-29",
// "row": "G",
// "seat": "G-11",
// "total_seat": 1,
// "total": "$19",
// "movie_id": 616037,
// "cinema_id": 2,
// "username": "Htet Wai Lwin",
// "timeslot": {
// "cinema_day_timeslot_id": 25,
// "start_time": "10:00 AM"
// },
// "snacks": [
// {
// "id": 4041,
// "name": "Burger Combo1",
// "description": "Et dolores eaque officia aut.",
// "image": "https://storage.googleapis.com/mmds-padc/PADC/tmba/snacks/burger.jpeg",
// "price": 2,
// "unit_price": 2,
// "quantity": 2,
// "total_price": 4
// },
// {
// "id": 4042,
// "name": "PopCorn",
// "description": "At vero et doloribus sint porro ipsum consequatur.",
// "image": "https://storage.googleapis.com/mmds-padc/PADC/tmba/snacks/popcorn.webp",
// "price": 4,
// "unit_price": 4,
// "quantity": 3,
// "total_price": 12
// }
// ],
// "qr_code": "uploads/img/qr-code/img-JCTV-1337-2081.png"
// }
// }