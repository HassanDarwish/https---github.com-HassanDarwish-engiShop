

import 'package:flutter/cupertino.dart';

abstract class Cart extends ChangeNotifier {

  String addToCart(int count, shortdescription,  description,  price,  title,  id
      ,  img,  review,index,attributess,toViewSelectedAttribute);

  String removeFromCart(int count, shortdescription,  description,  price,  title,  id
      ,  img,  review,index);
  add_to_itemMap(String key,int price);
  remove_from_itemMap(int removeFromAll,String key,int index,String pricee);
  applyTax();

}