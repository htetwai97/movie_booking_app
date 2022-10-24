import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';

class MovieDao{
  static final MovieDao _singleton = MovieDao._internal();
  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  void saveMovies(List<MovieVO?>? movieList) async {
    Map<int?, MovieVO> movieMap = Map.fromIterable(movieList??[],
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO? movie) async{
    return getMovieBox().put(movie?.id, movie!);
  }

  List<MovieVO?>? getAllMovies(){
    return getMovieBox().values.toList();
  }

  MovieVO? getMovieById(int? movieId){
    return getMovieBox().get(movieId);
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}