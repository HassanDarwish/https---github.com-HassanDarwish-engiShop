

import 'package:flutter/cupertino.dart';
import 'package:GiorgiaShop/Helper/product_Enums.dart';
abstract class Cart extends ChangeNotifier {

  String addToCart(int count, shortdescription,  description,  price,  title,  id
      ,  img,  review,index,attributess,toViewSelectedAttribute,identify_value);

  String removeFromCart(int count, shortdescription,  description,  price,  title,  id
      ,  img,  review,index);
  add_to_itemMap(String key,int price,int identify_value);
  remove_from_itemMap(Product_Enums removeFromAll,String key,int index,String pricee);
  applyTax();
  applyCoupon(String text);
}