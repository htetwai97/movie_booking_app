import 'package:movie_booking_app/data/vos/banner_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_detail_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/city_vo.dart';
import 'package:movie_booking_app/data/vos/config_time_slot_vo.dart';
import 'package:movie_booking_app/data/vos/credits_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/padc_sign_in_data_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/post_checkout_user_vo.dart';
import 'package:movie_booking_app/data/vos/seating_plan_vo.dart';
import 'package:movie_booking_app/data/vos/snack_category_list_vo.dart';
import 'package:movie_booking_app/data/vos/snack_item_vo.dart';
import 'package:movie_booking_app/network/responses/get_banner_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_detail_response.dart';
import 'package:movie_booking_app/network/responses/get_cinemas_and_its_timeslots_response.dart';
import 'package:movie_booking_app/network/responses/get_cities_response.dart';
import 'package:movie_booking_app/network/responses/get_payment_type_response.dart';
import 'package:movie_booking_app/network/responses/get_seating_plan_response.dart';
import 'package:movie_booking_app/network/responses/get_snack_category_list_response.dart';
import 'package:movie_booking_app/network/responses/get_snack_response.dart';
import 'package:movie_booking_app/network/responses/get_time_slot_config_response.dart';
import 'package:movie_booking_app/network/responses/post_checkout_response.dart';
import 'package:movie_booking_app/network/responses/post_get_otp_and_set_city_response.dart';
import 'package:movie_booking_app/network/responses/post_google_signin_response.dart';
import 'package:movie_booking_app/network/responses/post_sign_in_with_phone_response.dart';

abstract class MovieBookingModel{
  /// Network
  Future<List<MovieVO?>?> getMovieListNowShowing(int page);
  Future<List<MovieVO?>?> getMovieListComingSoon(int page);
  Future<List<GenreVO?>?> getGenres();
  Future<MovieVO?> getMovieDetails(int movieId);
  Future<List<CreditVO?>?> getCreditsCastByMovie(int movieId);
  Future<List<CreditVO?>?> getCreditsCrewByMovie(int movieId);
  Future<PostGetOtpAndSetCityResponse?>? postGetOtp(String phNumber);
  Future<PostSignInWithPhoneResponse?>? postSignInWithPhone(String phNumber,String otpCode);
  Future<GetCitiesResponse?>? getCities();
  Future<PostGetOtpAndSetCityResponse?>? postSetCity(int? cityId);
  Future<GetBannerResponse?>? getBanner();
  Future<GetCinemaDetailResponse?>? getCinemaDetail();
  Future<GetPaymentTypeResponse?>? getPaymentType();
  Future<GetSnackCategoryResponse?>? getSnackCategory();
  Future<GetSeatingPlanResponse?>? getSeatPlan(int? cinemaDayTimeSlotId,String? bookingDate);
  Future<GetCinemasAndDayTimeSlotsResponse?>? getCinemaDayTimeSlots(String? date);
  Future<GetSnackResponse?>? getSnack(int? categoryId);
  Future<PostGoogleSignInResponse?>? postGoogleSignIn(String? accessToken, String? name);
  Future<GetSnackResponse?>? getSnackForAll();
  Future<GetTimeSlotConfigResponse?>? getTimeSlotConfig();
  Future<PostCheckOutResponse?>? postCheckOut(String ? accessToken, PostCheckOutUserVO? postCheckOutUserVO);


  /// Database
  Future<PaDcSignInDataVO?>? postSignInWithPhoneDataBase(int userSerial);
  Future<List<CityVO?>?>? getCitiesDataBase();
  Future<List<PaymentVO?>?>? getPaymentMethodsDataBase();
  Future<List<BannerVO?>?>? getBannersDataBase();
  Future<List<MovieVO?>?>? getNowPlayingMovieListDataBase();
  Future<List<MovieVO?>?>? getComingSoonMovieListDataBase();
  Future<MovieVO?>? getMovieDetailDataBase(int? movieId);
  Future<List<CreditVO?>?> getCastsByMovieDataBase(int movieId);
  Future<List<CreditVO?>?> getCrewsByMovieDataBase(int movieId);
  Future<List<CinemaDetailVO?>?>? getCinemaDetailDataBase();
  Future<List<ConfigTimeSlotVO?>?>? getConfigTimeSlotDataBase();
  Future<List<SnackCategoryVO?>?>? getSnackCategoryDataBase();
  Future<List<SnackVO?>?>? getSnacksDataBase();
  Future<GetCinemasAndDayTimeSlotsResponse?>? getCinemaDayTimeSlotsDataBase(String? dateForKey);
}