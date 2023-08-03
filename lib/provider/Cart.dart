import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:flutter/foundation.dart';
import '../pojo/products.dart';


class CartImplementation extends ChangeNotifier{
  late String _CUR_CART_COUNTT="0";
  String get CUR_CART_COUNTT => _CUR_CART_COUNTT;

  String addToCart(int count,id,index){

    if (CUR_CART_COUNT=="")
      _CUR_CART_COUNTT="0";

    int temp =int.parse(CUR_CART_COUNTT)+1;
    CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();

    print(CUR_CART_COUNTT);
    notifyListeners();
    return CUR_CART_COUNTT;
  }
  String removeFromCart(int count,id,index)
  {
    int temp =int.parse(CUR_CART_COUNTT)-1;
    CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();
    notifyListeners();
    return CUR_CART_COUNTT;
  }

  @override
  String getCart() {

    print("HassanAli");
    print(CUR_CART_COUNTT);
    // TODO: implement getCart
    return CUR_CART_COUNTT;
  }
}