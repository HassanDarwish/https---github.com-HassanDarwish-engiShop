import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get_it/get_it.dart';

import '../config/APIConfig.dart';

GetIt getIt = GetIt.instance;

abstract class API_Woocommerce {
  Future getCategories();
  Future getCategoriesByCount(int count);
  Future searchCustomerByEmail(String email);

  late Future<List<WooProductCategory>> listCategories;
  late Future<List<WooProductCategory>> listAllCategories;
  late Future<List<WooCustomer>> listWooCustomer;
}

class API_Woocommerce_Implementation extends API_Woocommerce {
  late Future<List<WooProductCategory>> listCategories;
  late Future<List<WooProductCategory>> listAllCategories;
  late Future<List<WooCustomer>> listWooCustomer;
  var baseUrl = "http://engy.jerma.net";

  //var consumerKey = "ck_314081f754984f4ec9a55e8ca4c2171bd071ea56";
  //var consumerSecret = "cs_8ae1b05d30d722960f3d65136dd82ee0433417cf";

  /*
  Notes
  https://woocommerce.github.io/woocommerce-rest-api-docs/

   */
  Future searchCustomerByEmail(String email) async {
    String consumerKey = getIt<API_Config>().config.consumerKey;
    String consumerSecret = getIt<API_Config>().config.consumerSecret;

    final WooCommerce woocommerce = WooCommerce(
        baseUrl: baseUrl,
        consumerKey: consumerKey,
        consumerSecret: consumerSecret);

    listWooCustomer = woocommerce.getCustomers();
  }

  Future getCategories() async {
    String consumerKey = getIt<API_Config>().config.consumerKey;
    String consumerSecret = getIt<API_Config>().config.consumerSecret;
    WooCommerce woocommerce = WooCommerce(
        baseUrl: baseUrl,
        consumerKey: consumerKey,
        consumerSecret: consumerSecret);
    listAllCategories = woocommerce.getProductCategories(
      perPage: 100,
    );
  }

  Future getCategoriesByCount(int count) async {
    String consumerKey = getIt<API_Config>().config.consumerKey;
    String consumerSecret = getIt<API_Config>().config.consumerSecret;
    WooCommerce woocommerce = WooCommerce(
        baseUrl: baseUrl,
        consumerKey: consumerKey,
        consumerSecret: consumerSecret);
    listCategories = woocommerce.getProductCategories(
      perPage: count,
    );
  }
}

/////