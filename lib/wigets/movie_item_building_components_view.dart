import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/resourses/dimens_resources.dart';
import 'package:movie_booking_app/user_target_pages/home_now_showing.dart';

class MovieListGridView extends StatelessWidget {
  MovieListGridView({
    Key? key,
    required this.mNowPlayingOrComingSoonList,
    required this.widget,
    required this.onTapMovie,
  }) : super(key: key);

  final List<MovieVO?>? mNowPlayingOrComingSoonList;
  MovieVO? mMovie;
  final HomeNowShowingAndComingSoonPage widget;
  final Function(int?) onTapMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3900,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: MARGIN_PADDING_20,
          crossAxisCount: 2,
          crossAxisSpacing: MARGIN_PADDING_20,
          mainAxisExtent: 340,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onTapMovie(this.mNowPlayingOrComingSoonList?[index]?.id);
            },
            child: Container(
              decoration: BoxDecoration(
                //color: Colors.pink,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        child: Image.network(
                          "$IMAGE_BASE_URL${mNowPlayingOrComingSoonList?[index]?.posterPath}",
                          height: 230,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      Visibility(
                        visible: (widget.page == 1),
                        child: ComingSoonDateView(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 10, bottom: 10),
                          width: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${mNowPlayingOrComingSoonList?[index]?.title}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  // Spacer(),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ImdbBoxDesignView(),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "${mNowPlayingOrComingSoonList?[index]?.voteAverage?.ceilToDouble().toString()}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              UnderAgeAndQualityView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: mNowPlayingOrComingSoonList?.length,
        //itemCount: 10,
      ),
    );
  }
}

class ImdbBoxDesignView extends StatelessWidget {
  const ImdbBoxDesignView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "IMDb",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.amber,
      ),
      height: 16,
      padding: EdgeInsets.all(2),
    );
  }
}

class UnderAgeAndQualityView extends StatelessWidget {
  const UnderAgeAndQualityView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "UorUA",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        SizedBox(width: 6),
        // SizedBox(
        //   width: MARGIN_PADDING_12,
        // ),
        Icon(
          Icons.circle,
          color: Colors.white,
          size: 8,
        ),
        SizedBox(width: 6),
        //Spacer(),
        // SizedBox(
        //   width: MARGIN_PADDING_12,
        // ),
        Expanded(
          child: Text(
            "2D,3D,3D IMAX",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class ComingSoonDateView extends StatelessWidget {
  const ComingSoonDateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: 16,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 255, 106, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 38,
        width: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "8th ",
              style: TextStyle(
                  color: Color.fromRGBO(85, 85, 85, 1),
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 1.5,
            ),
            Text(
              "AUG",
              style: TextStyle(
                  color: Color.fromRGBO(85, 85, 85, 1),
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
