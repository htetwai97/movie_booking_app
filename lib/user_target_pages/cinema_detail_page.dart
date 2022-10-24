import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema_detail_vo.dart';
import 'package:movie_booking_app/data/vos/facility_vo.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/home_now_showing.dart';
import 'package:video_player/video_player.dart';

class CinemaDetailPage extends StatefulWidget {
  Color starColor;
  int? cinemaId;
  int? cinemaIndex;
  CinemaDetailPage(
      {this.starColor = Colors.white,
      required this.cinemaId,
      required this.cinemaIndex});

  @override
  State<CinemaDetailPage> createState() => _CinemaDetailPageState();
}

class _CinemaDetailPageState extends State<CinemaDetailPage> {
  MovieBookingModel mMovieBookingModel = MovieBookingModelImpl();
  List<CinemaDetailVO?>? cinemaListDetail;
  late FlickManager flickManager;
  String? vdoDataSource;
  @override
  void initState() {
    super.initState();

    /// CinemaDetail Network
    // mMovieBookingModel.getCinemaDetail()?.then((response) {
    //   setState(() {
    //     cinemaListDetail = response?.data;
    //     vdoDataSource =
    //         "${cinemaListDetail?[widget.cinemaIndex ?? 0]?.promoVdoUrl}";
    //   });
    // });

    /// CinemaDetail DataBase;
    mMovieBookingModel.getCinemaDetailDataBase()?.then((cinemaDetailList) {
      setState(() {
        cinemaListDetail = cinemaDetailList;
        vdoDataSource =
            "${cinemaListDetail?[widget.cinemaIndex ?? 0]?.promoVdoUrl}";
        flickManager = FlickManager(
          videoPlayerController:
              VideoPlayerController.network("$vdoDataSource"),
        );
      });
    });
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      appBar: AppBar(
        leadingWidth: 80,
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
          "Cinema Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                setState(() {
                  widget.starColor = Color.fromRGBO(0, 255, 106, 1);
                });
              },
              icon: Icon(
                Icons.star_outlined,
                size: 36,
                color: widget.starColor,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: HOME_PAGE_BACKGROUND_ONE,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CinemaDetailBannerView(
                flickManager: flickManager,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      //"${modelCinemaDetailList?[widget.cinemaIndex ?? 0]?.name}",
                      "${cinemaListDetail?[widget.cinemaIndex ?? 0]?.name}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            //"${modelCinemaDetailList?[widget.cinemaIndex ?? 0]?.address}",
                            "${cinemaListDetail?[widget.cinemaIndex ?? 0]?.address}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        //SizedBox(width: 10),
                        GestureDetector(
                          child: Image.asset(
                            "assets/images/navigation_arrow_asaung.png",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Facilities",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),
                    FacilityView(
                      facilityList:
                          //modelCinemaDetailList?[widget.cinemaIndex ?? 0]?.facilities,
                          cinemaListDetail?[widget.cinemaIndex ?? 0]
                              ?.facilities,
                    ),
                    SizedBox(height: 16),
                    SizedBox(height: 30),
                    Text(
                      "Safety",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    SafetyListView(
                      safetyList:
                          cinemaListDetail?[widget.cinemaIndex ?? 0]?.safety,
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FacilityView extends StatelessWidget {
  final List<FacilityVO?>? facilityList;
  FacilityView({required this.facilityList});

  List<Widget> _createFacilityBoxWidget() {
    List<Widget> widgets = facilityList
            ?.map((facility) => FacilityContainerDetail(facility: facility))
            .toList() ??
        [];
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      verticalDirection: VerticalDirection.down,
      children: _createFacilityBoxWidget(),
    );
  }
}

class FacilityContainerDetail extends StatelessWidget {
  FacilityVO? facility;
  FacilityContainerDetail({required this.facility});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      //color: Colors.red,
      //height: 50,
      width: 150,
      child: Row(
        children: [
          Image.network("${facility?.img}"),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              "${facility?.title}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SafetyListView extends StatelessWidget {
  List<String>? safetyList;
  SafetyListView({required this.safetyList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.horizontal,
      verticalDirection: VerticalDirection.down,
      children: safetyList
              ?.map((safetyType) => SafetyListBox(
                    safetyType: safetyType,
                  ))
              .toList() ??
          [],
    );
  }
}

class SafetyListBox extends StatelessWidget {
  String safetyType;
  SafetyListBox({required this.safetyType});
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 170,
      //height: 40,
      //padding: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      margin: EdgeInsets.symmetric(
        horizontal: 3,
      ),
      // decoration: BoxDecoration(
      //   color: Color.fromRGBO(0, 255, 106, 1),
      //   borderRadius: BorderRadius.circular(4),
      // ),
      child: Chip(
        backgroundColor: Color.fromRGBO(0, 255, 106, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        label: Text(
          "$safetyType",
          style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class CinemaDetailBannerView extends StatefulWidget {
  FlickManager flickManager;
  CinemaDetailBannerView({required this.flickManager});

  @override
  State<CinemaDetailBannerView> createState() => _CinemaDetailBannerViewState();
}

class _CinemaDetailBannerViewState extends State<CinemaDetailBannerView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: FlickVideoPlayer(
        flickManager: widget.flickManager,
      ),
    );
  }
}
