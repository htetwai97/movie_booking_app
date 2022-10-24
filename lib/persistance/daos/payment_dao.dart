import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';

class PaymentDao{
  static final PaymentDao _singleton = PaymentDao._internal();
  factory PaymentDao() {
    return _singleton;
  }

  PaymentDao._internal();

  void savePaymentMethods(List<PaymentVO?>? paymentTypes) async {
    Map<int?, PaymentVO> paymentMap = Map.fromIterable(paymentTypes ?? [],
        key: (paymentMethod) => paymentMethod.id, value: (paymentMethod) => paymentMethod);
    await getPaymentBox().putAll(paymentMap);
  }

  List<PaymentVO>? getPaymentTypes(){
    return getPaymentBox().values.toList();
  }

  Box<PaymentVO> getPaymentBox(){
    return Hive.box<PaymentVO>(BOX_NAME_PAYMENT_METHODS_VO);
  }
}