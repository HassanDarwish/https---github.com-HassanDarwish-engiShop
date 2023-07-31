import 'package:GiorgiaShop/Helper/HappyShopString.dart';

import '../../pojo/products.dart';

abstract class Cart{

  String addToCart(int count,id,index);
  String removeFromCart(int count,id,index);
  late List<products> cartItem;
  String getCart();
}

class CartImplementation extends Cart{

  String addToCart(int count,id,index){

    int temp =int.parse(CUR_CART_COUNT)+1;
    CUR_CART_COUNT=temp.toString();
    return CUR_CART_COUNT;
  }
  String removeFromCart(int count,id,index)
  {
    int temp =int.parse(CUR_CART_COUNT)-1;
    CUR_CART_COUNT=temp.toString();
    return CUR_CART_COUNT;
  }

  @override
  String getCart() {
    // TODO: implement getCart
    return CUR_CART_COUNT;
  }
}