import 'package:movie_booking_app/data/vos/snack_item_vo.dart';

class SelectedSnackController{
  List<SnackVO?> ? selectedSnackList = [];
  int totalPrice = 0;

  addSnack(SnackVO selectedSnack){
    var selectedSnackIdList = selectedSnackList?.map((e) => e?.id);
    if(!selectedSnackIdList!.contains(selectedSnack.id)){
      selectedSnackList?.add(selectedSnack);
      selectedSnack.quantity = 1;
      totalPrice = totalPrice + (selectedSnack.price!);
    }else {
      for(int i = 0; i< selectedSnackList!.length; i++){
        if(selectedSnack.id == selectedSnackList?[i]?.id){
          var originalQuantity = selectedSnackList?[i]?.quantity;
          selectedSnackList![i]!.quantity = (originalQuantity!) + 1;
          totalPrice = (totalPrice + (selectedSnack.price!));
        }
      }
    }
  }

  reduceSnack(SnackVO selectedSnack){
    for(int i = 0; i < selectedSnackList!.length; i++){
      if((selectedSnack.id== selectedSnackList?[i]?.id) && (selectedSnackList![i]!.quantity! >1)){
          var originalQuantity = selectedSnackList?[i]?.quantity;
          selectedSnackList![i]!.quantity = (originalQuantity!) - 1;
          totalPrice = (totalPrice - (selectedSnack.price!));

      }else if( (selectedSnack.id== selectedSnackList?[i]?.id)&&(selectedSnackList![i]!.quantity!) == 1){
        selectedSnackList?.remove(selectedSnack);
        totalPrice = (totalPrice - (selectedSnack.price!));
      }
    }
  }
}