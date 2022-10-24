import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/credits_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/wigets/about_page_commons.dart';
import 'package:movie_booking_app/wigets/bottom_icon_bar.dart';

class AboutComingSoonPage extends StatefulWidget {
  final int? movieId;
  int page;
  AboutComingSoonPage({required this.page,required this.movieId});

  @override
  State<AboutComingSoonPage> createState() => _AboutComingSoonPageState();
}

class _AboutComingSoonPageState extends State<AboutComingSoonPage> {

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
      body: Container(
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
                      ExtraNotificationBox(),
                      SizedBox(height: 20),
                      StoryLineSectionView(mMovie: mMovie),
                      SizedBox(height: 10),
                      CastsOrCrewSectionView("Cast",castOrCrewList: castList),
                      //SizedBox(height: 10),
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
    );
  }
}

class ExtraNotificationBox extends StatelessWidget {
  const ExtraNotificationBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      height: 154,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
          Color.fromRGBO(255, 255, 255, 0.6),
          Color.fromRGBO(204, 204, 204, 0.6),
          Color.fromRGBO(221, 221, 221, 0.3),
        ]),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Releasing in 5 days",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 180,
                child: Text(
                  "Get notify as soon as movie\nbooking opens up in your country",
                  style: TextStyle(
                    color: Color.fromRGBO(200, 200, 200, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Image.asset("assets/images/button_release.png"),
            ],
          ),
          Spacer(),
          Image.asset("assets/images/woman_sitting.png",),
        ],
      ),
    );
  }
}
