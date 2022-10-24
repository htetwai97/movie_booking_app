import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/google_data_vo.dart';
part 'post_google_signin_response.g.dart';
@JsonSerializable()
class PostGoogleSignInResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  GoogleDataVO? data;

  @JsonKey(name: "token")
  String? token;

  PostGoogleSignInResponse(this.code, this.message, this.data, this.token);

  factory PostGoogleSignInResponse.fromJson(Map<String,dynamic> json) => _$PostGoogleSignInResponseFromJson(json);
  Map<String,dynamic> toJson() => _$PostGoogleSignInResponseToJson(this);
}
