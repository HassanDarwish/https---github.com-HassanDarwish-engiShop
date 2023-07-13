import 'package:flutter_wp_woocommerce/woocommerce.dart';

abstract class API_Woocommerce {
  Future getCategories();
  late Future<List<WooProductCategory>> listCategories;
}

class API_Woocommerce_Implementation extends API_Woocommerce {
  late Future<List<WooProductCategory>> listCategories;
  var baseUrl = "http://engy.jerma.net";
  var consumerKey = "ck_314081f754984f4ec9a55e8ca4c2171bd071ea56";
  var consumerSecret = "cs_8ae1b05d30d722960f3d65136dd82ee0433417cf";

  Future getCategories() async {
    WooCommerce woocommerce = WooCommerce(
        baseUrl: baseUrl,
        consumerKey: consumerKey,
        consumerSecret: consumerSecret);
    listCategories = woocommerce.getProductCategories();
  }
}
