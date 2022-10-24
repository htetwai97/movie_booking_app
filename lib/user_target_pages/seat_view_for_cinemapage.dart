import 'package:flutter/material.dart';

import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/food_choices.dart';
import 'package:movie_booking_app/user_target_pages/time_table_view.dart';

class SeatViewForCinema extends StatefulWidget {
  int? movieId;
  int? cinemaIndex;
  String? showTime;
  String dateForCheckOut;
  String dateFormat;
  int? cinemaDayTimeSlotId;
  SeatViewForCinema({
    required this.movieId,
    required this.cinemaIndex,
    required this.showTime,
    required this.dateForCheckOut,
    required this.dateFormat,
    required this.cinemaDayTimeSlotId,
  });

  @override
  State<SeatViewForCinema> createState() => _SeatViewForCinemaState();
}

class _SeatViewForCinemaState extends State<SeatViewForCinema> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      body: Container(
        color: HOME_PAGE_BACKGROUND_ONE,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/screen_cinema_bending.png",
                        ),
                        Positioned(
                            left: 130,
                            right: 130,
                            top: 50,
                            child: Image.asset(
                              "assets/images/screen_text_seat_view.png",
                            ))
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "assets/images/cinema_seats_scrool_view.png",
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Color.fromRGBO(34, 34, 34, 1),
                child: Row(
                  children: [
                    AvailablityCondition(
                      "Availible",
                      Color.fromRGBO(136, 136, 136, 1),
                      Colors.white,
                    ),
                    Spacer(),
                    AvailablityCondition(
                      "Taken",
                      Color.fromRGBO(136, 136, 136, 1),
                      Color.fromRGBO(136, 136, 136, 1),
                    ),
                    Spacer(),
                    AvailablityCondition(
                      "Your Selection",
                      Color.fromRGBO(136, 136, 136, 1),
                      Color.fromRGBO(0, 255, 106, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Image.asset(
                  "assets/images/plus_minus_one.png",
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "2 Tickets",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "17000Ks",
                          style: TextStyle(
                              color: Color.fromRGBO(0, 255, 106, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        )
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FoodAndDrinksPage(
                                      cinemaDayTimeSlotId:
                                          widget.cinemaDayTimeSlotId,
                                      movieId: widget.movieId,
                                      cinemaIndex: widget.cinemaIndex,
                                      showTime: widget.showTime,
                                      dateForCheckOut: widget.dateForCheckOut,
                                      dateFormat: widget.dateFormat,
                                    )));
                      },
                      child: Container(
                        //margin: EdgeInsets.symmetric(horizontal: 50,vertical: 40),
                        child:
                            Image.asset("assets/images/buy_ticket_image.png"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
