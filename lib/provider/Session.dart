import 'package:GiorgiaShop/Helper/cartEnums.dart';
import 'package:GiorgiaShop/pojo/location/Area.dart';
import 'package:GiorgiaShop/provider/woocommerceProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:GiorgiaShop/Screen/HappyShopHome.dart';
import '../pojo/favorit/Favorit.dart';
import 'Cart.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
class SessionImplementation extends ChangeNotifier {
  late String _userID;
  late String _password;
  late DeliveryArea _area;
  late CartImplementation _cart;
  late Map<String, dynamic> _attribute;

  late List _addressList = [

  ];
  List get addressList => _addressList;
  set addressList(List value) {
    _addressList = value;
  }
  String _email = "";
  String _id = "";
  String _displayName = "";
  sessionEnums _status = sessionEnums.empty;
    List<Favorit>   favoritList=List.empty(growable: true);

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
    favoritList.clear();
    notifyListeners();
  }

  Future<bool> reloadAddress(WoocommerceProvider custWoocommerceProvider,
      displayName, email) async {
    // email = user!.email;
    // id = user.id;

    await custWoocommerceProvider.api_Woocommerce.searchCustomerByEmail(email);
    List<WooCustomer>? cutomer =
    await custWoocommerceProvider.api_Woocommerce.listWooCustomer;

    WooCustomer? cuserUstomer = cutomer?.firstWhere(
            (cuserUstomer) =>
        cuserUstomer.username == displayName && cuserUstomer.email == email,
        orElse: () => WooCustomer());

    // If the user is found, print their name. Otherwise, print 'User not found'.
    if (cuserUstomer?.username == null) {
      return false;
    } else {
      _userID = cuserUstomer!.id.toString();
      addressList = [
        {
          "address": cuserUstomer?.billing?.address1,
          "area": cuserUstomer?.billing?.state,
          "city": cuserUstomer?.billing?.city,
          "state": cuserUstomer?.billing?.state,
          "country": cuserUstomer?.billing?.country,
          "mobile": cuserUstomer?.billing?.phone,
          "country": cuserUstomer?.billing?.country
        }
      ];
      return true;
    }
  }

  Future<bool> initRegister(GoogleSignInAccount? user,
      WoocommerceProvider custWoocommerceProvider) async {
    email = user!.email;
    id = user.id;
    if (user.displayName != null) displayName = user.displayName!;

    status = sessionEnums.login;

    await custWoocommerceProvider.getCustomerByEmail(user.email);
    List<WooCustomer>? cutomer =
    await custWoocommerceProvider.api_Woocommerce.listWooCustomer;

    WooCustomer? cuserUstomer = cutomer?.firstWhere(
            (cuserUstomer) =>
        cuserUstomer.username == user.displayName &&
            cuserUstomer.email == user.email,
        orElse: () => WooCustomer());

    // If the user is found, print their name. Otherwise, print 'User not found'.
    if (cuserUstomer?.username == null) {
      return false;
    } else {
      _userID = cuserUstomer!.id.toString();
      addressList = [
        {
          "address": cuserUstomer?.billing?.address1,
          "area": cuserUstomer?.billing?.state,
          "city": cuserUstomer?.billing?.city,
          "state": cuserUstomer?.billing?.state,
          "country": cuserUstomer?.billing?.country,
          "mobile": cuserUstomer?.billing?.phone
        }
      ];
      return true;
    }


    // email = "";
    // id = "";
    // displayName = "";
    // status = sessionEnums.logout;
    notifyListeners();
  }

  Future<bool> initSession(GoogleSignInAccount? user,
      WoocommerceProvider custWoocommerceProvider) async {



    favoritList.clear();
    email = user!.email;
    id = user.id;
    if (user.displayName != null) displayName = user.displayName!;
    status = sessionEnums.login;

    await custWoocommerceProvider.getCustomerByEmail(user.email);
    List<WooCustomer>? cutomer =
    await custWoocommerceProvider.api_Woocommerce.listWooCustomer;

    WooCustomer? cuserUstomer = cutomer?.firstWhere(
            (cuserUstomer) =>
        cuserUstomer.username == user.displayName &&
            cuserUstomer.email == user.email,
        orElse: () => WooCustomer());

    // If the user is found, print their name. Otherwise, print 'User not found'.
    if (cuserUstomer?.username == null) {
      return false;
    } else {
      _userID = cuserUstomer!.id.toString();
      addressList = [
        {
          "address": cuserUstomer?.billing?.address1,
          "area": cuserUstomer?.billing?.state,
          "city": cuserUstomer?.billing?.city,
          "state": cuserUstomer?.billing?.state,
          "country": cuserUstomer?.billing?.country,
          "mobile": cuserUstomer?.billing?.phone
        }
      ];
      loadFavoritList(custWoocommerceProvider,_userID);
      return true;
    }
    // email = "";
    // id = "";
    // displayName = "";
    // status = sessionEnums.logout;
    notifyListeners();
  }

  loadFavoritList(WoocommerceProvider custWoocommerceProvider,String _userID)async{
    favoritList= await custWoocommerceProvider.api_CustomWoocommerce.ListFavorit(_userID);
  }

  Future<bool> updateAddress(String userID, String email,
      WoocommerceProvider custWoocommerceProvider, address, city, state,
      phoneArea, country) async
  {
    bool result = await custWoocommerceProvider.updateAddressWooCustomer(
        userID,
        email,
        displayName,
        address,
        city,
        state,
        phoneArea,
        country);

    return result;
  }

  Future<bool> register(GoogleSignInAccount? user,
      WoocommerceProvider custWoocommerceProvider, address, city, state,
      phoneArea, country) async
  {
    email = user!.email;
    id = user.id;
    if (user.displayName != null) displayName = user.displayName!;

    bool result = await custWoocommerceProvider.createWooCustomer(
        user.email,
        displayName,
        address,
        city,
        state,
        phoneArea,
        country);

    if (result == true)
      status = sessionEnums.login;

    return result;
  }
  //var duration = Duration(milliseconds: 1000);
  //Timer(duration, await navigationPage);
  void showMessageDialog(BuildContext context, String message) {
    if (message != null) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Info'),
              content: Text(message!),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed(HappyShopHome.routeName),
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }
}
