import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/checkout_data_vo.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/resourses/dimens_resources.dart';
import 'package:movie_booking_app/resourses/string_resourses.dart';
import 'package:movie_booking_app/user_target_pages/cinema_search_page.dart';
import 'package:movie_booking_app/user_target_pages/home_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/login_or_sign_up.dart';
import 'package:movie_booking_app/user_target_pages/time_table_view.dart';
import 'package:movie_booking_app/user_target_pages/your_ticket_view_page.dart';

class BottomIconsBar extends StatefulWidget {
  CheckOutDataVO? checkOutData;
  int? cinemaIndex;
  BottomIconsBar({ this.cinemaIndex, this.checkOutData});
  @override
  State<BottomIconsBar> createState() => _BottomIconsBarState();
}

class _BottomIconsBarState extends State<BottomIconsBar> {
  CheckOutDataVO? checkOutData1;
  int? cinemaIndex1;

  int currentIndex = 0;
  void onTapBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  late List<Widget> screens = [];

  @override
  void initState(){
    super.initState();
    setState(() {
      checkOutData1 = widget.checkOutData;
      cinemaIndex1 = widget.cinemaIndex;
      //debugPrint("here is bottom index===> ${widget.cinemaIndex}");
      //debugPrint("here is bottom checkout===> ${widget.checkOutData}");
    });
    screens = [
      HomeNowShowingAndComingSoonPage(),
      TimeTablePage(movieId: null,),
      YourTicketViewPage(checkOutData:checkOutData1,cinemaIndex:cinemaIndex1),
      LoginOrSignUpPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: HOME_PAGE_BACKGROUND_ONE,
        currentIndex: currentIndex,
        onTap: onTapBar,
        unselectedLabelStyle: TextStyle(
          color: MAIN_SCREEN_UNSELECTED_BOTTOM_BAR_COLOR,
          fontWeight: FontWeight.w500,
          fontSize: TEXT_ICON_REGULAR_1,
        ),
        selectedLabelStyle: TextStyle(
          color: MAIN_SCREEN_SELECTED_BOTTOM_BAR_COLOR,
          fontWeight: FontWeight.w500,
          fontSize: TEXT_ICON_REGULAR_1,
        ),
        selectedItemColor: MAIN_SCREEN_SELECTED_BOTTOM_BAR_COLOR,
        unselectedItemColor: MAIN_SCREEN_UNSELECTED_BOTTOM_BAR_COLOR,
        items: [
          BottomNavigationBarItem(
            backgroundColor: HOME_PAGE_BACKGROUND_ONE,
            icon: Image.asset(
              "assets/icons/movie_icon_real.png",
            ),
            label: MAIN_SCREEN_BOTTOM_TEXT_1,
          ),
          BottomNavigationBarItem(
            backgroundColor: HOME_PAGE_BACKGROUND_ONE,
            icon: Image.asset("assets/icons/cinema_image.png"),
            label: MAIN_SCREEN_BOTTOM_TEXT_2,
          ),
          BottomNavigationBarItem(
            backgroundColor: HOME_PAGE_BACKGROUND_ONE,
            icon: Image.asset("assets/icons/botnavbar_ticket.png"),
            label: MAIN_SCREEN_BOTTOM_TEXT_3,
          ),
          BottomNavigationBarItem(
            backgroundColor: HOME_PAGE_BACKGROUND_ONE,
            icon: Image.asset("assets/icons/botnavbar_profile.png"),
            label: MAIN_SCREEN_BOTTOM_TEXT_4,
          ),
        ],
      ),
    );
  }
}
