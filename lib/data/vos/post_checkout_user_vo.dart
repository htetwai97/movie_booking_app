import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/post_request_snack_list_vo.dart';
import 'package:movie_booking_app/data/vos/snack_item_vo.dart';
part 'post_checkout_user_vo.g.dart';
@JsonSerializable()
class PostCheckOutUserVO{
  @JsonKey(name: "cinema_day_timeslot_id")
 int? cinemaDayTimeSlotId;
  @JsonKey(name: "seat_number")
 String? seatNumber;
  @JsonKey(name: "booking_date")
 String? bookingDate;
  @JsonKey(name: "movie_id")
 int? movieId;
  @JsonKey(name: "payment_type_id")
 int? paymentTypeId;
  @JsonKey(name: "snacks")
 List<SnackVO?>? snacks;

  PostCheckOutUserVO(this.cinemaDayTimeSlotId, this.seatNumber,
      this.bookingDate, this.movieId, this.paymentTypeId, this.snacks);

  factory PostCheckOutUserVO.fromJson(Map<String, dynamic> json) =>
      _$PostCheckOutUserVOFromJson(json);
  Map<String, dynamic> toJson() => _$PostCheckOutUserVOToJson(this);
}

