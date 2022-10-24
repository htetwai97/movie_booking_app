import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/cinema_detail_page.dart';
import 'package:movie_booking_app/user_target_pages/time_table_view.dart';

class CinemaSearchPage extends StatefulWidget {
  int? movieId;
  int? cinemaIndex;
  String dateForCheckOut ;
  String dateFormat ;
  CinemaSearchPage(
      {required this.movieId,
      required this.cinemaIndex,
      required this.dateForCheckOut,
        required this.dateFormat,
      });
  @override
  State<CinemaSearchPage> createState() => _CinemaSearchPageState();
}

MovieBookingModel model = MovieBookingModelImpl();

class _CinemaSearchPageState extends State<CinemaSearchPage> {
  int? cinemaIndex = 0;
  List<CinemaVO?>? cinemaList;
  List timeSlotStatusList=[];

  @override
  void initState() {
    super.initState();

    /// CinemaDayTimeSlot Network
    model.getCinemaDayTimeSlots(widget.dateForCheckOut)?.then((response) {
      setState(() {
        cinemaList = response?.data;
      });
    });

    /// Config DataBase
    model.getConfigTimeSlotDataBase()?.then((configs){
      setState(() {
        timeSlotStatusList = configs?[1]?.value;
      });
    });
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
          onTap: () {
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
              hintText: "search the cinema",
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                DropDownForBothSearches(),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child:
                      Image.asset("assets/images/slider_bar_zoom_in_out.png"),
                ),
                SizedBox(height: 20),
                Container(
                  height: 1000,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cinemaList?.length,
                    itemBuilder: (context, index) {
                      return CinemasChoicesExpandsionTiles(
                        timeSlotStatusList: timeSlotStatusList,
                        dateFormat: widget.dateFormat,
                        dateForCheckOut: widget.dateForCheckOut,
                        cinemaIndex: widget.cinemaIndex,
                        movieId: widget.movieId,
                        cinema: cinemaList?[index],
                        onTapSeeDetail: (cinemaId) {
                          cinemaIndex = cinemaId! - 1;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CinemaDetailPage(
                                        cinemaId: cinemaId,
                                        cinemaIndex: cinemaIndex,
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
      ),
    );
  }
}

class DropDownForBothSearches extends StatefulWidget {
  @override
  State<DropDownForBothSearches> createState() =>
      _DropDownForBothSearchesState();
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
          margin: EdgeInsets.only(left: 20, top: 10),
          child: DropdownButton(
            dropdownColor: Colors.white,
            hint: TitleForUserToChoose("Facilites"),
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
