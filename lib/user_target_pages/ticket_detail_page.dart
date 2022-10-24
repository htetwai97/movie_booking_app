import 'package:flutter/material.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/check_out_page.dart';
import 'package:movie_booking_app/wigets/quantity_price_controller.dart';
import 'package:movie_booking_app/wigets/ticket_checkout_reuse.dart';

class TicketDetailPage extends StatelessWidget {
  SelectedSnackController snackController = SelectedSnackController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      appBar: AppBar(
        backgroundColor: HOME_PAGE_BACKGROUND_ONE,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 26,
          ),
        ),
        title: Text(
          "Ticket Detail",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        color: HOME_PAGE_BACKGROUND_ONE,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(68, 68, 68, 1),
                        Color.fromRGBO(34, 34, 34, 1),
                        Color.fromRGBO(68, 68, 68, 1),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TicketCheckOutDoneCombineFirstLineText(
                          "Black Widow", "(3D) (U/A)"),
                      SizedBox(height: 16),
                      TicketCheckOutDoneCombineSecondLineText(
                          "JCGV : junction City", "SCREEN 2"),
                      SizedBox(height: 30),
                      TicketCheckOutPayDoneCombine("","",""),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          MticketFormat(
                              Color.fromRGBO(170, 170, 170, 1), "M-Ticket("),
                          MticketFormat(Color.fromRGBO(0, 255, 106, 1), "2"),
                          MticketFormat(Color.fromRGBO(170, 170, 170, 1), ")"),
                        ],
                      ),
                      SizedBox(height: 10),
                      GoldTicketAndPrice(seatNumber: "Gold-G8,G9",seatPrice: "20000Ks",),
                      SizedBox(height: 20),
                      Container(
                        height: 1,
                        color: Color.fromRGBO(136, 136, 136, 1),
                      ),
                      SizedBox(height: 20),
                      FoodAndBeveragePriceRowView(foodTotalPrice: "",),
                      SizedBox(height: 25),
                      FoodCharges(snackController: snackController,onTap: (index){},),
                      SizedBox(height: 30),
                      Image.asset(
                        "assets/icons/long_line.png",
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 30),
                      ConvienceFee(convenienceFee: "500 MMK",),
                      SizedBox(
                        height: 20,
                      ),
                      TicketCancelButton(),
                      SizedBox(height: 30),
                      Container(
                        height: 1,
                        color: Color.fromRGBO(136, 136, 136, 1),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 255, 106, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "22500Ks",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 255, 106, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Refund Amount",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "15000Ks",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 46, 0, 1),
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          )
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          //margin: EdgeInsets.symmetric(horizontal: 50,vertical: 40),
                          child: Image.asset("assets/icons/Buy button.png"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


