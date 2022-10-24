import 'package:flutter/material.dart';
import 'package:movie_booking_app/user_target_pages/check_out_page.dart';

class TicketCheckOutPayDoneCombine extends StatelessWidget {
  String movieDate;
  String movieTime;
  String cinemaAddress;

  TicketCheckOutPayDoneCombine(
      this.movieDate, this.movieTime, this.cinemaAddress);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: CheckOutIconsRow(Icons.date_range_outlined, movieDate)),
          Expanded(
              child: CheckOutIconsRow(Icons.watch_later_outlined, movieTime)),
          Expanded(child: CheckOutIconsRow(Icons.location_on, cinemaAddress)),
        ],
      ),
    );
  }
}
