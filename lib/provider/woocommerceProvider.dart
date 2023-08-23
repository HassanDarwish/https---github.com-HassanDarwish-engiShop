


import 'package:flutter/cupertino.dart';

import '../getIt/woocommecre/APICustomWooCommerce.dart';
import '../getIt/woocommecre/API_Woocommerce.dart';
import '../pojo/products.dart';

class WoocommerceProvider  extends ChangeNotifier{

  final API_Woocommerce api_Woocommerce;
  final APICustomWooCommerce api_CustomWoocommerce;
  WoocommerceProvider({required this.api_Woocommerce,required this.api_CustomWoocommerce});

  Future  getCategories() {
    return api_Woocommerce.listAllCategories;
  }

  Future getCategoriesByCount(int count){
    return api_Woocommerce.listCategories;
  }
  Future<products> getProductByCategory(String catId) async {
    return api_CustomWoocommerce.getProductByCategory(catId);
  }
  Future<products> getProductBy_Category(String catId,String order,String per_page) async {
    return api_CustomWoocommerce.getProductBy_Category(  catId,  order,  per_page);
  }
}