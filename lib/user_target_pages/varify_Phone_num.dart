import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/google_sign_in_page.dart';
import 'package:movie_booking_app/user_target_pages/send_otp_code.dart';
import 'package:movie_booking_app/wigets/terms_and_condition.dart';

class VarifyPhoneNoPage extends StatefulWidget {
  @override
  State<VarifyPhoneNoPage> createState() => _VarifyPhoneNoPageState();
}

MovieBookingModel mMovieBookingModel = MovieBookingModelImpl();

class _VarifyPhoneNoPageState extends State<VarifyPhoneNoPage> {
  final _textController = TextEditingController();

  String? userInput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      body: Container(
        color: HOME_PAGE_BACKGROUND_ONE,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icons/logo.png",
                          ),
                          SizedBox(height: 60),
                          Image.asset("assets/images/varify_ph_no_image.png")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.only(left: 36),
                    child: Text(
                      "Country Code",
                      style: TextStyle(
                          color: Color.fromRGBO(136, 136, 136, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Row(
                    children: [
                      DropDownCodes(),
                      Container(
                        color: HOME_PAGE_BACKGROUND_ONE,
                        width: 115,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          controller: _textController,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              hintText: "Mobile Number",
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(136, 136, 136, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        userInput = _textController.text;
                        mMovieBookingModel.postGetOtp("$userInput")?.then(
                            (response) {
                          debugPrint(
                              "here is response=====> ${response.toString()}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SendingOtpCodePage(phNum: userInput)));
                        }).catchError((error) =>
                            debugPrint("error is =====> ${error.toString()}"));
                      });
                      print(userInput);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 36),
                      child: Image.asset(
                        "assets/images/ph_varify_button.png",
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Image.asset(
                      "assets/images/line_or_line_image.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoogleSignInPage()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 36),
                      child: Image.asset(
                        "assets/images/continue_with_google.png",
                      ),
                    ),
                  )
                ],
              ),
            ),
            //FullBoxForTermsAndConditionsView(),
          ],
        ),
      ),
    );
  }
}

class DropDownCodes extends StatefulWidget {
  @override
  State<DropDownCodes> createState() => _DropDownCodesState();
}

class _DropDownCodesState extends State<DropDownCodes> {
  final List<String> countryCodes = ["+95", "+93", "+78", "+66"];
  String? value;
  DropdownMenuItem<String> buildMenuItem(String countryCode) =>
      DropdownMenuItem(
          value: countryCode,
          child: Text(
            countryCode,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ));
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 36),
      child: DropdownButton<String>(
          dropdownColor: HOME_PAGE_BACKGROUND_ONE,
          value: value,
          items: countryCodes.map(buildMenuItem).toList(),
          onChanged: (value) {
            setState(() => this.value = value);
          }),
    );
  }
}
