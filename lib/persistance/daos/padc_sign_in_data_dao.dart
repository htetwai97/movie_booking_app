import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/padc_sign_in_data_vo.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';

class PADCSignInDataDao {
  static final PADCSignInDataDao _singleton = PADCSignInDataDao._internal();
  factory PADCSignInDataDao() {
    return _singleton;
  }

  PADCSignInDataDao._internal();

  void saveUserData(PaDcSignInDataVO? pADCUserDataObject) async {
    return getPADCUserDataBox().put(1, pADCUserDataObject!);
  }

  PaDcSignInDataVO? getUserData(int userserialno){
    return getPADCUserDataBox().get(userserialno);
  }

  Box<PaDcSignInDataVO> getPADCUserDataBox(){
    return Hive.box<PaDcSignInDataVO>(BOX_NAME_PADC_SIGN_IN_DATA_VO);
  }

}
