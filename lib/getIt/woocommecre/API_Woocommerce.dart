
import 'package:flutter_wp_woocommerce/woocommerce.dart';
abstract  class API_Woocommerce{
    Future getProducts() ;
    late Future<List<WooProductCategory>> listProduct;
}
class API_Woocommerce_Implementation extends API_Woocommerce{
  late Future<List<WooProductCategory>> listProduct;

  Future getProducts() async {
    List<dynamic> catList=List.empty(growable: true);
    WooCommerce woocommerce = WooCommerce(
        baseUrl: "http://engy.jerma.net",
        consumerKey: "ck_314081f754984f4ec9a55e8ca4c2171bd071ea56",
        consumerSecret: "cs_8ae1b05d30d722960f3d65136dd82ee0433417cf");
     listProduct = woocommerce.getProductCategories();

  }

}