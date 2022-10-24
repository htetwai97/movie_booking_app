import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/checkout_data_vo.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/all_done_page.dart';
import 'package:movie_booking_app/user_target_pages/home_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/your_ticket_view_page.dart';

class ConfirmationAndSuccessPage extends StatelessWidget {
  CheckOutDataVO? checkOutData;
  int? cinemaIndex;
  ConfirmationAndSuccessPage({required this.checkOutData,required this.cinemaIndex});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      appBar: AppBar(
        backgroundColor: HOME_PAGE_BACKGROUND_ONE,
        centerTitle: true,
        title: Text(
          "Ticket Confirmation",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        color: HOME_PAGE_BACKGROUND_ONE,
        //padding: EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AllDonePage(checkOutData: checkOutData,cinemaIndex:cinemaIndex)));
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 1.1,
              color: Color.fromRGBO(0, 0, 0, 0.9),
              child: Image.asset(
                "assets/images/text_and_illustration.png",
                //fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        // child: Stack(
        //   children: [
        //     SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           BackGroundBoxYourTicketPage(
        //             "",
        //             "Black Widow",
        //             "(3D) (U/A)",
        //             "JCGV : junction City",
        //             "Screen 2",
        //                 (){},
        //             "",
        //             "",
        //             "",
        //             "",
        //           ),
        //           SizedBox(height: 50),
        //           Image.asset("assets/images/qR_and_pin_(1).png"),
        //           SizedBox(height: 70),
        //           GestureDetector(
        //             onTap: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) =>
        //                           HomeNowShowingAndComingSoonPage()));
        //             },
        //             child: Container(
        //               child: Image.asset("assets/images/done_button.png"),
        //             ),
        //           ),
        //           SizedBox(height: 50),
        //         ],
        //       ),
        //     ),
        //
        //   ],
        // ),
      ),
    );
  }
}
