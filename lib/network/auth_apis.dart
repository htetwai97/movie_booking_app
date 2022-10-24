import 'package:dio/dio.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/post_checkout_user_vo.dart';
import 'package:movie_booking_app/data/vos/snack_item_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
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
import 'package:retrofit/http.dart';
part 'auth_apis.g.dart';

@RestApi(baseUrl: BASE_URL_PADC)
abstract class AuthApis {
  factory AuthApis(Dio dio) = _AuthApis;

  @POST(ENDPOINT_POST_OTP_GET)
  Future<PostGetOtpAndSetCityResponse> postGetOtp(
    @Field(PARAM_PHONE_NO) String phoneNumber,
  );

  @POST(ENDPOINT_POST_SIGN_IN_WITH_PHONE)
  Future<PostSignInWithPhoneResponse> postSignInWithPhone(
    @Query(PARAM_PHONE_NO) String phoneNumber,
    @Query(PARAM_OTP_CODE) String otpCode,
  );

  @POST(ENDPOINT_POST_GOOGLE_SIGN_IN)
  Future<PostGoogleSignInResponse> postGoogleSignIn(
    @Field(PARAM_GOOGLE_ID) String? accessToken,
    @Field(PARAM_GOOGLE_NAME) String? name,
  );

  @GET(ENDPOINT_GET_CITIES)
  Future<GetCitiesResponse> getCities();

  @POST(ENDPOINT_POST_SET_CITY)
  Future<PostGetOtpAndSetCityResponse> postSetCity(
    @Header(PARAM_AUTHORIZATION) String authorization,
    @Field(PARAM_CITY_ID) int? cityId,
  );

  @GET(ENDPOINT_GET_BANNERS)
  Future<GetBannerResponse> getBanner();

  @GET(ENDPOINT_GET_CINEMA_DETAIL)
  Future<GetCinemaDetailResponse> getCinemaDetail();

  @GET(ENDPOINT_GET_PAYMENT_TYPES)
  Future<GetPaymentTypeResponse> getPaymentType(
    @Header(PARAM_AUTHORIZATION) String authorization,
  );

  @GET(ENDPOINT_GET_SNACK_CATEGORY)
  Future<GetSnackCategoryResponse> getSnackCategory(
    @Header(PARAM_AUTHORIZATION) String authorization,
  );

  @GET(ENDPOINT_GET_SEAT_PLAN)
  Future<GetSeatingPlanResponse> getSeatPlan(
    @Header(PARAM_AUTHORIZATION) String authorization,
    @Query(PARAM_CINEMA_DAYTIME_SLOT_ID) int? cinemaDayTimeSlotId,
    @Query(PARAM_BOOKING_DATE) String? bookingDate,
  );

  @GET(ENDPOINT_GET_CINEMAS_DAYTIME_SLOTS)
  Future<GetCinemasAndDayTimeSlotsResponse> getCinemaDayTimeSlots(
      @Header(PARAM_AUTHORIZATION) String authorization,
      @Query(PARAM_DATE) String? date);

  @GET(ENDPOINT_GET_SNACK)
  Future<GetSnackResponse> getSnack(
    @Header(PARAM_AUTHORIZATION) String authorization,
    @Query(PARAM_CATEGORY_ID) int? categoryId,
  );

  @GET(ENDPOINT_GET_SNACK)
  Future<GetSnackResponse> getSnackForAll(
    @Header(PARAM_AUTHORIZATION) String authorization,
  );

  @GET(ENDPOINT_GET_CONFIG)
  Future<GetTimeSlotConfigResponse> getTimeSlotConfig();

  @POST(ENDPOINT_POST_CHECKOUT)
  Future<PostCheckOutResponse> postCheckOut(
      @Header(PARAM_AUTHORIZATION) String? authorization,
      @Body() PostCheckOutUserVO? postCheckOutUserVO,
      );

}
