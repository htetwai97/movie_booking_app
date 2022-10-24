import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
part 'get_payment_type_response.g.dart';
@JsonSerializable()
class GetPaymentTypeResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<PaymentVO?>? data;

  GetPaymentTypeResponse(this.code, this.message, this.data);

  factory GetPaymentTypeResponse.fromJson(Map<String,dynamic> json) => _$GetPaymentTypeResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetPaymentTypeResponseToJson(this);

  @override
  String toString() {
    return 'GetPaymentTypeResponse{code: $code, message: $message, data: $data}';
  }
}