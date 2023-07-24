import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';


abstract class API_Woocommerce {
  Future getCategories();
  Future getProductByCategory(String categoryId);
  late Future<List<WooProductCategory>> listCategories;
}

class API_Woocommerce_Implementation extends API_Woocommerce {
  late Future<List<WooProductCategory>> listCategories;
  var baseUrl = "http://engy.jerma.net";
  var consumerKey = "ck_314081f754984f4ec9a55e8ca4c2171bd071ea56";
  var consumerSecret = "cs_8ae1b05d30d722960f3d65136dd82ee0433417cf";


  /*
  Notes
  https://woocommerce.github.io/woocommerce-rest-api-docs/

   */
  Future getCategories() async {
    WooCommerce woocommerce = WooCommerce(
        baseUrl: baseUrl,
        consumerKey: consumerKey,
        consumerSecret: consumerSecret);
    listCategories = woocommerce.getProductCategories(perPage: 100,);
    print(listCategories.toString());
  }

  Future getProductByCategory(String categoryId) async {
    WooCommerce woocommerce = WooCommerce(
        baseUrl: baseUrl,
        consumerKey: consumerKey,
        consumerSecret: consumerSecret);
    Future<List<WooProduct>> listProducts =  woocommerce.getProducts();

    listProducts.then((value) => print(value.length));
    listProducts.then((products) {
      List<WooProduct> filteredProducts = products.where((product) => product.categories[0].id == categoryId).toList();

      // Print the filtered products.
      for (var product in filteredProducts) {
        print(product.name);
      }
    });

    int _stringToLength(String s) {
      // as many lines of code here as necessary
      return s.length;
    }

  }


}

/////