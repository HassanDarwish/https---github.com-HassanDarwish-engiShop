

import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:GiorgiaShop/getIt/config/APIConfig.dart';
import 'package:GiorgiaShop/getIt/woocommecre/APICustomWooCommerce.dart';
import 'package:GiorgiaShop/pojo/products.dart';
import 'package:GiorgiaShop/Helper/product_Enums.dart';
import 'package:get_it/get_it.dart';

import 'package:GiorgiaShop/pojo/coupon/coupons.dart';
import 'package:GiorgiaShop/Helper/cartEnums.dart';
import 'abstracted/Cart.dart';
GetIt getIt = GetIt.instance;

class CartImplementation extends ChangeNotifier implements Cart{


  cartEnums status=cartEnums.empty;
  String _discountValue="0";

  String get discountValue => _discountValue;

  set discountValue(String value) {
    _discountValue = value;
  }

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
  ,  img,  review,index,attributess,toViewSelectedAttribute,identify_value){
    int returnFlag=1;
    if (CUR_CART_COUNT=="")
      _CUR_CART_COUNTT="0";

     int temp =int.parse(CUR_CART_COUNTT)+1;
    CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();
    bool itemExist=_itemMap.containsKey(id);
    if(attributess.length>0) {
      if (!toViewSelectedAttribute.isEmpty) {
         product _product = product(id: id,
            name: title,
            slug: "",
            permalink: "",
            price: price,
            sale_price: price,
            img: img,
            description: description,
            short_description: shortdescription,
            tag: "",
            attributes: attributess,
            toViewSelectedAttribute: toViewSelectedAttribute);

        _product.name = title;
         _product.identify_value=identify_value;
        _products.add(_product);

      }else{
        returnFlag=0;
      }
    }else{
      if (itemExist == false) {
        product _product = product.notDeal(id: id,
            name: title,
            slug: "",
            permalink: "",
            price: price,
            sale_price: price,
            img: img,
            description: description,
            short_description: shortdescription,
            tag: "", );
        _product.name = title;
        _product.identify_value=identify_value;
        _products.add(_product);
      }
    }
    add_to_itemMap(id.toString(),int.parse(price),identify_value);

    applyTax();
    status=cartEnums.hasItems;
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


     // TODO: implement getCart
    return CUR_CART_COUNTT;
  }

  add_to_itemMap(String key,int price, int identify_value){

    identify_value==0 ? key=key : key=identify_value.toString();

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
  remove_from_itemMap(Product_Enums removeFromAll,String key,int index,String pricee) {
    int price=int.parse(pricee);int totalItemPriceFromMap=0;
    if (removeFromAll == Product_Enums.removeFromAll) {
      int value = _itemMap[key]!;
      totalItemPriceFromMap=_itemTotalPriceMap[key]! ;
      _cartTotalPrice=(double.parse(_cartTotalPrice)-totalItemPriceFromMap).toString();
      _itemMap.remove(key);
      _itemTotalPriceMap.remove(key);
      _products.removeAt(index);///
      int temp =int.parse(CUR_CART_COUNTT)-value;
      CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();
    } else{
      bool does_contain_flag = _itemMap.containsKey(key);
    if (does_contain_flag == true) {
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
    if(_products.length==0)
      status=cartEnums.empty;

      notifyListeners();


  }

  remove_product_hasAttribute(Product_Enums removehasAttribute,String key,int index,String pricee){

    int price=int.parse(pricee);int totalItemPriceFromMap=0;
    if (removehasAttribute == Product_Enums.hasAttribute) {
      int value = _itemMap[key]!;
      totalItemPriceFromMap=_itemTotalPriceMap[key]! ;
      _cartTotalPrice=(double.parse(_cartTotalPrice)-totalItemPriceFromMap).toString();
      _itemMap.remove(key);
      _itemTotalPriceMap.remove(key);
      _products.removeAt(index);///
      int temp =int.parse(CUR_CART_COUNTT)-value;
      CUR_CART_COUNT=temp.toString();_CUR_CART_COUNTT=temp.toString();

    }
    applyTax();
    if(_products.length==0)
      status=cartEnums.empty;
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

  applyCoupon(String text) async {

   if(status!=cartEnums.couponAdded) {
     coupons? coupon = await getIt<APICustomWooCommerce>().get_coupon(text);
     if (coupon != null){
       double cartTotalPrice = double.parse(_cartTotalPrice);
     double amount = double.parse(coupon.amount);
     if (coupon.discount_type == "percent") {
       _discountValue = (cartTotalPrice / amount).toString();
       cartTotalPrice = cartTotalPrice - (cartTotalPrice / amount);
     }
     if (coupon.discount_type == "fixed_cart") {
       _discountValue = amount.toString();
       cartTotalPrice = cartTotalPrice - amount;
     }

     _cartTotalPrice = cartTotalPrice.toString();

     applyTax();
     status = cartEnums.couponAdded;
     notifyListeners();
     return true;
   }else{
       return false;
     }

  }
   return false;
  }
  @override
  void dispose(){
    status = cartEnums.hasItems;
    double cartTotalPrice2 =  double.parse(cartTotalPrice) + double.parse(_discountValue);

    _cartTotalPrice = cartTotalPrice2.toString();
    cartTotalPrice=cartTotalPrice2.toString();

    _discountValue="0";
    applyTax();
    notifyListeners();

  }

}