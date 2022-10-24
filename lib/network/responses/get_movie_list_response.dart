import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/date_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
part 'get_movie_list_response.g.dart';

@JsonSerializable()
class GetMovieListResponse{

  @JsonKey(name: "dates")
  DateVO? dates;

  @JsonKey(name: "page")
  int? page;

  @JsonKey(name: "results")
  List<MovieVO>? results;


  GetMovieListResponse({this.results,this.page,this.dates});

  factory GetMovieListResponse.fromJson(Map<String,dynamic> json) => _$GetMovieListResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetMovieListResponseToJson(this);
}