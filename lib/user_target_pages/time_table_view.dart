import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema_detail_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/config_time_slot_vo.dart';
import 'package:movie_booking_app/data/vos/time_slot_status_vo.dart';
import 'package:movie_booking_app/data/vos/time_slot_vo.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/temporary_data/temporary_time_table.dart';
import 'package:movie_booking_app/user_target_pages/about_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/cinema_detail_page.dart';
import 'package:movie_booking_app/user_target_pages/cinema_search_page.dart';
import 'package:movie_booking_app/user_target_pages/seat_view_for_cinemapage.dart';
import 'package:movie_booking_app/wigets/parking_food_wheelchair.dart';
import 'package:movie_booking_app/wigets/select_date_list_view.dart';

class TimeTablePage extends StatefulWidget {
  int page;
  int? movieId;
  String? dateForCheckOut;
  int? cinemaIndex = 0;
  String dateFormat = "";
  TimeTablePage({this.page = 0, required this.movieId});

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

MovieBookingModel model = MovieBookingModelImpl();

class _TimeTablePageState extends State<TimeTablePage> {
  List<CinemaVO?>? cinemaList;
  List<CinemaDetailVO?>? cinemaListById;
  List<String?>? dateList = [];
  List<SelectDate?>? selectedDateList = [];
  List timeSlotStatusList = [];

