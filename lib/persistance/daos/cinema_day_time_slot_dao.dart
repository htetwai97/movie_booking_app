import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/network/responses/get_cinemas_and_its_timeslots_response.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';

class CinemaDayTimeSlotResponseDao {
  static final CinemaDayTimeSlotResponseDao _singleton =
      CinemaDayTimeSlotResponseDao._internal();
  factory CinemaDayTimeSlotResponseDao() {
    return _singleton;
  }
  CinemaDayTimeSlotResponseDao._internal();

  void saveCinemaDayTimeSlotResponse(GetCinemasAndDayTimeSlotsResponse? cinemaTimeSlotResponse)async{
    return getCinemaDayTimeSlotResponseBox().put(cinemaTimeSlotResponse?.dateForHiveKey, cinemaTimeSlotResponse!);
  }

  GetCinemasAndDayTimeSlotsResponse ? getCinemaDayTimeResponseByDate(String? dateSelected){
    return getCinemaDayTimeSlotResponseBox().get(dateSelected);
  }

  Box<GetCinemasAndDayTimeSlotsResponse> getCinemaDayTimeSlotResponseBox() {
    return Hive.box<GetCinemasAndDayTimeSlotsResponse>(
        BOX_NAME_GET_CINEMA_TIMESLOT_RESPONSE);
  }
}
