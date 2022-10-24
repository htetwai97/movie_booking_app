import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/home_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/location_page.dart';
import 'package:movie_booking_app/user_target_pages/varify_Phone_num.dart';
import 'package:movie_booking_app/wigets/bottom_icon_bar.dart';

class LogoPage extends StatefulWidget {
  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  MovieBookingModel model = MovieBookingModelImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      body: Container(
        color: HOME_PAGE_BACKGROUND_ONE,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  /// Database
                  // model
                  //     .postSignInWithPhoneDataBase(1)
                  //     ?.then((userData) {
                  //       userDataPersistence = userData;
                  //   if (userDataPersistence?.token != null) {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => BottomIconsBar()));
                  //   }
                    //else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VarifyPhoneNoPage()));
                   // }
                 // });
                  debugPrint("${userDataPersistence?.token.toString()}");

                },
                child: Container(
                  margin: EdgeInsets.only(top: 240),
                  child: Image.asset(
                    "assets/icons/logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 220),
              DotsIndicator(
                dotsCount: 4,
                position: 0,
                decorator: DotsDecorator(
                  color: MAIN_SCREEN_BANNER_DOTS_INDICATOR_INACTIVE,
                  activeColor: MAIN_SCREEN_SELECTED_BOTTOM_BAR_COLOR,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
