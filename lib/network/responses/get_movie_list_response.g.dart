// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_movie_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMovieListResponse _$GetMovieListResponseFromJson(
        Map<String, dynamic> json) =>
    GetMovieListResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: json['page'] as int?,
      dates: json['dates'] == null
          ? null
          : DateVO.fromJson(json['dates'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMovieListResponseToJson(
        GetMovieListResponse instance) =>
    <String, dynamic>{
      'dates': instance.dates,
      'page': instance.page,
      'results': instance.results,
    };
