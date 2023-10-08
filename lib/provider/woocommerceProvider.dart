import 'package:GiorgiaShop/pojo/customer/customers.dart';
import 'package:flutter/cupertino.dart';

import '../getIt/woocommecre/APICustomWooCommerce.dart';
import '../getIt/woocommecre/API_Woocommerce.dart';
import '../pojo/products.dart';
import 'abstracted/Woocommerce.dart';

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
    api_Woocommerce.searchCustomerByEmail(email);
  }
}
