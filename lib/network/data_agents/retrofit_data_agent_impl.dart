import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/credits_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/post_checkout_user_vo.dart';
import 'package:movie_booking_app/data/vos/seating_plan_vo.dart';
import 'package:movie_booking_app/data/vos/snack_category_list_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/network/data_agents/data_agent.dart';
import 'package:movie_booking_app/network/auth_apis.dart';
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
import 'package:movie_booking_app/network/the_movie_booking_apis.dart';

class RetrofitDataAgentImpl extends DataAgent {
  late TheMovieBookingApi mApi;
  late AuthApis aApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio(
      BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return
          true;
        },
        headers: {
          HEADER_REQUESTED_WITH: XML_HTTP_REQUEST,
        },
      ),
    );
    mApi = TheMovieBookingApi(dio);
    aApi = AuthApis(dio);
  }

  @override
  Future<List<MovieVO?>?> getMovieListNowShowing(int page) {
    return mApi
        .getMovieList(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO?>?> getMovieListComingSoon(int page) {
    return mApi
        .getMovieListComingSoon(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<GenreVO?>?> getGenres() {
    return mApi
        .getGenre(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres)
        .first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return mApi.getMovieDetail(
        movieId.toString(), API_KEY, LANGUAGE_EN_US, 1.toString());
  }

  @override
  Future<List<CreditVO?>?> getCreditsByMovie(int movieId) {
    return mApi
        .getCreditsByMovie(
            movieId.toString(), API_KEY, LANGUAGE_EN_US, 1.toString())
        .asStream()
        .map((response) => response.cast)
        .first;
  }

  @override
  Future<List<CreditVO?>?> getCreditsCrewByMovie(int movieId) {
    return mApi
        .getCreditsByMovie(
            movieId.toString(), API_KEY, LANGUAGE_EN_US, 1.toString())
        .asStream()
        .map((response) => response.crew)
        .first;
  }

  @override
  Future<PostGetOtpAndSetCityResponse?>? postGetOtp(String phNumber) {
    return aApi.postGetOtp(phNumber);
  }

  @override
  Future<PostSignInWithPhoneResponse?>? postSignInWithPhone(
      String phNumber, String otpCode) {
    return aApi.postSignInWithPhone(phNumber, otpCode);
  }

  @override
  Future<GetCitiesResponse?>? getCities() {
    return aApi.getCities();
  }

  @override
  Future<PostGetOtpAndSetCityResponse?>? postSetCity(int? cityId) {
    return aApi.postSetCity("${userDataPersistence?.token}", cityId);
  }

  @override
  Future<GetBannerResponse?>? getBanner() {
    return aApi.getBanner();
  }

  @override
  Future<GetCinemaDetailResponse?>? getCinemaDetail() {
    return aApi.getCinemaDetail();
  }

  @override
  Future<GetPaymentTypeResponse?>? getPaymentType() {
    return aApi.getPaymentType("${userDataPersistence?.token}");
  }

  @override
  Future<GetSnackCategoryResponse?>? getSnackCategory() {
    return aApi.getSnackCategory("${userDataPersistence?.token}");
  }

  @override
  Future<GetSeatingPlanResponse?>? getSeatPlan(
      int? cinemaDayTimeSlotId, String? bookingDate) {
    return aApi.getSeatPlan("${userDataPersistence?.token}", cinemaDayTimeSlotId, bookingDate);
  }

  @override
  Future<GetCinemasAndDayTimeSlotsResponse?>? getCinemaDayTimeSlots(
      String? date) {
    return aApi.getCinemaDayTimeSlots("${userDataPersistence?.token}", date);
  }

  @override
  Future<GetSnackResponse?>? getSnack(int? categoryId) {
    return aApi.getSnack("${userDataPersistence?.token}", categoryId);
  }

  @override
  Future<PostGoogleSignInResponse?>? postGoogleSignIn(String? accessToken, String? name) {
    return aApi.postGoogleSignIn(accessToken, name);
  }

  @override
  Future<GetSnackResponse?>? getSnackForAll() {
   return aApi.getSnackForAll("${userDataPersistence?.token}");
  }

  @override
  Future<GetTimeSlotConfigResponse?>? getTimeSlotConfig() {
    return aApi.getTimeSlotConfig();
  }

  @override
  Future<PostCheckOutResponse?>? postCheckOut(String? accessToken, PostCheckOutUserVO? postCheckOutUserVO) {
    return aApi.postCheckOut(accessToken, postCheckOutUserVO);
  }


}
