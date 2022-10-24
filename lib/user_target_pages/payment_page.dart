import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/checkout_data_vo.dart';
import 'package:movie_booking_app/data/vos/payment_method_vo.dart';
import 'package:movie_booking_app/data/vos/post_checkout_user_vo.dart';
import 'package:movie_booking_app/data/vos/post_request_snack_list_vo.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_booking_app/user_target_pages/all_done_page.dart';
import 'package:movie_booking_app/user_target_pages/confirmation_success_page.dart';
import 'package:movie_booking_app/user_target_pages/food_choices.dart';
import 'package:movie_booking_app/wigets/quantity_price_controller.dart';

class PaymentPage extends StatefulWidget {
  SelectedSnackController snackController;
  int? movieId;
  String? dateForCheckOut;
  int? cinemaDayTimeSlotId;
  int? cinemaIndex;

  PaymentPage({
    required this.snackController,
    required this.movieId,
    required this.cinemaDayTimeSlotId,
    required this.dateForCheckOut,
    required this.cinemaIndex,
  });
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

MovieBookingModel model = MovieBookingModelImpl();

class _PaymentPageState extends State<PaymentPage> {
  List<PaymentVO?>? paymentList;

  @override
  void initState() {
    super.initState();

    /// Network
    // model.getPaymentType()?.then((response) {
    //   setState(() {
    //     paymentList = response?.data;
    //   });
    // });

    /// DataBase
    model.getPaymentMethodsDataBase()?.then((payments) {
      setState(() {
        paymentList = payments;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_PAGE_BACKGROUND_ONE,
      appBar: AppBar(
        backgroundColor: HOME_PAGE_BACKGROUND_ONE,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 26,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Payment",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        color: HOME_PAGE_BACKGROUND_ONE,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              PaymentTextField(),
              SizedBox(height: 30),
              // PaymentUserNameBox(),
              UnlockTabBarForPromocode(),
              SizedBox(
                height: 30,
              ),
              PaymentChoicesBox(),
              SizedBox(height: 20),
              Container(
                height: 1000,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: paymentList
                          ?.map((paymentType) => PaymentTypeListTileView(
                    cinemaIndex:widget.cinemaIndex,
                              paymentType: paymentType,
                              dateForCheckOut: widget.dateForCheckOut,
                              cinemaDayTimeSlotId: widget.cinemaDayTimeSlotId,
                              movieId: widget.movieId,
                              snackController: widget.snackController,
                              iconImage: "${paymentType?.icon}",
                              text: "${paymentType?.title}"))
                          .toList() ??
                      [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentTypeListTileView extends StatefulWidget {
  final String iconImage;
  final String text;
  SelectedSnackController snackController;
  int? movieId;
  String? dateForCheckOut;
  int? cinemaDayTimeSlotId;
  PaymentVO? paymentType;
  int? cinemaIndex;
  PaymentTypeListTileView({
    required this.iconImage,
    required this.text,
    required this.dateForCheckOut,
    required this.cinemaDayTimeSlotId,
    required this.movieId,
    required this.snackController,
    required this.paymentType,
    required this.cinemaIndex,
  });
  @override
  State<PaymentTypeListTileView> createState() =>
      _PaymentTypeListTileViewState();
}

class _PaymentTypeListTileViewState extends State<PaymentTypeListTileView> {
  MovieBookingModelImpl model = MovieBookingModelImpl();
  CheckOutDataVO? checkOutData;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 28, right: 28, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          8,
        ),
        border: Border.all(
          color: Color.fromRGBO(255, 255, 255, 0.25),
        ),
      ),
      child: ListTile(
        leading: Image.network(
          widget.iconImage,
        ),
        title: Text(
          widget.text,
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            PostCheckOutUserVO postCheckOutUserVO = PostCheckOutUserVO(
                widget.cinemaDayTimeSlotId,
                "G-11",
                 widget.dateForCheckOut,
                //"2022-10-28",
                widget.movieId,
                widget.paymentType?.id,
                widget.snackController.selectedSnackList);
            model.postCheckOut("${userDataPersistence?.token}", postCheckOutUserVO)?.then((response) {
              setState(() {
                checkOutData = response?.data;
                debugPrint("here is checkout response ====> $checkOutData}");
              });
              if (response?.code == 200) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfirmationAndSuccessPage(
                            checkOutData: checkOutData,cinemaIndex:widget.cinemaIndex)));
              }else {
                debugPrint(response?.code.toString());
                debugPrint(response?.message);
              }
            });
          },
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class PaymentTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Your  Name",
          labelStyle: TextStyle(
            color: Color.fromRGBO(0, 255, 106, 1),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          hintText: 'Enter Your Name',
          hintStyle: TextStyle(
            color: Color.fromRGBO(68, 68, 68, 1),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color.fromRGBO(0, 255, 106, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Color.fromRGBO(0, 255, 106, 1),
            ),
          ),
        ),
      ),
    );
  }
}

class UnlockTabBarForPromocode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 40,
        right: 40
      ),
      height: 52,
      width: 333,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromRGBO(0, 255, 106, 1),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          "assets/icons/apple_promo_code.svg",
        ),
        title: Text(
          "Unlock Offer or Apply Promocode",
          style: TextStyle(
            color: Color.fromRGBO(17, 17, 17, 1),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class PaymentChoicesBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 28,
      ),
      child: Text(
        "Choose your payment type",
        style: TextStyle(
            color: Color.fromRGBO(0, 255, 106, 1),
            fontWeight: FontWeight.w700,
            fontSize: 18),
      ),
    );
  }
}
