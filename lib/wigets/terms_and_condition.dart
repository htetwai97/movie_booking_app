import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/persistance/daos/padc_sign_in_data_dao.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/location_page.dart';
import 'package:movie_booking_app/user_target_pages/time_table_view.dart';
import 'package:movie_booking_app/wigets/bottom_icon_bar.dart';

class FullBoxForTermsAndConditionsView extends StatefulWidget {
  String? otpFullCode;
  String? phNum;
  FullBoxForTermsAndConditionsView(
      {required this.otpFullCode, required this.phNum});

  @override
  State<FullBoxForTermsAndConditionsView> createState() =>
      _FullBoxForTermsAndConditionsViewState();
}

MovieBookingModel mMovieBookingModel = MovieBookingModelImpl();
PADCSignInDataDao padcSignInDataDao = PADCSignInDataDao();

class _FullBoxForTermsAndConditionsViewState
    extends State<FullBoxForTermsAndConditionsView> {
  final List<String> facts = [
    "1. Ticket is compulsory for children of 5 years & above",
    "2. Person below the age of 18 years cannot be admitted for movies certified 'A'",
    "3. Items like laptops,cameras,knives,lighter,match box,cigerettes,firearms and all types of inflammable objects are strictly prohibited",
    "4. Items like carry-bags eatables,helmets,handbags are not allowed inside the theatres and are strictly prohibited.Kindly deposit at the baggage counter of mall/cinema.",
    "5. For 3D movies ,ticket price includes charges towards usage of 3D glasses",
    "6. Seat Layout page for PVR Cinemas is for representational purpose only and actual seat layout might vary",
    "7. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour",
    "8. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing",
    "9. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary",
    "10. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures",
    "11.  Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          height: 460,
          width: 300,
          padding: EdgeInsets.only(left: 10, top: 16, right: 10),
          decoration: BoxDecoration(
            color: HOME_PAGE_BACKGROUND_ONE,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Color.fromRGBO(0, 255, 106, 1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Terms And Conditions",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 240,
                child: ListView.builder(
                    itemCount: facts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, int) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          facts[int],
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }
                    //TextsOfTermsAndConditionsView(),
                    ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 80),
                child: Image.asset("assets/images/terms_and_condition.png"),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Color.fromRGBO(0, 255, 106, 1),
                        ),
                      ),
                      height: 40,
                      width: 130,
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(0, 255, 106, 1),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          //phNo = widget.phNum;

                          /// NetWork
                          mMovieBookingModel
                              .postSignInWithPhone(
                                  "${widget.phNum}", "${widget.otpFullCode}")
                              ?.then((response) {
                                userDataPersistence = response?.data;
                            if (response!.code == 201) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocationPage()));
                            }
                            debugPrint(
                                "Here is ====> ${userDataPersistence.toString()}");
                          });

                          /// Database
                          // mMovieBookingModel
                          //     .postSignInWithPhoneDataBase(1)
                          //     ?.then((userData) {
                          //   setState(() {
                          //     userDataPersistence = userData;
                          //     //token = userData?.token;
                          //   });
                          // });
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 255, 106, 1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Color.fromRGBO(0, 255, 106, 1),
                          ),
                        ),
                        height: 40,
                        width: 130,
                        child: Center(
                          child: Text(
                            "Accept",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
