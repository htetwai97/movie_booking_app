import 'package:flutter/material.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';

class TicketCancellationPolicyBoxView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.7,
          width: MediaQuery.of(context).size.width /1.3,
          decoration: BoxDecoration(
            color: HOME_PAGE_BACKGROUND_ONE,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color.fromRGBO(0, 255, 106, 1),
            ),
          ),
          // height: 452,
          //width: 310,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ticket Cancelation Policy",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.fastfood_outlined,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    size: 22,
                  ),
                  SizedBox(width: 12),
                  Text(
                    "100% Refund on F&B",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      "assets/icons/botnavbar_ticket.png",
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Up to 75% Refund for Tickets",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 24),
                        Text(
                          "-75% refund until 2 hours before show start time",
                          style: TextStyle(
                              color: Color.fromRGBO(136, 136, 136, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "-50% refund between 2 hours and 20 minutes before show start time",
                          style: TextStyle(
                              color: Color.fromRGBO(136, 136, 136, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Expanded(
                child: Text(
                  "1. Refund not available for Convenience\n     fees,Vouchers,Gift Cards,Taxes etc.",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: Text(
                  "2. No cancelation within 20minute of show\n     start time",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 255, 106, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close",
                    style: TextStyle(
                        color: Color.fromRGBO(17, 17, 17, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}