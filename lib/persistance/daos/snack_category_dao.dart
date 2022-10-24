import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/snack_category_list_vo.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';

class SnackCategoryDao {
  static final SnackCategoryDao _singleton = SnackCategoryDao._internal();
  factory SnackCategoryDao() {
    return _singleton;
  }

  SnackCategoryDao._internal();

  void saveSnackCategory(List<SnackCategoryVO?>? snackCategoryList) async {
    Map<int?, SnackCategoryVO> snackCategoryMap = Map.fromIterable(
        snackCategoryList ?? [],
        key: (snackCategory) => snackCategory.id,
        value: (snackCategory) => snackCategory);
    await getSnackCategoryBox().putAll(snackCategoryMap);
  }

  List<SnackCategoryVO>? getSnackCategories(){
    return getSnackCategoryBox().values.toList();
  }

  Box<SnackCategoryVO> getSnackCategoryBox() {
    return Hive.box<SnackCategoryVO>(BOX_NAME_SNACK_CATEGORY_VO);
  }

}
