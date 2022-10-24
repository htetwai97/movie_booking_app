import 'package:flutter/material.dart';

class ParkingFoodWheelChair extends StatelessWidget {
  bool ticketCancelFacility;
  ParkingFoodWheelChair({this.ticketCancelFacility = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: Image.asset("assets/images/parking_image_1.png",width: 60,),
        ),
       Spacer(),
        GestureDetector(
          child: Image.asset("assets/images/online_food_image_1.png",width: 80,),
        ),
        Spacer(),
        GestureDetector(
          child: Image.asset("assets/images/wheel_chair_image_1.png",width: 80,),
        ),
      ],
    );
  }
}
