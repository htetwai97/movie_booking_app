import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/snack_item_vo.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';

class SnackDao {
  static final SnackDao _singleton = SnackDao._internal();
  factory SnackDao() {
    return _singleton;
  }

  SnackDao._internal();

  void saveSnacks(List<SnackVO?>? snacks) async {
    Map<int?, SnackVO> snackMap = Map.fromIterable(snacks ?? [],
        key: (snack) => snack.id, value: (snack) => snack);
    await getSnackBox().putAll(snackMap);
  }

  List<SnackVO?>? getSnacks(){
    return getSnackBox().values.toList();
  }

  Box<SnackVO> getSnackBox() {
    return Hive.box<SnackVO>(BOX_NAME_SNACK_ITEM_VO);
  }
  // void saveMovies(List<MovieVO?>? movieList) async {
  //   Map<int?, MovieVO> moiveMap = Map.fromIterable(movieList??[],
  //       key: (movie) => movie.id, value: (movie) => movie);
  //   await getMovieBox().putAll(moiveMap);
  // }
  //
  // void saveSingleMovie(MovieVO? movie) async{
  //   return getMovieBox().put(movie?.id, movie!);
  // }
  //
  // List<MovieVO?>? getAllMovies(){
  //   return getMovieBox().values.toList();
  // }
  //
  // MovieVO? getMovieById(int? movieId){
  //   return getMovieBox().get(movieId);
  // }
  //
  // Box<MovieVO> getMovieBox() {
  //   return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  // }
}
