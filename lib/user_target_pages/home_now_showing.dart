import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/banner_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/resourses/dimens_resources.dart';
import 'package:movie_booking_app/resourses/string_resourses.dart';
import 'package:movie_booking_app/user_target_pages/about_coming_soon.dart';
import 'package:movie_booking_app/user_target_pages/about_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/search_coming_soon_page.dart';
import 'package:movie_booking_app/wigets/movie_item_building_components_view.dart';

class HomeNowShowingAndComingSoonPage extends StatefulWidget {
  int page;
  HomeNowShowingAndComingSoonPage({this.page = 0});

  @override
  State<HomeNowShowingAndComingSoonPage> createState() =>
      _HomeNowShowingAndComingSoonPageState();
}

MovieBookingModel mMovieBookingModel = MovieBookingModelImpl();

class _HomeNowShowingAndComingSoonPageState
    extends State<HomeNowShowingAndComingSoonPage> {
  bool isSelected = false;

  List<MovieVO?>? mNowPlayingList;
  List<MovieVO?>? mComingSoonList;
  List<BannerVO?>? bannerList;

  @override
  void initState() {
    super.initState();

    /// Network NowShowing
    mMovieBookingModel.getMovieListNowShowing(1).then((movieList) {
      setState(() {
        mNowPlayingList = movieList;
      });
    }).catchError((error) {
      debugPrint("Error is =======> $error");
    });

    /// DataBase NowShowing
    mMovieBookingModel.getNowPlayingMovieListDataBase()?.then((movieList) {
      setState(() {
        mNowPlayingList = movieList;
      });
    });

    /// Network ComingSoon
    mMovieBookingModel.getMovieListComingSoon(1).then((movieList) {
      setState(() {
        mComingSoonList = movieList;
      });
    }).catchError((error) {
      debugPrint("Error is =======> $error");
    });

    /// DataBase ComingSoon
    mMovieBookingModel.getComingSoonMovieListDataBase()?.then((movieList) {
      setState(() {
        mComingSoonList = movieList;
      });
    });

    /// Network Banner
    mMovieBookingModel.getBanner()?.then((response) {
      setState(() {
        bannerList = response?.data;
      });
    });

    /// DataBase Banner
    mMovieBookingModel.getBannersDataBase()?.then((banners) {
      setState((){
        bannerList = banners;
      });
    });

    /// Network Snack Category
    mMovieBookingModel.getSnackCategory();

    /// Network Snacks
    mMovieBookingModel.getSnackForAll();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: HOME_PAGE_BACKGROUND_ONE,
        // bottomNavigationBar: BottomIconsBar(),
        appBar: AppBar(
          leadingWidth: 46,
          backgroundColor: HOME_PAGE_BACKGROUND_ONE,
          leading: AppBarLeadingView(),
          title: Text(
            MAIN_SCREEN_APPBAR_TITLE,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: MARGIN_PADDING_28,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreenPage(
                            widget: widget,
                            page: widget.page,
                            visibleTwoItems: (widget.page == 1),
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.search,
                      size: TEXT_ICON_REGULAR_LARGE_28,
                    ),
                  ),
                  SizedBox(
                    width: MARGIN_PADDING_22,
                  ),
                  Icon(
                    Icons.notifications,
                  ),
                  SizedBox(
                    width: MARGIN_PADDING_22,
                  ),
                  Icon(
                    Icons.qr_code_scanner_sharp,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Container(
          color: HOME_PAGE_BACKGROUND_ONE,
          child: SingleChildScrollView(
            child: Column(
              children: [
                BannerSectionHomeView(
                  bannerList: bannerList,
                ),
                SizedBox(height: MARGIN_PADDING_20),
                Container(
                  margin: EdgeInsets.only(left: 24, right: 24),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  height: 55,
                  //width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: RadialGradient(
                      radius: 5,
                      colors: [
                        MAIN_SCREEN_INFO_TAB_GRADIENT_2,
                        MAIN_SCREEN_INFO_TAB_GRADIENT_1,
                      ],
                    ),
                  ),
                  child: TabBar(
                    onTap: (tab) {
                      setState(() {
                        widget.page = tab;
                      });
                    },
                    labelStyle: TextStyle(
                      fontSize: TEXT_ICON_REGULAR_1,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(85, 85, 85, 1),
                    ),
                    indicator: BoxDecoration(
                      color: Color.fromRGBO(0, 255, 106, 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    tabs: [
                      Tab(
                        text: "Now Showing",
                      ),
                      Tab(
                        text: "Coming Soon",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                MovieListGridView(
                  onTapMovie: (movieId) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (widget.page == 0)
                                ? AboutNowShowingPage(page: 1, movieId: movieId)
                                : AboutComingSoonPage(
                                    page: 1, movieId: movieId)));
                  },
                  mNowPlayingOrComingSoonList:
                      (widget.page == 0) ? mNowPlayingList : mComingSoonList,
                  widget: widget,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BannerSectionHomeView extends StatefulWidget {
  List<BannerVO?>? bannerList;
  BannerSectionHomeView({required this.bannerList});
  @override
  State<BannerSectionHomeView> createState() => _BannerSectionHomeViewState();
}

class _BannerSectionHomeViewState extends State<BannerSectionHomeView> {
  double _position = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _position = index.toDouble();
              });
            },
            height: MediaQuery.of(context).size.height / 4.2,
            aspectRatio: 1.7,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
          ),
          items: widget.bannerList
              ?.map((bannerItem) => Container(
                    child: Image.network(
                      "${bannerItem?.url}",
                      fit: BoxFit.cover,
                    ),
                  ))
              .toList(),
        ),
        DotsIndicator(
          dotsCount: widget.bannerList?.length ?? [].length,
          position: _position,
          decorator: DotsDecorator(
            color: MAIN_SCREEN_BANNER_DOTS_INDICATOR_INACTIVE,
            activeColor: MAIN_SCREEN_SELECTED_BOTTOM_BAR_COLOR,
          ),
        ),
      ],
    );
  }
}

class AppBarLeadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: MAIN_SCREEN_APPBAR_LEADING_CONTAINER_MARGIN,
      ),
      child: Icon(
        Icons.navigation,
        size: TEXT_ICON_REGULAR_2,
      ),
    );
  }
}

