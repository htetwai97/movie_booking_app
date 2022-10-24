import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/collection_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/production_company_vo.dart';
import 'package:movie_booking_app/data/vos/production_country_vo.dart';
import 'package:movie_booking_app/data/vos/spoken_language_vo.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';
part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO, adapterName: "MovieVOAdapter")
class MovieVO {
  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "genre_ids")
  @HiveField(1)
  List<int>? genreIds;

  @JsonKey(name: "backdrop_path")
  @HiveField(2)
  String? backDropPath;

  @JsonKey(name: "belongs_to_collection")
  @HiveField(3)
  CollectionVO? belongsToCollection;

  @JsonKey(name: "budget")
  @HiveField(4)
  double? budget;

  @JsonKey(name: "genres")
  @HiveField(5)
  List<GenreVO?>? genres;

  @JsonKey(name: "homepage")
  @HiveField(6)
  String? homePage;

  @JsonKey(name: "imdb_id")
  @HiveField(7)
  String? imdbId;

  @JsonKey(name: "id")
  @HiveField(8)
  int? id;

  @JsonKey(name: "original_language")
  @HiveField(9)
  String? originalLanguage;

  @JsonKey(name: "original_title")
  @HiveField(10)
  String? originalTitle;

  @JsonKey(name: "overview")
  @HiveField(11)
  String? overView;

  @JsonKey(name: "popularity")
  @HiveField(12)
  double? popularity;

  @JsonKey(name: "poster_path")
  @HiveField(13)
  String? posterPath;

  @JsonKey(name: "production_companies")
  @HiveField(14)
  List<ProductionCompanyVO?>? productionCompany;

  @JsonKey(name: "production_countries")
  @HiveField(15)
  List<ProductionCountryVO?>? productionCountries;

  @JsonKey(name: "revenue")
  @HiveField(16)
  int? revenue;

  @JsonKey(name: "runtime")
  @HiveField(17)
  int? runTime;

  @JsonKey(name: "release_date")
  @HiveField(18)
  String? releaseDate;

  @JsonKey(name: "spoken_languages")
  @HiveField(19)
  List<SpokenLanguageVO?>? spokenLanguages;             /// to register     hive

  @JsonKey(name: "status")
  @HiveField(20)
  String? status;

  @JsonKey(name: "tagline")
  @HiveField(21)
  String? tagLine;

  @JsonKey(name: "title")
  @HiveField(22)
  String? title;

  @JsonKey(name: "video")
  @HiveField(23)
  bool? vedio;

  @JsonKey(name: "vote_average")
  @HiveField(24)
  double? voteAverage;

  @JsonKey(name: "vote_count")
  @HiveField(25)
  int? voteCount;

  @HiveField(26)
  bool? isNowPlaying;

  @HiveField(27)
  bool? isComingSoon;

  MovieVO(
      this.adult,
      this.genreIds,
      this.backDropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homePage,
      this.imdbId,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overView,
      this.popularity,
      this.posterPath,
      this.productionCompany,
      this.productionCountries,
      this.revenue,
      this.runTime,
      this.releaseDate,
      this.spokenLanguages,
      this.status,
      this.tagLine,
      this.title,
      this.vedio,
      this.voteAverage,
      this.voteCount,
      this.isNowPlaying,
      this.isComingSoon);

  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFromJson(json);
  Map<String, dynamic> toJson() => _$MovieVOToJson(this);

  @override
  String toString() {
    return 'MovieVO{adult: $adult, genreIds: $genreIds, backDropPath: $backDropPath, belongsToCollection: $belongsToCollection, budget: $budget, genres: $genres, homePage: $homePage, imdbId: $imdbId, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overView: $overView, popularity: $popularity, posterPath: $posterPath, productionCompany: $productionCompany, productionCountries: $productionCountries, revenue: $revenue, runTime: $runTime, releaseDate: $releaseDate, spokenLanguages: $spokenLanguages, status: $status, tagLine: $tagLine, title: $title, vedio: $vedio, voteAverage: $voteAverage, voteCount: $voteCount, isNowPlaying: $isNowPlaying, isComingSoon: $isComingSoon}';
  }
}
