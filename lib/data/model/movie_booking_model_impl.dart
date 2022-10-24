import 'package:flutter/cupertino.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
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
import 'package:movie_booking_app/network/data_agents/data_agent.dart';
import 'package:movie_booking_app/network/data_agents/retrofit_data_agent_impl.dart';
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
import 'package:movie_booking_app/persistance/daos/banner_dao.dart';
import 'package:movie_booking_app/persistance/daos/cinema_day_time_slot_dao.dart';
import 'package:movie_booking_app/persistance/daos/cinema_detail_dao.dart';
import 'package:movie_booking_app/persistance/daos/cities_dao.dart';
import 'package:movie_booking_app/persistance/daos/config_time_slot_dao.dart';
import 'package:movie_booking_app/persistance/daos/credit_dao.dart';
import 'package:movie_booking_app/persistance/daos/movie_dao.dart';
import 'package:movie_booking_app/persistance/daos/padc_sign_in_data_dao.dart';
import 'package:movie_booking_app/persistance/daos/payment_dao.dart';
import 'package:movie_booking_app/persistance/daos/snack_category_dao.dart';
import 'package:movie_booking_app/persistance/daos/snack_item_dao.dart';

//String? token;
PaDcSignInDataVO? userDataPersistence;


class MovieBookingModelImpl extends MovieBookingModel {
  /// DataAgent
  DataAgent movieCinemaDataAgent = RetrofitDataAgentImpl();

  /// Daos
  PADCSignInDataDao pADCSignInDataDao = PADCSignInDataDao();
  CityDao cityDao = CityDao();
  PaymentDao paymentDao = PaymentDao();
  BannerDao bannerDao = BannerDao();
  MovieDao movieDao = MovieDao();
  CreditDao creditDao = CreditDao();
  CinemaDetailDao cinemaDetailDao = CinemaDetailDao();
  ConfigTimeSlotDao configTimeSlotDao = ConfigTimeSlotDao();
  SnackCategoryDao snackCategoryDao = SnackCategoryDao();
  SnackDao snackDao = SnackDao();
  CinemaDayTimeSlotResponseDao cinemaDayTimeSlotDao =
      CinemaDayTimeSlotResponseDao();

  /// Singleton
  static final MovieBookingModelImpl _singleton =
      MovieBookingModelImpl._internal();
  factory MovieBookingModelImpl() {
    return _singleton;
  }
  MovieBookingModelImpl._internal();

  /// Network

  /// NowShowing Network
  @override
  Future<List<MovieVO?>?> getMovieListNowShowing(int page) {
    return movieCinemaDataAgent
        .getMovieListNowShowing(page)
        .then((movies) async {
      List<MovieVO?>? nowShowingMovies = movies?.map((movie) {
        movie?.isNowPlaying = true;
        movie?.isComingSoon = false;
        return movie;
      }).toList();
      movieDao.saveMovies(nowShowingMovies);
      return Future.value(movies);
    });
  }

  /// Coming Soon Network
  @override
  Future<List<MovieVO?>?> getMovieListComingSoon(int page) {
    return movieCinemaDataAgent
        .getMovieListComingSoon(page)
        .then((movies) async {
      List<MovieVO?>? comingSoonMovies = movies?.map((movie) {
        movie?.isNowPlaying = false;
        movie?.isComingSoon = true;
        return movie;
      }).toList();
      movieDao.saveMovies(comingSoonMovies);
      return Future.value(movies);
    });
  }

  /// Genres Network
  @override
  Future<List<GenreVO?>?> getGenres() {
    return movieCinemaDataAgent.getGenres();
  }

  /// Casts Network
  @override
  Future<List<CreditVO?>?> getCreditsCastByMovie(int movieId) {
    return movieCinemaDataAgent.getCreditsByMovie(movieId).then((casts) async {
      List<CreditVO?>? castList = casts?.map((cast) {
        cast?.isCasts = true;
        cast?.isCrews = false;
        return cast;
      }).toList();
      creditDao.saveCredits(castList);
      return Future.value(casts);
    });
  }