//   MovieItemFrameView(
//   visible: (widget.page == 1),
//   onTapMovie: (){
//      (widget.page == 0)
//              ? Navigator.push(
//                  context,
//                   MaterialPageRoute(
//                       builder: (context) => AboutNowShowingPage(page: widget.page,)))
//               : Navigator.push(
//                   context,
//                  MaterialPageRoute(
//                      builder: (context) => AboutComingSoonPage(page: widget.page,)));
//   },
//   mNowplayingOrComingSoonMovie: (widget.page == 0)? mNowPlayingList?.elementAt(index) : mComingSoonList?.elementAt(index) ,
// );

// MovieListCollectionView(
//   visible: (widget.page == 1),
//   mNowplayingMovieList: mNowPlayingList,
//   onTapMovie: () {
//
//   },
// ),

// Container(
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(10),
//     child: Stack(
//       children: [
//         Positioned.fill(
//           child: Image.network(
//             "$IMAGE_BASE_URL${mNowplayingOrComingSoonMovie?.posterPath}",
//             //imageUrl,
//             fit: BoxFit.cover,
//           ),
//         ),
//         Positioned.fill(
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color.fromRGBO(68, 68, 68, 0),
//                   Color.fromRGBO(0, 0, 0, 1),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Visibility(
//           visible: visible,
//           child: ComingSoonDateView(),
//         ),
//         Positioned(
//           top: 244,
//           child:
//           Container(
//             color: Color.fromRGBO(0, 0, 0, 1),
//             padding: EdgeInsets.only(left: 5, right: 5, top: 6),
//             width: 175,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       //movieName,
//                       "${mNowplayingOrComingSoonMovie?.title}",
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Spacer(),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           child: Center(
//                             child: Text(
//                               "IMDb",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4),
//                             color: Colors.amber,
//                           ),
//                           height: 16,
//                           padding: EdgeInsets.all(2),
//                         ),
//                         SizedBox(
//                           width: 2,
//                         ),
//                         Text(
//                           //rating,
//                           "${mNowplayingOrComingSoonMovie?.voteAverage}",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "uOrUA",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 12,
//                       ),
//                     ),
//                     SizedBox(
//                       width: MARGIN_PADDING_12,
//                     ),
//                     Icon(
//                       Icons.circle,
//                       color: Colors.white,
//                       size: 8,
//                     ),
//                     SizedBox(
//                       width: MARGIN_PADDING_12,
//                     ),
//                     Text(
//                       "2D,3D,3D IMAX",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),

// class MovieListCollectionView extends StatefulWidget {
//   bool visible;
//   final Function onTapMovie;
//   final List<MovieVO?>? mNowplayingMovieList;
//
//   MovieListCollectionView({
//     required this.onTapMovie,
//     required this.mNowplayingMovieList,
//     this.visible = false,
//   });
//
//   @override
//   State<MovieListCollectionView> createState() => _MovieListCollectionViewState();
// }
//
// class _MovieListCollectionViewState extends State<MovieListCollectionView> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       padding: EdgeInsets.symmetric(horizontal: 24),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           mainAxisSpacing: MARGIN_PADDING_20,
//           crossAxisCount: 2,
//           crossAxisSpacing: MARGIN_PADDING_20,
//           mainAxisExtent: 320),
//       itemBuilder: (_, i) {
//         return MovieItemFrameView(
//           visible: widget.visible,
//           onTapMovie: widget.onTapMovie,
//           mNowplayingMovie: widget.mNowplayingMovieList?[i],
//         );
//       },
//       itemCount: widget.mNowplayingMovieList?.length,
//     );
//   }
// }

// class MovieItemFrameView extends StatelessWidget {
//   bool visible;
//   final Function onTapMovie;
//   final MovieVO? mNowplayingOrComingSoonMovie;
//
//   MovieItemFrameView({
//     required this.onTapMovie,
//     required this.mNowplayingOrComingSoonMovie,
//     this.visible = false,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTapMovie();
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.pink,
//         ),
//       ),
//
//
//     );
//   }
// }
