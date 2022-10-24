import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/checkout_snack_vo.dart';
import 'package:movie_booking_app/data/vos/checkout_time_slot_vo.dart';
part 'checkout_data_vo.g.dart';

@JsonSerializable()
class CheckOutDataVO {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "booking_no")
  String? bookingNo;
  @JsonKey(name: "booking_date")
  String? bookingDate;
  @JsonKey(name: "row")
  String? row;
  @JsonKey(name: "seat")
  String? seat;
  @JsonKey(name: "total_seat")
  int? totalSeat;
  @JsonKey(name: "total")
  String? total;
  @JsonKey(name: "movie_id")
  int? movieId;
  @JsonKey(name: "cinema_id")
  int? cinemaId;
  @JsonKey(name: "username")
  String? userName;
  @JsonKey(name: "timeslot")
  CheckOutTimeSlotVO? timeSlot;
  @JsonKey(name: "snacks")
  List<CheckOutSnackVO?>? snacks;
  @JsonKey(name: "qr_code")
  String? qrCode;

  CheckOutDataVO(
      this.id,
      this.bookingNo,
      this.bookingDate,
      this.row,
      this.seat,
      this.totalSeat,
      this.total,
      this.movieId,
      this.cinemaId,
      this.userName,
      this.timeSlot,
      this.snacks,
      this.qrCode);

  factory CheckOutDataVO.fromJson(Map<String, dynamic> json) =>
      _$CheckOutDataVOFromJson(json);
  Map<String, dynamic> toJson() => _$CheckOutDataVOToJson(this);

  @override
  String toString() {
    return 'CheckOutDataVO{id: $id, bookingNo: $bookingNo, bookingDate: $bookingDate, row: $row, seat: $seat, totalSeat: $totalSeat, total: $total, movieId: $movieId, cinemaId: $cinemaId, userName: $userName, timeSlot: $timeSlot, snacks: $snacks, qrCode: $qrCode}';
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
