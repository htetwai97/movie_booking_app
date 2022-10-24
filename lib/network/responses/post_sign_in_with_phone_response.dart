import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/padc_sign_in_data_vo.dart';
part 'post_sign_in_with_phone_response.g.dart';
@JsonSerializable()
class PostSignInWithPhoneResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  PaDcSignInDataVO? data;

  @JsonKey(name: "token")
  String? token;

  PostSignInWithPhoneResponse(this.code, this.message, this.data, this.token);


  @override
  String toString() {
    return 'PostSignInWithPhoneResponse{code: $code, message: $message, data: $data, token: $token}';
  }

  factory PostSignInWithPhoneResponse.fromJson(Map<String, dynamic> json) =>
      _$PostSignInWithPhoneResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostSignInWithPhoneResponseToJson(this);
}

