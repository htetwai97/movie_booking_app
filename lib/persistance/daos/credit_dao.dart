import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/credits_vo.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';

class CreditDao{
  static final CreditDao _singleton = CreditDao._internal();
  factory CreditDao() {
    return _singleton;
  }

  CreditDao._internal();

  void saveCredits(List<CreditVO?>? credits)async{
    Map<int?,CreditVO> creditMap = Map.fromIterable(credits??[],
    key: (credit)=> credit.id,value: (credit)=> credit
    );
    await getCreditBox().putAll(creditMap);
  }

  List<CreditVO>? getCredits(int? movieId){
    return getCreditBox().values.toList();
  }
  
  Box<CreditVO> getCreditBox(){
    return Hive.box<CreditVO>(BOX_NAME_CREDIT_VO);
  }

}