import 'package:json_annotation/json_annotation.dart';
part 'post_get_otp_and_set_city_response.g.dart';

@JsonSerializable()
class PostGetOtpAndSetCityResponse {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  PostGetOtpAndSetCityResponse(this.code, this.message);

  factory PostGetOtpAndSetCityResponse.fromJson(Map<String,dynamic> json) => _$PostGetOtpAndSetCityResponseFromJson(json);
  Map<String,dynamic> toJson() => _$PostGetOtpAndSetCityResponseToJson(this);

  @override
  String toString() {
    return 'PostGetOtpResponse{code: $code, message: $message}';
  }
}