  @override
  void initState() {
    super.initState();
    selectedDateList?.add(SelectDate(true));
    selectedDateList?.add(SelectDate(false));

    selectedDateList?.add(SelectDate(false));
    selectedDateList?.add(SelectDate(false));

    selectedDateList?.add(SelectDate(false));
    selectedDateList?.add(SelectDate(false));

    selectedDateList?.add(SelectDate(false));
    selectedDateList?.add(SelectDate(false));

    selectedDateList?.add(SelectDate(false));
    selectedDateList?.add(SelectDate(false));

    selectedDateList?.add(SelectDate(false));
    selectedDateList?.add(SelectDate(false));

    selectedDateList?.add(SelectDate(false));
    selectedDateList?.add(SelectDate(false));

    for (int i = 0; i < 14; i++) {
      DateTime days = DateTime.now().add(Duration(days: i));
      String? d = DateFormat("yyyy-MM-dd").format(days);
      dateList?.add(d);
    }

    /// Cinema Day Time Slot Network InitState
    model
        .getCinemaDayTimeSlots(DateFormat("yyyy-MM-dd").format(DateTime.now()))
        ?.then((response) {
      setState(() {
        cinemaList = response?.data;
      });
    });
    widget.dateForCheckOut = DateFormat("yyyy-MM-dd").format(DateTime.now());

    /// Config DataBase
    model.getConfigTimeSlotDataBase()?.then((configList) {
      setState(() {
        timeSlotStatusList = configList?[1]?.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      appBar: AppBar(
        backgroundColor: HOME_PAGE_BACKGROUND_ONE,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AboutNowShowingPage(
                        page: widget.page, movieId: widget.movieId)));
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 24,
          ),
        ),
        actions: [
          Icon(
            Icons.navigation_rounded,
          ),
          SizedBox(
            width: 4,
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Yangon",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CinemaSearchPage(
                            dateFormat: widget.dateFormat,
                            movieId: widget.movieId,
                            cinemaIndex: widget.cinemaIndex,
                            dateForCheckOut: "${widget.dateForCheckOut}",
                          )));
            },
            child: Icon(
              Icons.search,
              size: 28,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Icon(
            Icons.filter_alt,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
        color: HOME_PAGE_BACKGROUND_ONE,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingDateBoxesScrollList(
                callBack: (dateCheckOut, dateFormat, index, selectedDateList) {
                  /// Network
                  model.getCinemaDayTimeSlots(dateCheckOut)?.then((response) {
                    setState(() {
                      cinemaList = response?.data;
                    });
                  });

                  /// Database
                  model
                      .getCinemaDayTimeSlotsDataBase(dateCheckOut)
                      ?.then((responseDataBase) {
                    setState(() {
                      cinemaList = responseDataBase?.data;

                      /// call back values assign
                      selectedDateList?.forEach((element) {
                        element?.isSelected = false;
                      });
                      selectedDateList?[index]?.isSelected = true;
                      widget.dateForCheckOut = dateCheckOut;
                      widget.dateFormat = dateFormat;
                    });
                  });
                },
                dateForCheckOut: "${widget.dateForCheckOut}",
                selectedDateList: selectedDateList,
                dates: dateList,
                cinemaList: cinemaList,
              ),
              MovieQualityView(),
              SizedBox(height: 10),
              ColorfulAvailiblityView(),
              SizedBox(height: 10),
              Container(
                height: 1000,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cinemaList?.length,
                  itemBuilder: (context, index) {
                    return CinemasChoicesExpandsionTiles(
                      timeSlotStatusList: timeSlotStatusList,
                      dateFormat: widget.dateFormat,
                      cinemaIndex: widget.cinemaIndex,
                      movieId: widget.movieId,
                      cinema: cinemaList?[index],
                      dateForCheckOut: "${widget.dateForCheckOut}",
                      onTapSeeDetail: (cinemaId) {
                        widget.cinemaIndex = cinemaId! - 1;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CinemaDetailPage(
                                      cinemaId: cinemaId,
                                      cinemaIndex: widget.cinemaIndex,
                                    )));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CinemasChoicesExpandsionTiles extends StatefulWidget {
  final CinemaVO? cinema;
  final Function(int?) onTapSeeDetail;
  int? movieId;
  int? cinemaIndex;
  String dateForCheckOut;
  String dateFormat;
  List timeSlotStatusList;

  CinemasChoicesExpandsionTiles({
    required this.onTapSeeDetail,
    required this.cinema,
    required this.movieId,
    required this.cinemaIndex,
    required this.dateForCheckOut,
    required this.dateFormat,
    required this.timeSlotStatusList,
  });

  @override
  State<CinemasChoicesExpandsionTiles> createState() =>
      _CinemasChoicesExpandsionTilesState();
}

class _CinemasChoicesExpandsionTilesState
    extends State<CinemasChoicesExpandsionTiles> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: GestureDetector(
        onTap: () {
          widget.onTapSeeDetail(widget.cinema?.cinemaId);
        },
        child: Text(
          "See Detail",
          style: TextStyle(
            color: Colors.green,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      title: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Text(
          "${widget.cinema?.cinema}",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      subtitle: ParkingFoodWheelChair(),
      children: [
        SizedBox(
          height: 150,
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.cinema?.timeSlots?.length,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                mainAxisExtent: 110,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return CinemaTimeTableAndTheatreBox(
                dateFormat: widget.dateFormat,
                dateForCheckOut: widget.dateForCheckOut,
                cinemaIndex: widget.cinemaIndex,
                movieId: widget.movieId,
                timeSlot: widget.cinema?.timeSlots?[index],
                timeSlotStatusList: widget.timeSlotStatusList,
              );
            },
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                Icons.info,
                size: 18,
                color: Colors.grey,
              ),
              SizedBox(width: 4),
              GestureDetector(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) => GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset("assets/images/seat_prices.png")));
                },
                child: Text(
                  "Long press on show timing to see seat class!",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}

class CinemaTimeTableAndTheatreBox extends StatefulWidget {
  TimeSlotVO? timeSlot;
  int? movieId;
  int? cinemaIndex;
  String dateForCheckOut;
  String dateFormat;
  List timeSlotStatusList;
  //= modelTimeSlotConfig?[1]?.value;

  CinemaTimeTableAndTheatreBox({
    required this.timeSlot,
    required this.movieId,
    required this.cinemaIndex,
    required this.dateForCheckOut,
    required this.dateFormat,
    required this.timeSlotStatusList,
  });

  @override
  State<CinemaTimeTableAndTheatreBox> createState() =>
      _CinemaTimeTableAndTheatreBoxState();
}

class _CinemaTimeTableAndTheatreBoxState
    extends State<CinemaTimeTableAndTheatreBox> {
  String? showTime = "9:30 AM";
  int? cinemaDayTimeSlotId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showTime = "${widget.timeSlot?.startTime}";
        cinemaDayTimeSlotId = widget.timeSlot?.cinemaDayTimeSlotId;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SeatViewForCinema(
                    cinemaDayTimeSlotId: cinemaDayTimeSlotId,
                    movieId: widget.movieId,
                    cinemaIndex: widget.cinemaIndex,
                    showTime: showTime,
                    dateForCheckOut: widget.dateForCheckOut,
                    dateFormat: widget.dateFormat)));
        debugPrint(widget.dateForCheckOut);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        height: 92,
        width: 95,
        decoration: BoxDecoration(
          color: (widget.timeSlot?.status == 1)
              ? Color(int.parse("${widget.timeSlotStatusList[0]?["color"]}"
                  .replaceFirst("#", "0x1A")))
              : (widget.timeSlot?.status == 2)
                  ? Color(int.parse("${widget.timeSlotStatusList[1]?["color"]}"
                      .replaceFirst("#", "0x1A")))
                  : (widget.timeSlot?.status == 3)
                      ? Color(int.parse(
                          "${widget.timeSlotStatusList[2]?["color"]}"
                              .replaceFirst("#", "0x1A")))
                      : Colors.red,

          // color: Color.fromRGBO(0, 255, 163, 0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Color.fromRGBO(0, 255, 163, 1),
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${widget.timeSlot?.startTime}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "2D,3D",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Screen 2",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                (widget.timeSlot?.status == 1)
                    ? "${widget.timeSlotStatusList[0]?["title"]}"
                    : (widget.timeSlot?.status == 2)
                        ? "${widget.timeSlotStatusList[1]?["title"]}"
                        : (widget.timeSlot?.status == 3)
                            ? "${widget.timeSlotStatusList[2]?["title"]}"
                            : "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeatsSituation extends StatelessWidget {
  const SeatsSituation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
      color: HOME_PAGE_BACKGROUND_ONE,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingText(),
            ClassAndPriceOfSeats("Normal", "4500Ks"),
            ClassAndPriceOfSeats("Executive", "6500Ks"),
            ClassAndPriceOfSeats("Premium", "8000"),
            ClassAndPriceOfSeats("Gold", "10000Ks"),
            ClassAndPriceOfSeats("Couple", "Ban"),
            ClassAndPriceOfSeats("VIP Superior", "250000Ks"),
            Container(
              margin: EdgeInsets.only(left: 40),
              child: Image.asset("assets/images/sofa_image.png"),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassAndPriceOfSeats extends StatelessWidget {
  final String seatClass;
  final String thatPrice;
  ClassAndPriceOfSeats(this.seatClass, this.thatPrice);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Row(
          children: [
            CommonTextStyleForClassAndPrice(seatClass),
            Spacer(),
            CommonTextStyleForClassAndPrice(thatPrice),
          ],
        ),
      ],
    );
  }
}

class CommonTextStyleForClassAndPrice extends StatelessWidget {
  final String classOrPrice;
  CommonTextStyleForClassAndPrice(this.classOrPrice);
  @override
  Widget build(BuildContext context) {
    return Text(
      classOrPrice,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "JCGV : Junction City\n(Screen2)",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          "12:30pm",
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

class CinemasListView extends StatelessWidget {
  final IconData? icon;
  final String text;
  CinemasListView(this.text, this.icon);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "JCGV : Junction City",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.all(
                12,
              ),
              child: Text(
                "See Details",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromRGBO(0, 255, 106, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color.fromRGBO(170, 170, 170, 1),
                    )),
                child: Icon(
                  icon,
                  size: 12,
                  color: Color.fromRGBO(170, 170, 170, 1),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                text,
                style: TextStyle(
                    color: Color.fromRGBO(170, 170, 170, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        )
      ],
    );
  }
}

typedef void StringCallBack(
  String? dateForCheckOut,
  String dateFormat,
  int index,
  List<SelectDate?>? selectedDateList,
);

class BookingDateBoxesScrollList extends StatefulWidget {
  List<String?>? dates;
  List<CinemaVO?>? cinemaList;
  List<SelectDate?>? selectedDateList;
  String dateForCheckOut;
  StringCallBack callBack;

  BookingDateBoxesScrollList({
    required this.dates,
    required this.cinemaList,
    required this.selectedDateList,
    required this.dateForCheckOut,
    required this.callBack,
  });
  @override
  State<BookingDateBoxesScrollList> createState() =>
      _BookingDateBoxesScrollListState();
}

class _BookingDateBoxesScrollListState
    extends State<BookingDateBoxesScrollList> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(8),
      height: 116,
      child: ListView.builder(
        itemCount: widget.selectedDateList?.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          var dateSelected = currentDate.add(Duration(days: index));
          String dateFormat =
              DateFormat("EEEE,d MMM, yyyy").format(dateSelected);
          return InkWell(
            onTap: () {
              widget.callBack(
                widget.dates?[index],
                dateFormat,
                index,
                widget.selectedDateList,
              );

              // model.getCinemaDayTimeSlots(widget.dates?[index])
              //     ?.then((response) {
              //   setState(() {
              //     widget.selectedDateList?.forEach((element) {
              //       element?.isSelected = false;
              //     });
              //     widget.selectedDateList?[index]?.isSelected = true;
              //     widget.cinemaList = response?.data;
              //   });
              // });
            },
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 16),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 4,
                    bottom: 8,
                  ),
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    color: (widget.selectedDateList?[index]?.isSelected == true)
                        ? Color.fromRGBO(0, 255, 163, 1)
                        : Colors.white,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: HOME_PAGE_BACKGROUND_ONE,
                          ),
                          height: 4,
                          width: 20,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${dateSelected.day}",
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "OCT",
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          child: Text(
                            dateFormat.substring(0, 3),
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: -6,
                  top: 66,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HOME_PAGE_BACKGROUND_ONE,
                      //color: Colors.green,
                    ),
                  ),
                ),
                Positioned(
                  right: 9.5,
                  top: 65,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HOME_PAGE_BACKGROUND_ONE,
                      //color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          );

          //   BookingDateBoxDetailCompose(
          //     index,
          //     widget.dates,
          //     dateSelected,
          //     widget.cinemaList,
          //     widget.selectedDateList,
          //     dateFormat,
          //     widget.dateForCheckOut,
          // )
        }),
      ),
    );
  }
}

