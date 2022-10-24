import 'package:flutter/material.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/varify_Phone_num.dart';
import 'package:movie_booking_app/wigets/bottom_icon_bar.dart';

class LoginOrSignUpPage extends StatelessWidget {
  const LoginOrSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: BottomIconsBar(),
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      body: Container(
        color: HOME_PAGE_BACKGROUND_ONE,
        child: SingleChildScrollView(
          child: Column(
            children: [
              LoginOrSignUpBannerView(),
              SizedBox(height: 20),
              LoginScreenListTile(assetImage: "assets/images/parchase_history.png", text: "Parchase History"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                height: 1,
                color: Color.fromRGBO(255, 255, 255, 0.1),
              ),
              LoginScreenListTile(assetImage: "assets/images/offer_login.png", text: "Offer"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                height: 1,
                color: Color.fromRGBO(255, 255, 255, 0.1),
              ),
              LoginScreenListTile(assetImage: "assets/images/gift_card_login.png", text: "Gift Card"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                height: 1,
                color: Color.fromRGBO(255, 255, 255, 0.1),
              ),
              LoginScreenListTile(assetImage: "assets/images/location_login.png", text: "Location"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                height: 1,
                color: Color.fromRGBO(255, 255, 255, 0.1),
              ),
              LoginScreenListTile(assetImage: "assets/images/payment_login.png", text: "Payment"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                height: 1,
                color: Color.fromRGBO(255, 255, 255, 0.1),
              ),
              LoginScreenListTile(assetImage: "assets/images/help_and_support.png", text: "Help and Support"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                height: 1,
                color: Color.fromRGBO(255, 255, 255, 0.1),
              ),
              LoginScreenListTile(assetImage: "assets/images/log_out.png", text: "Logout"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                height: 1,
                color: Color.fromRGBO(255, 255, 255, 0.1),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class LoginScreenListTile extends StatelessWidget {
  final String assetImage;
  final String text;
  LoginScreenListTile({required this.assetImage, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        //leading: paymentType[i].iconPng,
        //title: Text(paymentType[i].title!),
        leading: Image.asset(
          assetImage,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


class LoginOrSignUpBannerView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/login_page_background.png",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 100,
              width: 100,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image.asset(
                          "assets/images/person_half_real.png")),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/circle_cover_person.png",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 40,
              width: 202,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 255, 106, 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color.fromRGBO(0, 255, 106, 1),
                  )),
              //color: Colors.red,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>VarifyPhoneNoPage()));
                },
                child: Text(
                  "Login or Sign Up",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 255, 106, 1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


