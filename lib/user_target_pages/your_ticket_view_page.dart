import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/checkout_data_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_detail_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/check_out_page.dart';
import 'package:movie_booking_app/user_target_pages/home_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/ticket_detail_page.dart';
import 'package:movie_booking_app/wigets/bottom_icon_bar.dart';
import 'package:movie_booking_app/wigets/ticket_checkout_reuse.dart';

class YourTicketViewPage extends StatefulWidget {
  CheckOutDataVO? checkOutData;
  int? cinemaIndex;
  YourTicketViewPage({this.checkOutData, this.cinemaIndex});

  @override
  State<YourTicketViewPage> createState() => _YourTicketViewPageState();
}

class _YourTicketViewPageState extends State<YourTicketViewPage> {
  MovieVO? movieVO;
  MovieBookingModelImpl model = MovieBookingModelImpl();
  List<CinemaDetailVO?>? cinemaListDetail;
  @override
  void initState() {
    super.initState();
    /// Movie Detail Network
    model
        .getMovieDetails(widget.checkOutData?.movieId ?? 1408)
        .then((response) {
      setState(() {
        movieVO = response;
        debugPrint(
            "here is checkOutData ====> ${widget.checkOutData.toString()}");
        debugPrint("here is ${widget.cinemaIndex.toString()}");
      });
    });

    /// CinemaDetail DataBase
    model.getCinemaDetailDataBase()?.then((cinemaDetails){
      setState(() {
        cinemaListDetail = cinemaDetails;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: BottomIconsBar(),
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      appBar: AppBar(
        backgroundColor: HOME_PAGE_BACKGROUND_ONE,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomIconsBar()));
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 26,
          ),
        ),
        title: Text(
          "Your Ticket",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        color: HOME_PAGE_BACKGROUND_ONE,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (context, index) {
            return BackGroundBoxYourTicketPage(
                "$IMAGE_BASE_URL${movieVO?.posterPath}",
                "${movieVO?.title}",
                "(3D) (U/A)",
                "${cinemaListDetail?[widget.cinemaIndex ?? 0]?.name}",
                "Screen 2", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TicketDetailPage()));
            },
                "Gold:G-11",
                "${widget.checkOutData?.bookingDate}",
                "${widget.checkOutData?.timeSlot?.startTime}",
                "${cinemaListDetail?[widget.cinemaIndex ?? 0]?.address}");
          },
        ),
      ),
    );
  }
}

class BackGroundBoxYourTicketPage extends StatelessWidget {
  final String image;
  final String oneOne;
  final String oneTwo;
  final String twoOne;
  final String twoTwo;
  String movieDate;
  String movieTime;
  String cinemaAddress;
  final Function onTap;
  String seatNo;
  BackGroundBoxYourTicketPage(
      this.image,
      this.oneOne,
      this.oneTwo,
      this.twoOne,
      this.twoTwo,
      this.onTap,
      this.seatNo,
      this.movieDate,
      this.movieTime,
      this.cinemaAddress);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            margin: EdgeInsets.only(top: 30, left: 24, right: 24),
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                      height: 122,
                      width: 100,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TicketCheckOutDoneCombineFirstLineText(oneOne, oneTwo),
                        SizedBox(height: 16),
                        TicketCheckOutDoneCombineSecondLineText(twoOne, twoTwo),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            MticketFormat(
                                Color.fromRGBO(170, 170, 170, 1), "M-Ticket("),
                            MticketFormat(Color.fromRGBO(0, 255, 106, 1), "2"),
                            MticketFormat(
                                Color.fromRGBO(170, 170, 170, 1), ")"),
                          ],
                        ),
                        SizedBox(height: 16),
                        //GoldTicketAndPrice(),
                        Text(
                          seatNo,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Image.asset("assets/icons/long_line.png"),
                SizedBox(height: 30),
                TicketCheckOutPayDoneCombine(
                    movieDate, movieTime, cinemaAddress),
              ],
            ),
          ),
          Positioned(
            top: 182,
            left: 1,
            child: Container(
              height: 30,
              width: 40,
              decoration: BoxDecoration(
                color: HOME_PAGE_BACKGROUND_ONE,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 182,
            right: 1,
            child: Container(
              height: 30,
              width: 40,
              decoration: BoxDecoration(
                color: HOME_PAGE_BACKGROUND_ONE,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