class BookingDateBoxDetailCompose extends StatefulWidget {
  DateTime dateForChoice;
  int index;
  List<String?>? dates;
  List<CinemaVO?>? cinemaList;
  List<SelectDate?>? selectedDateList;
  String dateFormat;
  String dateForCheckOut;

  BookingDateBoxDetailCompose(
    this.index,
    this.dates,
    this.dateForChoice,
    this.cinemaList,
    this.selectedDateList,
    this.dateFormat,
    this.dateForCheckOut,
  );

  @override
  State<BookingDateBoxDetailCompose> createState() =>
      _BookingDateBoxDetailComposeState();
}

class _BookingDateBoxDetailComposeState
    extends State<BookingDateBoxDetailCompose> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        model
            .getCinemaDayTimeSlots(widget.dates?[widget.index])
            ?.then((response) {
          setState(() {
            widget.dateForCheckOut = "${widget.dates?[widget.index]}";
            debugPrint(widget.dateForCheckOut);

            widget.selectedDateList?.forEach((element) {
              element?.isSelected = false;
            });
            widget.selectedDateList?[widget.index]?.isSelected = true;
            widget.cinemaList = response?.data;
          });
        });
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 4,
              bottom: 8,
            ),
            width: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                8,
              ),
              color:
                  (widget.selectedDateList?[widget.index]?.isSelected == true)
                      ? Color.fromRGBO(0, 255, 163, 1)
                      : Colors.white,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: HOME_PAGE_BACKGROUND_ONE,
                    ),
                    height: 4,
                    width: 20,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${widget.dateForChoice.day}",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "SEP",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    child: Text(
                      widget.dateFormat.substring(0, 3),
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: -6,
            top: 66,
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HOME_PAGE_BACKGROUND_ONE,
                //color: Colors.green,
              ),
            ),
          ),
          Positioned(
            right: 9.5,
            top: 65,
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HOME_PAGE_BACKGROUND_ONE,
                //color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AvailablityCondition extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color iconColor;
  AvailablityCondition(this.text, this.textColor, this.iconColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 12,
            color: iconColor,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieQualityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          MovieQualityBoxes("2D"),
          Spacer(),
          MovieQualityBoxes("3D"),
          Spacer(),
          MovieQualityBoxes("3D IMAX"),
          Spacer(),
          MovieQualityBoxes("3D DBOX"),
        ],
      ),
    );
  }
}

class MovieQualityBoxes extends StatelessWidget {
  final String quality;
  MovieQualityBoxes(this.quality);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromRGBO(85, 85, 85, 1),
          border: Border.all(
            color: Colors.white,
          )),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Center(
        child: Text(
          quality,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ColorfulAvailiblityView extends StatelessWidget {
  const ColorfulAvailiblityView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Color.fromRGBO(34, 34, 34, 1),
      child: Row(
        children: [
          AvailablityCondition(
            "Availible",
            Color.fromRGBO(0, 255, 163, 1),
            Color.fromRGBO(0, 255, 163, 1),
          ),
          Spacer(),
          AvailablityCondition(
            "Filling Fast",
            Color.fromRGBO(255, 122, 0, 1),
            Color.fromRGBO(255, 122, 0, 1),
          ),
          Spacer(),
          AvailablityCondition(
            "Almost Full",
            Color.fromRGBO(255, 0, 184, 1),
            Color.fromRGBO(255, 0, 184, 1),
          ),
        ],
      ),
    );
  }
}
