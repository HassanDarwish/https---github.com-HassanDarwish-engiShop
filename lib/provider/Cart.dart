

import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../getIt/config/APIConfig.dart';
import '../pojo/products.dart';

import 'package:get_it/get_it.dart';
GetIt getIt = GetIt.instance;

class CartImplementation extends ChangeNotifier{


  late String _CUR_CART_COUNTT="0";
  String get CUR_CART_COUNTT => _CUR_CART_COUNTT;

  late List<product> _products =[];
  List<product> get products => _products;
  var _itemMap = Map<String, int>();

  double _promocodeValue=0;
  String _promocode="";

  double get promocodeValue => _promocodeValue;
  var _itemTotalPriceMap = Map<String, int>();
  String _cartTotalPrice ="0";

  String _cartFinalPrice ="0";
  String _totalTax="0";

  final API_Config config;
  CartImplementation({required this.config});

  set promocodeValue(double value) {
    _promocodeValue = value;
  }

  Map get itemMap => _itemMap;
  String get totalTax => _totalTax;

  set totalTax(String value) {
    _totalTax = value;
  }

  String get cartFinalPrice => _cartFinalPrice;



  String get cartTotalPrice => _cartTotalPrice;

  set cartTotalPrice(String value) {
    _cartTotalPrice = value;
  }

  get itemTotalPriceMap => _itemTotalPriceMap;

  set itemTotalPriceMap(value) {
    _itemTotalPriceMap = value;
  }



  String addToCart(int count, shortdescription,  description,  price,  title,  id
  ,  img,  review,index,attributess){

    if (CUR_CART_COUNT=="")
      _CUR_CART_COUNTT="0";

     int temp =int.parse(CUR_CART_COUNTT)+1;
    CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();
    bool itemExist=_itemMap.containsKey(id);
    if(itemExist==false){
    product _product= product( id:id,name:title,slug:"",permalink:"",price:price,sale_price:price,img:img,description:description,short_description:shortdescription,tag:"",attributes: attributess);
    _product.name=title;
    _products.add(_product);
    }
    add_to_itemMap(id.toString(),int.parse(price));

    applyTax();
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
    //applyTax();
    notifyListeners();
    return CUR_CART_COUNTT;
  }

  @override
  String getCart() {


    print(CUR_CART_COUNTT);
    // TODO: implement getCart
    return CUR_CART_COUNTT;
  }

  add_to_itemMap(String key,int price){

    bool flag=_itemMap.containsKey(key);
    if(flag==true){
      int value = _itemMap[key]!;
      int priceTotal=_itemTotalPriceMap[key]!;
      value++;
      priceTotal=priceTotal+price;
      _cartTotalPrice=(double.parse(_cartTotalPrice)+price).toString();
      _itemTotalPriceMap[key]=priceTotal;
      _itemMap[key]= value;
    }else{
      _itemMap[key]= 1;
      _itemTotalPriceMap[key]=price;
      _cartTotalPrice=(double.parse(_cartTotalPrice)+price).toString();
    }

  }
  remove_from_itemMap(int removeFromAll,String key,int index,String pricee) {
    int price=int.parse(pricee);int totalItemPriceFromMap=0;
    if (removeFromAll == 1) {
      int value = _itemMap[key]!;
      totalItemPriceFromMap=_itemTotalPriceMap[key]! ;
      _cartTotalPrice=(double.parse(_cartTotalPrice)-totalItemPriceFromMap).toString();
      _itemMap.remove(key);
      _itemTotalPriceMap.remove(key);
      _products.removeAt(index);
      int temp =int.parse(CUR_CART_COUNTT)-value;
      CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();
    } else{
      bool flag = _itemMap.containsKey(key);
    if (flag == true) {
      int value = _itemMap[key]!;
      int priceTotal=_itemTotalPriceMap[key]!;
      value = value - 1;

      if (value == 0) {
        int priceTotal=_itemTotalPriceMap[key]!;
        //priceTotal=priceTotal-price;
        _cartTotalPrice=(double.parse(_cartTotalPrice)-price).toString();
        //_itemTotalPriceMap[key]=priceTotal;
        _itemMap.remove(key);
        _itemTotalPriceMap.remove(key);
        _products.removeAt(index);
      }else{
        priceTotal=priceTotal-price;
        _cartTotalPrice=(double.parse(_cartTotalPrice)-price).toString();
        _itemTotalPriceMap[key]=priceTotal;
        _itemMap[key] = value;
      }
    }
      int temp =int.parse(CUR_CART_COUNTT)-1;
      CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();
  }
    applyTax();
      notifyListeners();


  }
  applyTax(){
    List<String> tax =  config.config.tax;
    String deliveryFees =  config.config.deliveryFees;
    double totalTax=0,  deliveryFes=0; double temPelement=0;
     deliveryFes=double.tryParse(deliveryFees)!;
    if (deliveryFes==null)
      deliveryFes=0;


    tax.forEach((element) {
      temPelement=temPelement+double.tryParse(element)!;
    });
    totalTax=((double.parse(_cartTotalPrice)+deliveryFes)*temPelement)/100;

      _totalTax=totalTax.toString();
      _cartFinalPrice=(double.parse(_cartTotalPrice)+deliveryFes+totalTax).toString();
  }

  String get promocode => _promocode;

  set promocode(String value) {
    _promocode = value;
  }

}