
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constances.dart';
part 'genre_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_GENRE_VO,adapterName: "GenreVOAdapter")
class GenreVO{
  @JsonKey(name: "name")
  @HiveField(0)
  String ? name;

  @JsonKey(name: "id")
  @HiveField(1)
  int? id;

  GenreVO({this.name, this.id});

  factory GenreVO.fromJson(Map<String, dynamic> json) =>
      _$GenreVOFromJson(json);
  Map<String, dynamic> toJson() => _$GenreVOToJson(this);

  @override
  String toString() {
    return 'GenreVO{name: $name, id: $id}';
  }
}