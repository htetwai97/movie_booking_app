import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/wigets/terms_and_condition.dart';

class SendingOtpCodePage extends StatefulWidget {
  String? phNum;

  SendingOtpCodePage({required this.phNum});

  @override
  State<SendingOtpCodePage> createState() => _SendingOtpCodePageState();
}

class _SendingOtpCodePageState extends State<SendingOtpCodePage> {
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  final textController3 = TextEditingController();
  final textController4 = TextEditingController();
  final textController5 = TextEditingController();
  final textController6 = TextEditingController();
  String? userOtp1;
  String? userOtp2;
  String? userOtp3;
  String? userOtp4;
  String? userOtp5;
  String? userOtp6;
  String? otpFullCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      body: Container(
        color: HOME_PAGE_BACKGROUND_ONE,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/logo.png",
                    ),
                    SizedBox(height: 60),
                    Image.asset(
                      "assets/images/logo_text.png",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 36),
                child: Text(
                  "Enter OTP Code",
                  style: TextStyle(
                      color: Color.fromRGBO(122, 126, 128, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OtpBoxDetail(
                        userOtp: userOtp1,
                        textController: textController1,
                      ),
                      Spacer(),
                      OtpBoxDetail(
                        userOtp: userOtp2,
                        textController: textController2,
                      ),
                      Spacer(),
                      OtpBoxDetail(
                        userOtp: userOtp3,
                        textController: textController3,
                      ),
                      Spacer(),
                      OtpBoxDetail(
                        userOtp: userOtp4,
                        textController: textController4,
                      ),
                      Spacer(),
                      OtpBoxDetail(
                        userOtp: userOtp5,
                        textController: textController5,
                      ),
                      Spacer(),
                      OtpBoxDetail(
                        userOtp: userOtp6,
                        textController: textController6,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 80),
                child: Row(
                  children: [
                    Text(
                      "Don't recevie OTP?",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Resend code",
                      style: TextStyle(
                          color: Color.fromRGBO(0, 255, 106, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  setState(() {
                    userOtp1 = textController1.text;
                    userOtp2 = textController2.text;
                    userOtp3 = textController3.text;
                    userOtp4 = textController4.text;
                    userOtp5 = textController5.text;
                    userOtp6 = textController6.text;
                    otpFullCode =
                        "$userOtp1$userOtp2$userOtp3$userOtp4$userOtp5$userOtp6";
                  });
                  print(otpFullCode);
                  showDialog(
                      context: context,
                      builder: (context) => FullBoxForTermsAndConditionsView(
                          otpFullCode: otpFullCode, phNum: widget.phNum));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 32, right: 32),
                  child: Image.asset(
                    "assets/images/confirm_otp.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 26, right: 26),
                child: Image.asset(
                  "assets/images/by_clicking_blahblah-otpimage.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpBoxDetail extends StatelessWidget {
  OtpBoxDetail({required this.userOtp, required this.textController});
  final textController;
  String? userOtp;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: TextField(
        controller: textController,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(74, 74, 75, 1),
            fontSize: 18,
            fontWeight: FontWeight.w400),
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
      ),
    );
  }
}
