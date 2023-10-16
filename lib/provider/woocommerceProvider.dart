import 'package:GiorgiaShop/pojo/customer/customers.dart';
import 'package:flutter/cupertino.dart';

import '../getIt/woocommecre/APICustomWooCommerce.dart';
import '../getIt/woocommecre/API_Woocommerce.dart';
import '../pojo/products.dart';
import 'abstracted/Woocommerce.dart';
import 'package:flutter_wp_woocommerce/models/customer.dart';
class WoocommerceProvider extends ChangeNotifier implements Woocommerce {
  final API_Woocommerce api_Woocommerce;
  final APICustomWooCommerce api_CustomWoocommerce;
  WoocommerceProvider(
      {required this.api_Woocommerce, required this.api_CustomWoocommerce});

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
}
