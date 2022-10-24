import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/checkout_data_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_detail_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/padc_sign_in_data_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/home_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/your_ticket_view_page.dart';
import 'package:movie_booking_app/wigets/bottom_icon_bar.dart';

class AllDonePage extends StatefulWidget {
  CheckOutDataVO? checkOutData;
  int? cinemaIndex;
  AllDonePage({required this.checkOutData, required this.cinemaIndex});

  @override
  State<AllDonePage> createState() => _AllDonePageState();
}

class _AllDonePageState extends State<AllDonePage> {
  MovieVO? movieVO;
  MovieBookingModelImpl model = MovieBookingModelImpl();
  List<CinemaDetailVO?>? cinemaListDetail;
  @override
  void initState() {
    super.initState();

    /// MovieDetail Network
    model
        .getMovieDetails(widget.checkOutData?.movieId ?? 1408)
        .then((response) {
      setState(() {
        movieVO = response;
        debugPrint(
            "here is checkOutData ====> ${widget.checkOutData.toString()}");
      });
    });


    /// CinemaDetail DataBase
    model.getCinemaDetailDataBase()?.then((cinemaDetails) {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              BackGroundBoxYourTicketPage(
                  "$IMAGE_BASE_URL${movieVO?.posterPath}",
                  "${movieVO?.title}",
                  "",
                  "${cinemaListDetail?[widget.cinemaIndex ?? 0]?.name}",
                  "Screen 2",
                  () {},
                  "Gold:G-11",
                  "${widget.checkOutData?.bookingDate}",
                  "${widget.checkOutData?.timeSlot?.startTime}",
                  "${cinemaListDetail?[widget.cinemaIndex ?? 0]?.address}"),
              SizedBox(height: 50),
              Container(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    "https://tmba.padc.com.mm/${widget.checkOutData?.qrCode}",
                    fit: BoxFit.fill,
                  )),
              SizedBox(height: 70),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomIconsBar()));
                },
                child: Container(
                  child: Image.asset("assets/images/done_button.png"),
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
