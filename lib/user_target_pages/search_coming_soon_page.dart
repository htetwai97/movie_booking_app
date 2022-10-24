import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/resourses/dimens_resources.dart';
import 'package:movie_booking_app/user_target_pages/about_coming_soon.dart';
import 'package:movie_booking_app/user_target_pages/about_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/cinema_search_page.dart';
import 'package:movie_booking_app/user_target_pages/home_now_showing.dart';
import 'package:movie_booking_app/wigets/genre_format_common_dropdown.dart';
import 'package:movie_booking_app/wigets/movie_item_building_components_view.dart';


class SearchScreenPage extends StatefulWidget {
  HomeNowShowingAndComingSoonPage widget;
  int page;
  bool visibleTwoItems;
  SearchScreenPage({this.visibleTwoItems= false,required this.page,required this.widget});

  @override
  State<SearchScreenPage> createState() => _SearchScreenPageState();
}

MovieBookingModel mMovieBookingModel = MovieBookingModelImpl();

class _SearchScreenPageState extends State<SearchScreenPage> {

  List<MovieVO?>? mNowPlayingList;
  List<MovieVO?>? mComingSoonList;
  @override
  void initState() {
    super.initState();

    /// DataBase NowShowing
    mMovieBookingModel.getNowPlayingMovieListDataBase()?.then((movieList) {
      setState(() {
        mNowPlayingList = movieList;
      });
    });

    /// DataBase ComingSoon
    mMovieBookingModel.getComingSoonMovieListDataBase()?.then((movieList) {
      setState(() {
        mComingSoonList = movieList;
      });
    });



    /// Network NowShowing
    // mMovieBookingModel.getMovieListNowShowing(1)
    //     .then((movieList) {
    //   setState(() {
    //     mNowPlayingList = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint("Error is =======> $error");
    // });

    /// Network ComingSoon
    // mMovieBookingModel.getMovieListComingSoon(1).then((movieList) {
    //   setState(() {
    //     mComingSoonList = movieList;
    //   });
    //   // debugPrint(mComingSoonList.toString());
    // }).catchError((error) {
    //   //debugPrint("Error is =======> $error");
    // });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      appBar: AppBar(
        leadingWidth: 62,
        titleSpacing: 0.0,
        backgroundColor: HOME_PAGE_BACKGROUND_ONE,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 32,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        title: Container(
          width: 230,
          height: 50,
          child: TextField(
            cursorColor: Color.fromRGBO(255, 255, 255, 1),
            cursorHeight: 24,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 32,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              hintText: "search the movie",
              hintStyle: TextStyle(
                color: Color.fromRGBO(68, 68, 68, 1),
                fontSize: 14,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.filter_alt,
              size: 32,
              color: Color.fromRGBO(0, 255, 106, 1),
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropDownForBothSearches(widget.visibleTwoItems),
              SizedBox(
                height: 33,
              ),
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
                widget: widget.widget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class DropDownForBothSearches extends StatefulWidget {
  bool visibleGenre;
  DropDownForBothSearches(this.visibleGenre);
  @override
  State<DropDownForBothSearches> createState() => _DropDownForBothSearchesState();
}

class _DropDownForBothSearchesState extends State<DropDownForBothSearches> {
  String? _userChoice;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: 3),
          margin: EdgeInsets.only(left: 22, top: 10),
          child: DropdownButton(
            dropdownColor: Colors.white,
            hint: TitleForUserToChoose("Genres"),
            value: _userChoice,
            items: [
              DropdownMenuItem(
                alignment: Alignment.center,
                child: Text(
                  "Action",
                ),
                value: "a",
              ),
              DropdownMenuItem(
                alignment: Alignment.center,
                child: Text(
                  "Horror",
                ),
                value: "b",
              ),
            ],
            onChanged: (String? choice) {
              setState(() => _userChoice = choice);
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: 3),
          margin: EdgeInsets.only(left: 20, top: 10),
          child: DropdownButton(
            dropdownColor: Colors.white,
            hint: TitleForUserToChoose("Format"),
            value: _userChoice,
            items: [
              DropdownMenuItem(
                alignment: Alignment.center,
                child: Text(
                  "Action",
                ),
                value: "a",
              ),
              DropdownMenuItem(
                alignment: Alignment.center,
                child: Text(
                  "Horror",
                ),
                value: "b",
              ),
              DropdownMenuItem(
                alignment: Alignment.center,
                child: Text(
                  "Drama",
                ),
                value: "c",
              ),
              DropdownMenuItem(
                alignment: Alignment.center,
                child: Text(
                  "Comedy",
                ),
                value: "d",
              ),
            ],
            onChanged: (String? choice) {
              setState(() => _userChoice = choice);
            },
          ),
        ),
        Visibility(
          visible: widget.visibleGenre,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 3),
            margin: EdgeInsets.only(left: 20, top: 10),
            child: DropdownButton(
              dropdownColor: Colors.white,
              hint: TitleForUserToChoose("Month"),
              value: _userChoice,
              items: [
                DropdownMenuItem(
                  alignment: Alignment.center,
                  child: Text(
                    "Action",
                  ),
                  value: "a",
                ),
                DropdownMenuItem(
                  alignment: Alignment.center,
                  child: Text(
                    "Horror",
                  ),
                  value: "b",
                ),
                DropdownMenuItem(
                  alignment: Alignment.center,
                  child: Text(
                    "Drama",
                  ),
                  value: "c",
                ),
                DropdownMenuItem(
                  alignment: Alignment.center,
                  child: Text(
                    "Comedy",
                  ),
                  value: "d",
                ),
              ],
              onChanged: (String? choice) {
                setState(() => _userChoice = choice);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class TitleForUserToChoose extends StatelessWidget {
  final String title;
  TitleForUserToChoose(this.title);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Color.fromRGBO(17, 17, 17, 1),
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}


