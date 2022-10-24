import 'package:dio/dio.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/network/responses/get_credits_by_movie_response.dart';
import 'package:movie_booking_app/network/responses/get_genres_response.dart';
import 'package:movie_booking_app/network/responses/get_movie_list_response.dart';
import 'package:retrofit/http.dart';
part 'the_movie_booking_apis.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieBookingApi{
  factory TheMovieBookingApi(Dio dio) = _TheMovieBookingApi;

  @GET(ENDPOINT_GET_NOW_PLAYING)
  Future<GetMovieListResponse>getMovieList(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page,
      );

  @GET(ENDPOINT_GET_COMING_SOOM)
  Future<GetMovieListResponse>getMovieListComingSoon(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page,
      );

  @GET(ENDPOINT_GET_GENRES)
  Future<GetGenreResponse>getGenre(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      );

  @GET("$ENDPOINT_GET_MOVIE_DETAIL/{movie_id}")
  Future<MovieVO> getMovieDetail(
      @Path("movie_id") String movieId,
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page,
      );

  @GET("$ENDPOINT_GET_CREDITS_BY_MOVIE/{movie_id}/credits")
  Future<GetCreditsByMovieResponse> getCreditsByMovie(
      @Path("movie_id") String movieId,
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page,
      );

}