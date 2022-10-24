import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/credits_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/resourses/dimens_resources.dart';

class TitleText extends StatelessWidget {
  final String text;
  TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TechnicalDetailView extends StatelessWidget {
  final String label;
  final String description;
  TechnicalDetailView(this.label, this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class CastsOrCrewSectionView extends StatelessWidget {
  final List<CreditVO?>? castOrCrewList;
  final String text;
  CastsOrCrewSectionView(this.text, {required this.castOrCrewList});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 22,
          ),
          ActorsImagesAndName(castOrCrewList: castOrCrewList),
        ],
      ),
    );
  }
}

class ActorsImagesAndName extends StatelessWidget {
  final List<CreditVO?>? castOrCrewList;
  ActorsImagesAndName({required this.castOrCrewList});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: (castOrCrewList != null && castOrCrewList!.isNotEmpty)
          ? ListView.builder(
              // itemExtent: 120,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) =>
                  (castOrCrewList != null && castOrCrewList!.isNotEmpty)
                      ? CircleImageActorsAndActressesView(
                          imageUrl: "${castOrCrewList?[i]?.profilePath}",
                          castOrCrewName: "${castOrCrewList?[i]?.name}",
                        )
                      : CircularProgressIndicator(),
              itemCount: (castOrCrewList != null && castOrCrewList!.isNotEmpty)
                  ? castOrCrewList?.length
                  : 8,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class CircleImageActorsAndActressesView extends StatelessWidget {
  final String imageUrl;
  final String castOrCrewName;
  CircleImageActorsAndActressesView(
      {required this.imageUrl, required this.castOrCrewName});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("$IMAGE_BASE_URL$imageUrl"),
                    radius: 30,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 70,
                    child: Text(
                      castOrCrewName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 35,
              ),
            ],
          ),
        ),
        Container(
          height: 70,
          width: 90,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(17, 17, 17, 0.1),
                Color.fromRGBO(17, 17, 17, 0.7),
                Color.fromRGBO(17, 17, 17, 0.7),
                Color.fromRGBO(17, 17, 17, 1),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class StoryLineSectionView extends StatelessWidget {
  MovieVO? mMovie;
  StoryLineSectionView({required this.mMovie});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Story Line",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "${mMovie?.overView}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class BannerMovieSectionView extends StatelessWidget {
  final MovieVO? mMovie;
  final Function onTapBackArrow;
  final String backGroundLargeImage;
  final String frontSmallImage;

  BannerMovieSectionView(
      {required this.backGroundLargeImage,
      required this.frontSmallImage,
      required this.onTapBackArrow,
      required this.mMovie});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          MovieBackgroundImageLargeView(
            "$IMAGE_BASE_URL$backGroundLargeImage",
            onTabBackArrow: onTapBackArrow,
          ),
          Positioned(
            left: 20,
            top: MediaQuery.of(context).size.height / 3.8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieImageFrontSmallOneView(
                  "$IMAGE_BASE_URL$frontSmallImage",
                ),
                SizedBox(width: 10),
                MovieInfoDetailView(
                  mMovie: mMovie,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShareButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.share,
        size: 30,
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}

class BackArrowButtonView extends StatelessWidget {
  final Function onTapBackArrow;
  BackArrowButtonView(this.onTapBackArrow);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBackArrow();
      },
      child: Container(
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 30,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class PlayButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Icon(
          Icons.play_arrow,
          size: 36,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 255, 255, 0.5),
      ),
    );
  }
}

class MovieGeneralInfosTextBox extends StatelessWidget {
  final String uppertext;
  final String lowertext;
  MovieGeneralInfosTextBox({required this.uppertext, required this.lowertext});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.white10,
                blurRadius: 10,
                blurStyle: BlurStyle.outer),
          ],
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(17, 17, 17, 0.6),
                Color.fromRGBO(34, 34, 34, 0.8),
              ])),
      child: Column(
        children: [
          MovieInfoGeneralUpperLineText(this.uppertext),
          SizedBox(
            height: 8,
          ),
          MovieInfoGeneralLowerLineText(this.lowertext),
        ],
      ),
    );
  }
}

