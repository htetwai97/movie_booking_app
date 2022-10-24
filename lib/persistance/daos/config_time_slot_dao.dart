import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/config_time_slot_vo.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';

class ConfigTimeSlotDao {
  static final ConfigTimeSlotDao _singleton = ConfigTimeSlotDao._internal();
  factory ConfigTimeSlotDao() {
    return _singleton;
  }

  ConfigTimeSlotDao._internal();

  void saveConfigTimeSlots(List<ConfigTimeSlotVO?>? configTimeSlots) async {
    Map<int?, ConfigTimeSlotVO> configTimeSlotMap = Map.fromIterable(
        configTimeSlots ?? [],
        key: (config) => config.id,
        value: (config) => config);
    await getConfigBox().putAll(configTimeSlotMap);
  }

  List<ConfigTimeSlotVO>? getConfigs(){
    return getConfigBox().values.toList();
  }

  Box<ConfigTimeSlotVO> getConfigBox() {
    return Hive.box<ConfigTimeSlotVO>(BOX_NAME_CONFIG_TIME_SLOT_VO);
  }
}
