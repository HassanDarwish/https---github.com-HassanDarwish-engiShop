import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:flutter/foundation.dart';
import '../pojo/products.dart';


class CartImplementation extends ChangeNotifier{
  late String _CUR_CART_COUNTT="0";
  String get CUR_CART_COUNTT => _CUR_CART_COUNTT;
  late List<product> _products =[];
  List<product> get products => _products;

  String addToCart(int count, shortdescription,  description,  price,  title,  id
  ,  img,  review,index){

    if (CUR_CART_COUNT=="")
      _CUR_CART_COUNTT="0";


    int temp =int.parse(CUR_CART_COUNTT)+1;
    CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();

    product _product=new product( id:id,name:title,slug:"",permalink:"",price:price,sale_price:price,img:img,description:description,short_description:shortdescription,tag:"");
    _product.name=title;
    _products.add(_product);

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

    print("HassanAli");
    print(CUR_CART_COUNTT);
    // TODO: implement getCart
    return CUR_CART_COUNTT;
  }
}