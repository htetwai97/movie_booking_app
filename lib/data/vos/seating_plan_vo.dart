
import 'package:json_annotation/json_annotation.dart';
part 'seating_plan_vo.g.dart';
@JsonSerializable()
class SeatingPlanVO{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "seat_name")
  String? seatName;

  @JsonKey(name: "symbol")
  String? symbol;

  @JsonKey(name: "price")
  int? price;

  SeatingPlanVO(this.id, this.type, this.seatName, this.symbol, this.price);

  factory SeatingPlanVO.fromJson(Map<String, dynamic> json) =>
      _$SeatingPlanVOFromJson(json);
  Map<String, dynamic> toJson() => _$SeatingPlanVOToJson(this);

  @override
  String toString() {
    return 'SeatingPlanVO{id: $id, type: $type, seatName: $seatName, symbol: $symbol, price: $price}';
  }
}