class MovieInfoGeneralLowerLineText extends StatelessWidget {
  final String lowertext;
  MovieInfoGeneralLowerLineText(this.lowertext);
  @override
  Widget build(BuildContext context) {
    return Text(
      lowertext,
      style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class MovieInfoGeneralUpperLineText extends StatelessWidget {
  final String uppertext;
  MovieInfoGeneralUpperLineText(this.uppertext);
  @override
  Widget build(BuildContext context) {
    return Text(
      uppertext,
      style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class MovieBackgroundImageLargeView extends StatelessWidget {
  final Function onTabBackArrow;
  final String frontImage;
  MovieBackgroundImageLargeView(this.frontImage,
      {required this.onTabBackArrow});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              frontImage,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          ),
          Positioned(
            left: 12,
            top: 30,
            child: BackArrowButtonView(() {
              onTabBackArrow();
            }),
          ),
          Positioned(
            right: 16,
            top: 30,
            child: ShareButtonView(),
          ),
        ],
      ),
    );
  }
}

class MovieImageFrontSmallOneView extends StatelessWidget {
  final String image;
  MovieImageFrontSmallOneView(this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 175,
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}

class MovieInfoDetailView extends StatelessWidget {
  final MovieVO? mMovie;
  //List<GenreVO?>? genres;

  List<Widget> _createGenres() {
    List<Widget> widgets = mMovie?.genres
            ?.map((genre) => GenreChipView("${genre?.name}"))
            .toList() ??
        [];
    return widgets;
  }

  MovieInfoDetailView( {required this.mMovie});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height/3.8,
      //color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieNameAndRatingInfoTextView(mMovie: mMovie),
          //Spacer(),
          AvailaleQualityOfMovie(),
          //Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width/1.75,
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              verticalDirection: VerticalDirection.down,
              children: _createGenres(),
            ),
          )
        ],
      ),
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreChipText;
  GenreChipView(this.genreChipText);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: Color.fromRGBO(0, 255, 106, 1),
          label: Text(
            genreChipText,
            style: TextStyle(
              color: Color.fromRGBO(17, 17, 17, 1),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 4),
      ],
    );
  }
}

class AvailaleQualityOfMovie extends StatelessWidget {
  const AvailaleQualityOfMovie({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "2D,3D,3D IMAX,3D DBOX",
      style: TextStyle(
        color: Colors.white,
        fontSize: TEXT_ICON_REGULAR_1,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class MovieNameAndRatingInfoTextView extends StatelessWidget {
  MovieVO? mMovie;
  MovieNameAndRatingInfoTextView({required this.mMovie});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            "${mMovie?.title}",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_ICON_REGULAR_1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ImdbRatingIconView(),
        SizedBox(
          width: 2,
        ),
        ImdbDigitRatingView(
          voteAverage: mMovie?.voteAverage?.ceilToDouble().toString(),
        ),
      ],
    );
  }
}

class ImdbDigitRatingView extends StatelessWidget {
  final String? voteAverage;
  ImdbDigitRatingView({required this.voteAverage});
  @override
  Widget build(BuildContext context) {
    return Text(
      "$voteAverage",
      style: TextStyle(
        color: Colors.white,
        fontSize: TEXT_ICON_REGULAR_1,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ImdbRatingIconView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Center(
        child: Text(
          "IMDb",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: TEXT_ICON_REGULAR_0,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.amber,
      ),
    );
  }
}

class MovieInfosGeneralView extends StatelessWidget {
  MovieVO? mMovie;
  MovieInfosGeneralView({required this.mMovie});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          MovieGeneralInfosTextBox(
            uppertext: "Censer Rating",
            lowertext: "U/A",
          ),
          Spacer(),
          MovieGeneralInfosTextBox(
            uppertext: "Release date",
            lowertext: "${mMovie?.releaseDate}",
          ),
          Spacer(),
          MovieGeneralInfosTextBox(
            uppertext: "Duration",
            lowertext: "${mMovie?.runTime} min",
          ),
        ],
      ),
    );
  }
}
