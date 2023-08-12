

import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../pojo/products.dart';


class CartImplementation extends ChangeNotifier{
  late String _CUR_CART_COUNTT="0";
  String get CUR_CART_COUNTT => _CUR_CART_COUNTT;
  late List<product> _products =[];
  List<product> get products => _products;
  var _itemMap = Map<String, int>();
  Map get itemMap => _itemMap;

  String addToCart(int count, shortdescription,  description,  price,  title,  id
  ,  img,  review,index){

    if (CUR_CART_COUNT=="")
      _CUR_CART_COUNTT="0";


    int temp =int.parse(CUR_CART_COUNTT)+1;
    CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();
    bool flag=_itemMap.containsKey(id);
    if(flag==false){
    product _product= product( id:id,name:title,slug:"",permalink:"",price:price,sale_price:price,img:img,description:description,short_description:shortdescription,tag:"");
    _product.name=title;
    _products.add(_product);
    }
    add_to_itemMap(id.toString());

    notifyListeners();
    return CUR_CART_COUNTT;
  }
  String removeFromCart(int count, shortdescription,  description,  price,  title,  id
      ,  img,  review,index)
  {
    int temp =int.parse(CUR_CART_COUNTT)-1;

    for(product _product in _products){
        if(_product.id==id)
          _products.remove(_product);
    }
    CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();
    notifyListeners();
    return CUR_CART_COUNTT;
  }

  @override
  String getCart() {


    print(CUR_CART_COUNTT);
    // TODO: implement getCart
    return CUR_CART_COUNTT;
  }

  add_to_itemMap(String key){

    bool flag=_itemMap.containsKey(key);
    if(flag==true){
      int value = _itemMap[key]!;
      value++;
      _itemMap[key]= value;
    }else{
      _itemMap[key]= 1;
    }
  }
  remove_from_itemMap(int removeFromAll,String key,int index) {
    if (removeFromAll == 1) {
      int value = _itemMap[key]!;
      _itemMap.remove(key);
      _products.removeAt(index);
      int temp =int.parse(CUR_CART_COUNTT)-value;
      CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();
    } else{
      bool flag = _itemMap.containsKey(key);
    if (flag == true) {
      int value = _itemMap[key]!;

      value = value - 1;
      _itemMap[key] = value;
      if (value == 0) {
        _itemMap.remove(key);
        _products.removeAt(index);
      }
    }
      int temp =int.parse(CUR_CART_COUNTT)-1;
      CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();
  }

      notifyListeners();


  }

}