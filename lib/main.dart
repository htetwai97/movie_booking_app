import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/banner_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_detail_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/city_vo.dart';
import 'package:movie_booking_app/data/vos/collection_vo.dart';
import 'package:movie_booking_app/data/vos/config_time_slot_vo.dart';
import 'package:movie_booking_app/data/vos/credits_vo.dart';
import 'package:movie_booking_app/data/vos/facility_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/padc_sign_in_data_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/production_company_vo.dart';
import 'package:movie_booking_app/data/vos/production_country_vo.dart';
import 'package:movie_booking_app/data/vos/snack_category_list_vo.dart';
import 'package:movie_booking_app/data/vos/snack_item_vo.dart';
import 'package:movie_booking_app/data/vos/spoken_language_vo.dart';
import 'package:movie_booking_app/data/vos/time_slot_vo.dart';
import 'package:movie_booking_app/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:movie_booking_app/network/responses/get_cinemas_and_its_timeslots_response.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';
import 'package:movie_booking_app/user_target_pages/about_coming_soon.dart';
import 'package:movie_booking_app/user_target_pages/about_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/all_done_page.dart';
import 'package:movie_booking_app/user_target_pages/check_out_page.dart';
import 'package:movie_booking_app/user_target_pages/cinema_detail_page.dart';
import 'package:movie_booking_app/user_target_pages/cinema_search_page.dart';
import 'package:movie_booking_app/user_target_pages/confirmation_success_page.dart';
import 'package:movie_booking_app/user_target_pages/food_choices.dart';
import 'package:movie_booking_app/user_target_pages/google_sign_in_page.dart';
//import 'package:movie_booking_app/user_target_pages/about_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/home_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/location_page.dart';
import 'package:movie_booking_app/user_target_pages/login_or_sign_up.dart';
import 'package:movie_booking_app/user_target_pages/logo_page.dart';
import 'package:movie_booking_app/user_target_pages/payment_page.dart';
import 'package:movie_booking_app/user_target_pages/search_coming_soon_page.dart';
//import 'package:movie_booking_app/user_target_pages/search_now_showing_page.dart';
import 'package:movie_booking_app/user_target_pages/seat_view_for_cinemapage.dart';
import 'package:movie_booking_app/user_target_pages/ticket_detail_page.dart';
import 'package:movie_booking_app/user_target_pages/time_table_view.dart';
import 'package:movie_booking_app/user_target_pages/varify_Phone_num.dart';
import 'package:movie_booking_app/user_target_pages/send_otp_code.dart';
import 'package:movie_booking_app/user_target_pages/your_ticket_view_page.dart';
import 'package:movie_booking_app/wigets/bottom_icon_bar.dart';
import 'package:movie_booking_app/wigets/terms_and_condition.dart';
//import 'package:movie_booking_app/user_target_pages/payment_page.dart';
//import 'package:movie_booking_app/user_target_pages/search_coming_soon_page.dart';
//import 'package:movie_booking_app/user_target_pages/search_now_showing_page.dart';

void main() async {
  await Hive.initFlutter();

  /// register
  Hive.registerAdapter(PaDcSignInDataVOAdapter());
  Hive.registerAdapter(CityVOAdapter());
  Hive.registerAdapter(PaymentVOAdapter());
  Hive.registerAdapter(BannerVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(CreditVOAdapter());
  Hive.registerAdapter(CinemaDetailVOAdapter());
  Hive.registerAdapter(ConfigTimeSlotVOAdapter());
  Hive.registerAdapter(FacilityVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());
  Hive.registerAdapter(SnackCategoryVOAdapter());
  Hive.registerAdapter(SnackVOAdapter());
  Hive.registerAdapter(TimeSlotVOAdapter());
  Hive.registerAdapter(CinemaVOAdapter());
  Hive.registerAdapter(GetCinemasAndDayTimeSlotsResponseAdapter());

  /// box opening
  await Hive.openBox<PaDcSignInDataVO>(BOX_NAME_PADC_SIGN_IN_DATA_VO);
  await Hive.openBox<CityVO>(BOX_NAME_CITY_VO);
  await Hive.openBox<PaymentVO>(BOX_NAME_PAYMENT_METHODS_VO);
  await Hive.openBox<BannerVO>(BOX_NAME_BANNER_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<CreditVO>(BOX_NAME_CREDIT_VO);
  await Hive.openBox<CinemaDetailVO>(BOX_NAME_CINEMA_DETAIL_VO);
  await Hive.openBox<ConfigTimeSlotVO>(BOX_NAME_CONFIG_TIME_SLOT_VO);
  await Hive.openBox<SnackCategoryVO>(BOX_NAME_SNACK_CATEGORY_VO);
  await Hive.openBox<SnackVO>(BOX_NAME_SNACK_ITEM_VO);
  await Hive.openBox<CinemaVO>(BOX_NAME_CINEMA_VO);
  await Hive.openBox<GetCinemasAndDayTimeSlotsResponse>(
      BOX_NAME_GET_CINEMA_TIMESLOT_RESPONSE);

  MovieBookingModelImpl().getCinemaDetail();
  MovieBookingModelImpl().getTimeSlotConfig();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogoPage(),
    );
  }
}
