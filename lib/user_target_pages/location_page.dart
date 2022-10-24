import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/city_vo.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/home_now_showing.dart';
import 'package:movie_booking_app/user_target_pages/logo_page.dart';
import 'package:movie_booking_app/user_target_pages/varify_Phone_num.dart';
import 'package:movie_booking_app/wigets/bottom_icon_bar.dart';

class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

MovieBookingModel mMovieBookingModel = MovieBookingModelImpl();

class _LocationPageState extends State<LocationPage> {
  List<CityVO?>? cities;

  @override
  void initState() {
    super.initState();

    /// Network
    // mMovieBookingModel.getCities()?.then((response) {
    //   setState(() {
    //     cities = response?.data;
    //   });
    // }).catchError((error) {
    //   debugPrint("Error is  ====> ${error.toString()}");
    // });

    /// Database
    mMovieBookingModel.getCitiesDataBase()?.then((cityList) {
      setState(() {
        cities = cityList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: HOME_PAGE_BACKGROUND_ONE,
        centerTitle: true,
        title: Text(
          "Pick Region",
          style: TextStyle(
              color: Color.fromRGBO(0, 255, 106, 1),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      body: Container(
        color: HOME_PAGE_BACKGROUND_ONE,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchLocationTextField(),
              SizedBox(height: 24),
              Container(
                margin: EdgeInsets.only(left: 300, right: 4),
                child: Image.asset(
                  "assets/images/cities_image.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 50,
                width: 414,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                color: Color.fromRGBO(59, 59, 59, 1),
                child: Text(
                  "Cities",
                  style: TextStyle(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
              CitiesNames(
                cities: cities,
                onTapCity: (int? cityId) {
                  mMovieBookingModel.postSetCity(cityId)?.then((response) {
                    debugPrint(cityId.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomIconsBar()));
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchLocationTextField extends StatelessWidget {
  const SearchLocationTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width /1.6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(102, 102, 102, 0.8),
                Color.fromRGBO(85, 85, 85, 0.4),
                Color.fromRGBO(85, 85, 85, 0.4),
              ])),
          margin: EdgeInsets.only(left: 24,right: 24, top: 20),
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search your location",
                hintStyle: TextStyle(
                  color: Color.fromRGBO(158, 158, 158, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )),
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(right: 24, top: 20),
          child: Image.asset(
            "assets/images/gridicons_location.png",
          ),
        ),
      ],
    );
  }
}

class CitiesNames extends StatelessWidget {
  final Function(int?) onTapCity;
  const CitiesNames({
    Key? key,
    required this.cities,
    required this.onTapCity,
  }) : super(key: key);
  final List<CityVO?>? cities;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: cities?.length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () {
                onTapCity(cities?[index]?.id);
              },
              child: Container(
                height: 60,
                width: 414,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(59, 59, 59, 1),
                  ),
                ),
                child: Text(
                  "${cities?[index]?.name}",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            );
          }),
    );
  }
}