  /// MovieDetail Network
  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return movieCinemaDataAgent.getMovieDetails(movieId);
  }

  /// Crews Network
  @override
  Future<List<CreditVO?>?> getCreditsCrewByMovie(int movieId) {
    return movieCinemaDataAgent
        .getCreditsCrewByMovie(movieId)
        .then((crews) async {
      List<CreditVO?>? crewList = crews?.map((cast) {
        cast?.isCasts = false;
        cast?.isCrews = true;
        return cast;
      }).toList();
      creditDao.saveCredits(crewList);
      return Future.value(crews);
    });
  }

  /// SendOTP Network
  @override
  Future<PostGetOtpAndSetCityResponse?>? postGetOtp(String phNumber) {
    return movieCinemaDataAgent.postGetOtp(phNumber);
  }

  /// Testing
  void test() {
    movieCinemaDataAgent
        .postGetOtp("959765520310")
        ?.then((value) => debugPrint(value.toString()));
  }

  /// SignInWithPhone Network
  @override
  Future<PostSignInWithPhoneResponse?>? postSignInWithPhone(
      String phNumber, String otpCode) {
    return movieCinemaDataAgent
        .postSignInWithPhone(phNumber, otpCode)
        ?.then((response) async {
      response?.data?.token = "Bearer ${response.token}";
      pADCSignInDataDao.saveUserData(response?.data);
      return Future.value(response);
    });
  }

  /// Cities Network
  @override
  Future<GetCitiesResponse?>? getCities() {
    return movieCinemaDataAgent.getCities()?.then((response) async {
      cityDao.saveCities(response?.data);
      return Future.value(response);
    });
  }

  /// SetCity Network
  @override
  Future<PostGetOtpAndSetCityResponse?>? postSetCity(int? cityId) {
    return movieCinemaDataAgent.postSetCity(cityId);
  }

  /// Banner Network
  @override
  Future<GetBannerResponse?>? getBanner() {
    return movieCinemaDataAgent.getBanner()?.then((response) {
      bannerDao.saveAllBanners(response?.data);
      return Future.value(response);
    });
  }

  /// CinemaDetail Network
  @override
  Future<GetCinemaDetailResponse?>? getCinemaDetail() {
    return movieCinemaDataAgent.getCinemaDetail()?.then((response) async {
      cinemaDetailDao.saveAllCinemaDetails(response?.data);
      //modelCinemaDetailList = response?.data;
      return Future.value(response);
    });
    //return movieCinemaDataAgent.getCinemaDetail();
  }

  /// Payment Network
  @override
  Future<GetPaymentTypeResponse?>? getPaymentType() {
    return movieCinemaDataAgent.getPaymentType()?.then((response) async {
      paymentDao.savePaymentMethods(response?.data);
      return Future.value(response);
    });
  }

  /// SnackCategory Network
  @override
  Future<GetSnackCategoryResponse?>? getSnackCategory() {
    return movieCinemaDataAgent.getSnackCategory()?.then((response) async {
      snackCategoryDao.saveSnackCategory(response?.data);
      return Future.value(response);
    });
  }

  /// CinemaDayTimeSlots Network
  @override
  Future<GetCinemasAndDayTimeSlotsResponse?>? getCinemaDayTimeSlots(
      String? date) {
    return movieCinemaDataAgent
        .getCinemaDayTimeSlots(date)
        ?.then((response) async {
          response?.dateForHiveKey = date;
          cinemaDayTimeSlotDao.saveCinemaDayTimeSlotResponse(response);
          return Future.value(response);
    });
  }

  /// SeatPlan Network
  @override
  Future<GetSeatingPlanResponse?>? getSeatPlan(
      int? cinemaDayTimeSlotId, String? bookingDate) {
    return movieCinemaDataAgent.getSeatPlan(cinemaDayTimeSlotId, bookingDate);
  }

  /// SnackById Network
  @override
  Future<GetSnackResponse?>? getSnack(int? categoryId) {
    return movieCinemaDataAgent.getSnack(categoryId);
  }

  /// Google Network
  @override
  Future<PostGoogleSignInResponse?>? postGoogleSignIn(
      String? accessToken, String? name) {
    return movieCinemaDataAgent.postGoogleSignIn(accessToken, name);
  }

  /// SnacksAll Network
  @override
  Future<GetSnackResponse?>? getSnackForAll() {
    return movieCinemaDataAgent.getSnackForAll()?.then((response) async {
      snackDao.saveSnacks(response?.data);
      return Future.value(response);
    });
  }

  /// Config Network
  @override
  Future<GetTimeSlotConfigResponse?>? getTimeSlotConfig() {
    return movieCinemaDataAgent.getTimeSlotConfig()?.then((response) async {
      configTimeSlotDao.saveConfigTimeSlots(response?.data);
      return Future.value(response);
      // modelTimeSlotConfig = response?.data;
      // debugPrint("config is ====> ${modelTimeSlotConfig.toString()}");
    });
  }

  /// CheckOut Network
  @override
  Future<PostCheckOutResponse?>? postCheckOut(
      String? accessToken, PostCheckOutUserVO? postCheckOutUserVO) {
    return movieCinemaDataAgent.postCheckOut(accessToken, postCheckOutUserVO);
  }

  /// Database

  /// UserObject
  @override
  Future<PaDcSignInDataVO?>? postSignInWithPhoneDataBase(int userSerial) {
    return Future.value(pADCSignInDataDao.getUserData(userSerial));
  }

  /// Cities
  @override
  Future<List<CityVO?>?>? getCitiesDataBase() {
    return Future.value(cityDao.getCities());
  }

  /// PaymentMethods
  @override
  Future<List<PaymentVO?>?>? getPaymentMethodsDataBase() {
    return Future.value(paymentDao.getPaymentTypes());
  }

  /// Banner
  @override
  Future<List<BannerVO?>?>? getBannersDataBase() {
    return Future.value(bannerDao.getAllBanners());
  }

  /// ComingSoon
  @override
  Future<List<MovieVO?>?>? getComingSoonMovieListDataBase() {
    return Future.value(movieDao
        .getAllMovies()
        ?.where((movie) => movie?.isNowPlaying ?? true)
        .toList());
  }

  /// NowPlaying
  @override
  Future<List<MovieVO?>?>? getNowPlayingMovieListDataBase() {
    return Future.value(movieDao
        .getAllMovies()
        ?.where((movie) => movie?.isComingSoon ?? true)
        .toList());
  }

  /// MovieDetail
  @override
  Future<MovieVO?>? getMovieDetailDataBase(int? movieId) {
    return Future.value(movieDao.getMovieById(movieId));
  }

  /// Casts
  @override
  Future<List<CreditVO?>?> getCastsByMovieDataBase(int movieId) {
    return Future.value(creditDao
        .getCredits(movieId)
        ?.where((credit) => credit.isCasts ?? true)
        .toList());
  }

  /// Crews
  @override
  Future<List<CreditVO?>?> getCrewsByMovieDataBase(int movieId) {
    return Future.value(creditDao
        .getCredits(movieId)
        ?.where((credit) => credit.isCrews ?? true)
        .toList());
  }

  /// CinemaDetail
  @override
  Future<List<CinemaDetailVO?>?>? getCinemaDetailDataBase() {
    return Future.value(cinemaDetailDao.getAllCinemaDetails());
  }

  /// Config
  @override
  Future<List<ConfigTimeSlotVO?>?>? getConfigTimeSlotDataBase() {
    return Future.value(configTimeSlotDao.getConfigs());
  }

  /// SnackCategory
  @override
  Future<List<SnackCategoryVO?>?>? getSnackCategoryDataBase() {
    return Future.value(snackCategoryDao.getSnackCategories());
  }

  /// Snacks
  @override
  Future<List<SnackVO?>?>? getSnacksDataBase() {
    return Future.value(snackDao.getSnacks());
  }

  /// CinemaDayTimeSlots
  @override
  Future<GetCinemasAndDayTimeSlotsResponse?>? getCinemaDayTimeSlotsDataBase(String? dateForKey) {
   return Future.value(cinemaDayTimeSlotDao.getCinemaDayTimeResponseByDate(dateForKey));
  }
}
