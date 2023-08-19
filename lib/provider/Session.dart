import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:GiorgiaShop/pojo/location/Area.dart';
import 'package:GiorgiaShop/pojo/products.dart';
import 'Cart.dart';


class SessionImplementation extends ChangeNotifier{

  late String _userID;
  late String _password;
  late DeliveryArea _area;
  late CartImplementation _cart;
  late Map<String,dynamic> _attribute;

  dynamic getSafeValue(String key) {
    dynamic? value = _attribute[key];
    return value ?? 0;
  }
   setSafeValue(String key,dynamic value) {
    _attribute[key]=value;
  }


// notifyListeners();
  String get userID => _userID;
  set userID(String value) {
    _userID = value;
  }
  String get password => _password;
  set password(String value) {
    _password = value;
  }
  DeliveryArea get area => _area;
  set area(DeliveryArea value) {
    _area = value;
  }
  CartImplementation get cart => _cart;
  set cart(CartImplementation value) {
    _cart = value;
  }



}