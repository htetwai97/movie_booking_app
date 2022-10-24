import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema_detail_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/home_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/payment_page.dart';
import 'package:movie_booking_app/user_target_pages/ticket_detail_page.dart';
import 'package:movie_booking_app/wigets/quantity_price_controller.dart';
import 'package:movie_booking_app/wigets/ticket_cancel_view.dart';

class CheckOutPage extends StatefulWidget {
  SelectedSnackController snackController;
  int? movieId;
  int? cinemaIndex;
  String? showTime;
  String? dateForCheckOut;
  String dateFormat;
  int? cinemaDayTimeSlotId;
  CheckOutPage({
    required this.movieId,
    required this.cinemaIndex,
    required this.showTime,
    required this.snackController,
    required this.dateForCheckOut,
    required this.dateFormat,
    required this.cinemaDayTimeSlotId,
  });

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  MovieVO? mMovie;
  int ticketFee = 1600;
  int conVenienceFee = 10;
  List<CinemaDetailVO?>? cinemaListDetail;
  @override
  void initState() {
    super.initState();

    /// MovieDetail Network
    mMovieBookingModel.getMovieDetails(widget.movieId ?? 499999).then((movie) {
      setState(() {
        mMovie = movie;
      });
    }).catchError(
        (error) => debugPrint("Error is ==============> ${error.toString()}"));

    /// CinemaDetail DataBase
    mMovieBookingModel.getCinemaDetailDataBase()?.then((cinemaDetails){
      setState(() {
        cinemaListDetail = cinemaDetails;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HOME_PAGE_BACKGROUND_ONE,
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
          "Checkout",
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
                Stack(children: [
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
                            "${mMovie?.title}", "(3D) (U/A)"),
                        SizedBox(height: 16),
                        TicketCheckOutDoneCombineSecondLineText(
                            "${cinemaListDetail?[widget.cinemaIndex!]?.name}",
                            "SCREEN 2"),
                        SizedBox(height: 30),
                        SizedBox(
                          height: 120,
                          child: Row(
                            children: [
                              Expanded(
                                child: CheckOutIconsRow(
                                    Icons.date_range_outlined,
                                    widget.dateFormat),
                              ),
                              //Spacer(),
                              Expanded(
                                child: CheckOutIconsRow(
                                    Icons.watch_later_outlined,
                                    "${widget.showTime}"),
                              ),
                              //Spacer(),
                              Expanded(
                                child: CheckOutIconsRow(Icons.location_on,
                                    "${cinemaListDetail?[widget.cinemaIndex!]?.address}"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            MticketFormat(
                                Color.fromRGBO(170, 170, 170, 1), "M-Ticket("),
                            MticketFormat(Color.fromRGBO(0, 255, 106, 1), "2"),
                            MticketFormat(
                                Color.fromRGBO(170, 170, 170, 1), ")"),
                          ],
                        ),
                        SizedBox(height: 10),
                        GoldTicketAndPrice(
                          seatNumber: "Gold-G8,G9",
                          seatPrice: "${ticketFee}",
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 1,
                          color: Color.fromRGBO(136, 136, 136, 1),
                        ),
                        SizedBox(height: 20),
                        FoodAndBeveragePriceRowView(
                          foodTotalPrice:
                              "${widget.snackController.totalPrice} MMK",
                        ),
                        SizedBox(height: 25),
                        FoodCharges(
                          snackController: widget.snackController,
                          onTap: (index) {
                            setState(() {
                              widget.snackController.reduceSnack(widget
                                  .snackController.selectedSnackList![index]!);
                            });
                          },
                        ),
                        SizedBox(height: 30),
                        Image.asset(
                          "assets/icons/long_line.png",
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 30),
                        ConvienceFee(convenienceFee: "$conVenienceFee MMK"),
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
                              "${ticketFee + conVenienceFee + widget.snackController.totalPrice} MMK",
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
                ]),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentPage(
                                cinemaIndex: widget.cinemaIndex,
                                cinemaDayTimeSlotId: widget.cinemaDayTimeSlotId,
                                dateForCheckOut: widget.dateForCheckOut,
                                movieId: widget.movieId,
                                snackController: widget.snackController)));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                    child: Image.asset("assets/icons/Continue btn.png"),
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

class FoodCharges extends StatefulWidget {
  SelectedSnackController snackController;
  Function(int index) onTap;
  FoodCharges({required this.snackController, required this.onTap});

  @override
  State<FoodCharges> createState() => _FoodChargesState();
}

class _FoodChargesState extends State<FoodCharges> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.snackController.selectedSnackList?.length,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: GestureDetector(
                onTap: () {
                  widget.onTap(index);
                },
                child: Icon(
                  Icons.do_not_disturb_on_total_silence,
                  color: Color.fromRGBO(0, 255, 106, 1),
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              "${widget.snackController.selectedSnackList?[index]?.name} (Qty ${widget.snackController.selectedSnackList?[index]?.quantity})",
              style: TextStyle(
                  color: Color.fromRGBO(136, 136, 136, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
            Spacer(),
            Text(
              "${widget.snackController.selectedSnackList?[index]?.price} MMK",
              style: TextStyle(
                  color: Color.fromRGBO(136, 136, 136, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class ConvienceFee extends StatelessWidget {
  String convenienceFee;
  ConvienceFee({required this.convenienceFee});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Convenience Fee",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
        ),
        Spacer(),
        Text(
          convenienceFee,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class TicketCancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => TicketCancellationPolicyBoxView());
      },
      child: Container(
        width: 220,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 107, 0, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            SizedBox(width: 6),
            Text(
              "Ticket Cancelion Policy",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodAndBeveragePriceRowView extends StatelessWidget {
  String foodTotalPrice;
  FoodAndBeveragePriceRowView({required this.foodTotalPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.fastfood_outlined,
          color: Colors.white,
        ),
        SizedBox(width: 3),
        Text(
          "Food and Beverage",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Spacer(),
        Text(
          foodTotalPrice,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class GoldTicketAndPrice extends StatelessWidget {
  String seatNumber;
  String seatPrice;
  GoldTicketAndPrice({required this.seatNumber, required this.seatPrice});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          seatNumber,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Spacer(),
        Text(
          seatPrice,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class MticketFormat extends StatelessWidget {
  final Color color;
  final String text;
  MticketFormat(this.color, this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}

class TicketCheckOutDoneCombineSecondLineText extends StatelessWidget {
  final textSecondOne;
  final textSecondTwo;
  TicketCheckOutDoneCombineSecondLineText(
      this.textSecondOne, this.textSecondTwo);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          textSecondOne,
          style: TextStyle(
            color: Color.fromRGBO(0, 255, 106, 1),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        SizedBox(width: 6),
        Text(
          textSecondTwo,
          style: TextStyle(
              color: Color.fromRGBO(170, 170, 170, 1),
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class TicketCheckOutDoneCombineFirstLineText extends StatelessWidget {
  final String textFirstOne;
  final String textFirstTwo;
  TicketCheckOutDoneCombineFirstLineText(this.textFirstOne, this.textFirstTwo);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          textFirstOne,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        Text(
          textFirstTwo,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class CheckOutIconsRow extends StatelessWidget {
  final IconData icon;
  final String text;
  CheckOutIconsRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Color.fromRGBO(0, 255, 106, 1),
        ),
        SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
