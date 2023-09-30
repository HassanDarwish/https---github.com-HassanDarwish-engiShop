import 'package:GiorgiaShop/Helper/cartEnums.dart';
import 'package:GiorgiaShop/pojo/location/Area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Cart.dart';

class SessionImplementation extends ChangeNotifier {
  late String _userID;
  late String _password;
  late DeliveryArea _area;
  late CartImplementation _cart;
  late Map<String, dynamic> _attribute;

  late List _addressList = [
    {
      "address": "lorem ipsum",
      "area": "Bhuj",
      "city": "Bhuj",
      "state": "Gujrat",
      "country": "India",
      "mobile": "0123456789"
    }
  ];

  List get addressList => _addressList;

  set addressList(List value) {
    _addressList = value;
  }

  String _email = "";
  String _id = "";
  String _displayName = "";
  sessionEnums _status = sessionEnums.empty;

  sessionEnums get status => _status;

  set status(sessionEnums value) {

    _status = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get displayName => _displayName;

  set displayName(String value) {
    _displayName = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  dynamic getSafeValue(String key) {
    dynamic value = _attribute[key];
    return value ?? 0;
  }

  setSafeValue(String key, dynamic value) {
    _attribute[key] = value;
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

  clear() {
    email = "";
    id = "";
    displayName = "";
    status = sessionEnums.logout;
    notifyListeners();
  }

  initSession(GoogleSignInAccount? user) {
    email = user!.email;
    id = user.id;
    if (user.displayName != null) displayName = user.displayName!;

    status = sessionEnums.login;

    print(user.email);
    print("**");
    print(user.photoUrl!);
    print("**");
    print(user.displayName!);
    print("**");
    print(user.id);
    print("**");

    // email = "";
    // id = "";
    // displayName = "";
    // status = sessionEnums.logout;
    notifyListeners();
  }
}
