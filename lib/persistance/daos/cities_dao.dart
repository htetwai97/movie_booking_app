import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/city_vo.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';

class CityDao {
  static final CityDao _singleton = CityDao._internal();
  factory CityDao() {
    return _singleton;
  }

  CityDao._internal();

  void saveCities(List<CityVO?>? cities) async {
    Map<int?, CityVO> cityMap = Map.fromIterable(cities ?? [],
        key: (city) => city.id, value: (city) => city);
    await getCityBox().putAll(cityMap);
  }

  List<CityVO>? getCities(){
    return getCityBox().values.toList();
  }

  Box<CityVO> getCityBox() {
    return Hive.box<CityVO>(BOX_NAME_CITY_VO);
  }

}
