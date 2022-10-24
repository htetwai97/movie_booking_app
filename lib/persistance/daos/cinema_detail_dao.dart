import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_booking_app/data/vos/cinema_detail_vo.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';

class CinemaDetailDao {
  static final CinemaDetailDao _singleton = CinemaDetailDao._internal();
  factory CinemaDetailDao() {
    return _singleton;
  }

  CinemaDetailDao._internal();

  void saveAllCinemaDetails(List<CinemaDetailVO?>? cinemaDetailList) async {
    Map<int?, CinemaDetailVO> cinemaDetailMap = Map.fromIterable(
        cinemaDetailList ?? [],
        key: (cinemaDetail) => cinemaDetail.id,
        value: (cinemaDetail) => cinemaDetail);
    await getCinemaDetailBox().putAll(cinemaDetailMap);
  }

  List<CinemaDetailVO>? getAllCinemaDetails(){
    return getCinemaDetailBox().values.toList();
  }

  Box<CinemaDetailVO> getCinemaDetailBox() {
    return Hive.box<CinemaDetailVO>(BOX_NAME_CINEMA_DETAIL_VO);
  }
}
