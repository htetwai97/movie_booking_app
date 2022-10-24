import 'package:json_annotation/json_annotation.dart';
part 'date_vo.g.dart';

@JsonSerializable()
class DateVO{
  @JsonKey(name: "maximum")
  String? maximum;

  @JsonKey(name: "minimum")
  String? minium;

  DateVO({this.maximum,this.minium});

  factory DateVO.fromJson(Map<String, dynamic> json) =>
      _$DateVOFromJson(json);
  Map<String, dynamic> toJson() => _$DateVOToJson(this);
}