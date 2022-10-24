import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/credits_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/resourses/dimens_resources.dart';
import 'package:movie_booking_app/user_target_pages/about_coming_soon.dart';
import 'package:movie_booking_app/user_target_pages/home_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/time_table_view.dart';
import 'package:movie_booking_app/user_target_pages/varify_Phone_num.dart';
import 'package:movie_booking_app/wigets/about_page_commons.dart';
import 'package:movie_booking_app/wigets/bottom_icon_bar.dart';

class AboutNowShowingPage extends StatefulWidget {
  final int? movieId;
  int page;
  AboutNowShowingPage({required this.page, required this.movieId});

  @override
  State<AboutNowShowingPage> createState() => _AboutNowShowingPageState();
}

class _AboutNowShowingPageState extends State<AboutNowShowingPage> {

  MovieBookingModel mMovieBookingModel = MovieBookingModelImpl();
  MovieVO? mMovie;
  List<CreditVO?>? castList;
  List<CreditVO?>? crewList;

  @override
  void initState() {
    super.initState();

    /// Network MovieDetail
    mMovieBookingModel.getMovieDetails(widget.movieId ?? 499999).then((movie) {
      setState(() {
        mMovie = movie;
      });
    }).catchError(
        (error) => debugPrint("Error is ==============> ${error.toString()}"));

    /// DataBase MovieDetail
    mMovieBookingModel
        .getMovieDetailDataBase(widget.movieId ?? 455555)
        ?.then((movie) {
      setState(() {
        mMovie = movie;
      });
    });

    /// Network Casts
    mMovieBookingModel
        .getCreditsCastByMovie(widget.movieId ?? 455555)
        .then((castList) {
      setState(() {
        this.castList = castList;
      });
    });

    /// DataBase Casts
    mMovieBookingModel
        .getCastsByMovieDataBase(widget.movieId ?? 455555)
        .then((casts) {
      setState(() {
        castList = casts;
      });
    });

    /// Network Crews
    mMovieBookingModel
        .getCreditsCrewByMovie(widget.movieId ?? 445678)
        .then((crewList) {
      setState(() {
        this.crewList = crewList;
      });
    });

    /// DataBase Crews
    mMovieBookingModel
        .getCrewsByMovieDataBase(widget.movieId ?? 455555)
        .then((crews) {
      setState(() {
        crewList = crews;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: HOME_PAGE_BACKGROUND_ONE,
          child: (mMovie != null)
              ? CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
                      automaticallyImplyLeading: false,
                      expandedHeight:
                          MediaQuery.of(context).size.height / 2.05,
                      flexibleSpace: FlexibleSpaceBar(
                        background: BannerMovieSectionView(
                          onTapBackArrow: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomIconsBar()));
                          },
                          frontSmallImage: "${mMovie?.posterPath}",
                          backGroundLargeImage: "${mMovie?.backDropPath}",
                          mMovie: mMovie,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              MovieInfosGeneralView(mMovie: mMovie),
                              SizedBox(height: 20),
                              //ExtraNotificationBox(),
                              SizedBox(height: 20),
                              StoryLineSectionView(mMovie: mMovie),
                              SizedBox(height: 10),
                              CastsOrCrewSectionView("Cast",
                                  castOrCrewList: castList),
                              //SizedBox(height: 20),
                              CastsOrCrewSectionView("Crew", castOrCrewList: crewList),
                              SizedBox(
                                height: 20,
                              ),
                              TitleText("Technical Detail"),
                              SizedBox(height: 12),
                              TechnicalDetailView("Film type:", "Feature"),
                              SizedBox(height: 12),
                              TechnicalDetailView("Language:", "English"),
                              SizedBox(height: 12),
                              TechnicalDetailView("Color Info:", "Color"),
                              SizedBox(height: 12),
                              TechnicalDetailView("Sound Mix:",
                                  "6-track 70mm,Dobly Atmos,Dobly Digital,Dobly Surround 7.1 DTS"),
                              SizedBox(height: 12),
                              TechnicalDetailView("Frame rate:", "24fps"),
                              SizedBox(height: 12),
                              TechnicalDetailView(
                                  "Aspect Ratio:", "2.39:1(Scope)"),
                              SizedBox(height: 12),
                              TechnicalDetailView(
                                  "ArchivalSource:", "QubeVault"),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                height: 1,
                                color: Colors.white,
                              ),
                              SizedBox(height: 20),
                              TitleText("Fun Stuff"),
                              SizedBox(height: 12),
                              TechnicalDetailView("Filmingg Location:",
                                  "New York city,Pixar Animation Studios - 1200 park Avenue,Emery Ville,Califonia, Walt Disney Features Animation - 500 S.Buena Vista Street,Burbank, California"),
                              SizedBox(height: 80),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        ),
        Positioned(
            left: 80,
            right: 80,
            bottom: 5,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TimeTablePage(
                              movieId: widget.movieId,
                            )));
              },
              child: SizedBox(
                height: 50,
                width: 238,
                child: Image.asset(
                  "assets/icons/BookingBTN.png",
                ),
              ),
            )),
      ]),
    );
  }
}
