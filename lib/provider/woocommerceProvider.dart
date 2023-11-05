import 'package:GiorgiaShop/pojo/customer/customers.dart';
import 'package:flutter/cupertino.dart';

import '../getIt/woocommecre/APICustomWooCommerce.dart';
import '../getIt/woocommecre/API_Woocommerce.dart';
import '../pojo/favorit/Favorit.dart';
import '../pojo/products.dart';
import '../pojo/tracking/TrackingOrder.dart';
import 'Session.dart';
import 'abstracted/Woocommerce.dart';
import 'package:flutter_wp_woocommerce/models/customer.dart';
import 'package:flutter_wp_woocommerce/models/order.dart' as orderr;
class WoocommerceProvider extends ChangeNotifier implements Woocommerce {
  final API_Woocommerce api_Woocommerce;
  final APICustomWooCommerce api_CustomWoocommerce;
  WoocommerceProvider(
      {required this.api_Woocommerce, required this.api_CustomWoocommerce});

   Future<List<TrackingOrder>> getOrderByUserId(String userId)async
  {
    List<TrackingOrder>WooOrders=  await api_CustomWoocommerce.getOrderByUserId(userId);


    return WooOrders;
  }


   Future<List<dynamic>>  ListFavorit(String userId) async {
    return   await api_CustomWoocommerce.ListFavorit(userId);
  }
  Future<bool>  addToFavorite(SessionImplementation sessionImp,String userID,String itemId)async{
    bool result=await api_CustomWoocommerce.addToFavorite(userID,itemId);
    if(result==true)sessionImp.loadFavoritList(this,userID);
    return result;

  }

  Future<bool>  createOrder2(String userID,String displayName,Map addressList
      ,String cartFinalPrice,String shippingFees,String totalTax,String CUR_CART_COUNTT,Map itemMap,List<product> products,String promocode,String email)
  {
    return api_CustomWoocommerce.createOrder2(  userID,  displayName,  addressList
        ,  cartFinalPrice, shippingFees, totalTax , CUR_CART_COUNTT,  itemMap,  products,  promocode,  email);
  }

  Future<bool>  createOrder(String userID,String displayName,Map addressList
      ,String cartFinalPrice,String CUR_CART_COUNTT,Map itemMap,List<product> products,String promocode)
  {

    return api_Woocommerce.createOrder(  userID,  displayName,  addressList
        ,  cartFinalPrice,  CUR_CART_COUNTT,  itemMap,  products,  promocode);
  }
  Future getCategories() {
    return api_Woocommerce.listAllCategories;
  }

  Future getCategoriesByCount(int count) {
    return api_Woocommerce.listCategories;
  }

  Future<products> getProductByCategory(String catId) async {
    Future<products> result;

    result = api_CustomWoocommerce.getProductByCategory(catId);

    return result;
  }

  Future<products> getProductBy_Category(
      String catId, String order, String per_page) async {
    Future<products> result;

    result =
        api_CustomWoocommerce.getProductBy_Category(catId, order, per_page);

    return result;
  }

  Future<customers> getCustomer(String username, String email) async {
    Future<customers> result;

    result = api_CustomWoocommerce.getCustomer(username, email);

    return result;
  }

  Future getCustomerByEmail(String email) async {
    await api_Woocommerce.searchCustomerByEmail(email);
  }
  Future updateAddressWooCustomer(String id,String email,String username,address, city, state, phoneArea, country) async{

    //WooCustomer data=WooCustomer(email: email,username: username,billing: Billing( firstName: username ,email: email,address1: address, city: city,country: country,state: state,phone: phoneArea));


    Map? data = {
        "email": email,
        "username":username,
        "billing": {
          "address_1": address,
          "city":city,
          "state":state,
          "phone":phoneArea,
          "country":country,
          "email":email
        },
    };

    WooCustomer result=await api_Woocommerce.updateWooCustomer(id, data);

    if(result!=null)
      return true;

    return false;
  }
  Future createWooCustomer(String userID,String username,address, city, state, phoneArea, country) async{
    bool result=await api_Woocommerce.createWooCustomer(userID, username,address, city, state, phoneArea, country);
    return result;
  }
  Future<bool> deleteFromFavorite(SessionImplementation sessionImp,String userID,String productId) async{
    bool result=await api_CustomWoocommerce.deleteFromFavoritlist(userID,productId);
    if(result==true)sessionImp.loadFavoritList(this,userID);
    return result;
  }
}


