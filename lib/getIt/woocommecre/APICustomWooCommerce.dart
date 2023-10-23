import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:GiorgiaShop/pojo/order/lineItems.dart';
import 'package:flutter_wp_woocommerce/models/customer.dart';
import 'package:GiorgiaShop/pojo/coupon/coupons.dart';
import 'package:GiorgiaShop/pojo/products.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../pojo/customer/customers.dart';
import '../config/APIConfig.dart';

GetIt getIt = GetIt.instance;

abstract class APICustomWooCommerce {
  String getOAuthURL(String requestMethod, String queryUrl);
  Future<products> getProductByCategory(String catId);
  Future<products> getProductBy_Category(
      String catId, String order, String per_page);
  Future get_coupon(String code);
  Future<customers> getCustomer(String name, String email);
  Future<customers> updateWooCustomer(String id,WooCustomer cust);
  Future<bool> createOrder2(String userID,String displayName,Map addressList
      ,String cartFinalPrice,String CUR_CART_COUNTT,Map itemMap,List<product> products,String promocode,String email) ;

}

class APICustomWooCommerce_Implementation extends APICustomWooCommerce {
  //String consumerKey ="";// "ck_314081f754984f4ec9a55e8ca4c2171bd071ea56";
  //String consumerSecret ="";// "cs_8ae1b05d30d722960f3d65136dd82ee0433417cf";
  Future<bool> createOrder2(String userID,String displayName,Map addressList
      ,String cartFinalPrice,String CUR_CART_COUNTT,Map itemMap,List<product> products,String promocode,String email) async{

    late var product_List;
    // TODO: implement getProductByCategory


    Map<String,int> lineItemsMap= {};
    List<Map<String, dynamic>> lineItems=List.empty(growable: true);
    List<Map<String, dynamic>> listmetaMap=List.empty(growable: true);


    for (var product in products) {
      if(lineItemsMap.isNotEmpty)
        lineItemsMap={};

           lineItemsMap['"product_id"']=int.parse(product.id);

          if(product.SelectedAttribute!.length>0) {
            lineItemsMap['"quantity"'] =itemMap[product.identify_value.toString()];
            for (var attr in product.attributes!) {
              Map<String, dynamic> meta_data={};
              meta_data['"key"']='"${attr.name+'_'+getRandomString()}"';
              meta_data['"value"']='"${product.SelectedAttribute![attr.name]!}"';
              listmetaMap.add(meta_data);

            }
          }else{
            lineItemsMap['"quantity"'] = itemMap[product.id];
          }
           lineItems.add(lineItemsMap);
    }
    dynamic C={
      '"payment_method"': '"COD"',
      '"payment_method_title"': '"CASH On Delever"',
    '"set_paid"': '"false"',

      '"billing"': {
        '"first_name"': '"${displayName}"',
        '"last_name"': '""',
        '"address_1"': '"${addressList["address"]}"',
        '"city"': '"${addressList["city"]}"',
        '"state"': '"${addressList["state"]}"',
        '"postcode"': '""',
        '"country"': '"${addressList["country"]}"',
        '"email"': '"${email}"',
        '"phone"': '"${addressList["mobile"]}"',
      },
      '"shipping"': {
        '"first_name"': '"${displayName}"',
        '"last_name"': '""',
        '"address_1"': '"${addressList["address"]}"',
        '"city"': '"${addressList["city"]}"',
        '"state"': '"${addressList["state"]}"',
        '"postcode"': '""',
        '"country"':  '"${addressList["country"]}"',
      },
      '"line_items"': "${lineItems}",
      '"meta_data"':"${listmetaMap}"

      //"${listmetaMap}",
    };

print (C.toString());

    var response = await http.post(
        Uri.parse(getOAuthURL(
            "POST",
            'http://engy.jerma.net/wp-json/wc/v3/orders' )),
        headers: {"Content-Type": "Application/json"},
        body: C.toString()

    );

    product_List = response.body;
print(product_List);

    if (product_List != null) {
      return true;
    } else {
      return false;
      // The order failed to be created.
    }
  }



  Future<customers> getCustomer(String name, String email) async {
    //http://engy.jerma.net/wp-json/wc/v3/customers/?search=john.doe&email=john.doe@example.com&role=customer

    customers customer;
    try {
      // TODO: implement getProductByCategory
      var response = await http.get(
          Uri.parse(getOAuthURL("GET",
              'http://engy.jerma.net/wp-json/wc/v3/customers?search=${name}')),
          headers: {"Content-Type": "Application/json"});

      List<dynamic> Json = jsonDecode(response.body);
      !Json.isEmpty
          ? customer = customers.fromJson(jsonDecode(response.body))
          : customer = customers(email: "empty");
    } catch (e) {
      throw e;
    }
    return customer;
  }

  Future get_coupon(String code) async {
    coupons? coupon;
    try {
      // TODO: implement getProductByCategory
      var response = await http.get(
          Uri.parse(getOAuthURL("GET",
              'http://engy.jerma.net/wp-json/wc/v3/coupons?code=' + code)),
          headers: {"Content-Type": "Application/json"});

      List<dynamic> Json = jsonDecode(response.body);
      !Json.isEmpty
          ? coupon = coupons.fromJson(jsonDecode(response.body))
          : coupon = null;
    } catch (e) {
      throw e;
    }
    return coupon;
  }

  @override
  Future<products> getProductByCategory(String catId) async {
    late products product_List;
    // TODO: implement getProductByCategory

    var response = await http.get(
        Uri.parse(getOAuthURL(
            "GET",
            'http://engy.jerma.net/wp-json/wc/v3/products?category=' +
                catId +
                "&status=publish")),
        headers: {"Content-Type": "Application/json"});
//List<dynamic> list = jsonDecode(jsonString);
    product_List = products.fromJson(response.body);

    return product_List;
  }

  @override
  Future<products> getProductBy_Category(
      String catId, String order, String per_page) async {
    // TODO: implement getProductByCategory
    late products product_List;

    var response = await http.get(
        Uri.parse(getOAuthURL(
            "GET",
            'http://engy.jerma.net/wp-json/wc/v3/products?category=' +
                catId +
                "&order=" +
                order +
                "&per_page=" +
                per_page +
                "&status=publish")),
        headers: {"Content-Type": "Application/json"});
//List<dynamic> list = jsonDecode(jsonString);
    product_List = products.fromJson(response.body);

    return product_List;
  }


  Future<customers> updateWooCustomer(String id,WooCustomer cust) async
  {
    customers customer;
    String json = jsonEncode(cust);
    try {
      // TODO: implement getProductByCategory
      var response = await http.post(
        Uri.parse(getOAuthURL("PUT",
            'http://engy.jerma.net/wp-json/wc/v3/customers/${id}')),
        headers: {"Content-Type": "Application/json"},
        body: json,
      );

      List<dynamic> Json = jsonDecode(response.body);
      !Json.isEmpty
          ? customer = customers.fromJson(jsonDecode(response.body))
          : customer = customers(email: "empty");
    } catch (e) {
      throw e;
    }

    return customer;
  }
  String getRandomString(){
    Random rand = Random();
    List<int> codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });
    /// Random string uniquely generated to identify each signed request
    String nonce = String.fromCharCodes(codeUnits);
    return nonce;
  }
  String getOAuthURL(String requestMethod, String queryUrl) {
    String consumerKey = getIt<API_Config>().config.consumerKey;
    String consumerSecret = getIt<API_Config>().config.consumerSecret;
    String token = "";
    String url = queryUrl;
    bool containsQueryParams = url.contains("?");

    Random rand = Random();
    List<int> codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    /// Random string uniquely generated to identify each signed request
    String nonce = String.fromCharCodes(codeUnits);

    /// The timestamp allows the Service Provider to only keep nonce values for a limited time
    int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    String parameters = "oauth_consumer_key=" +
        consumerKey +
        "&oauth_nonce=" +
        nonce +
        "&oauth_signature_method=HMAC-SHA1&oauth_timestamp=" +
        timestamp.toString() +
        "&oauth_token=" +
        token +
        "&oauth_version=1.0&";

    if (containsQueryParams == true) {
      parameters = parameters + url.split("?")[1];
    } else {
      parameters = parameters.substring(0, parameters.length - 1);
    }

    Map<dynamic, dynamic> params = QueryString.parse(parameters);
    Map<dynamic, dynamic> treeMap = new SplayTreeMap<dynamic, dynamic>();
    treeMap.addAll(params);

    String parameterString = "";

    for (var key in treeMap.keys) {
      parameterString = parameterString +
          Uri.encodeQueryComponent(key) +
          "=" +
          treeMap[key] +
          "&";
    }

    parameterString = parameterString.substring(0, parameterString.length - 1);

    String method = requestMethod;
    String baseString = method +
        "&" +
        Uri.encodeQueryComponent(
            containsQueryParams == true ? url.split("?")[0] : url) +
        "&" +
        Uri.encodeQueryComponent(parameterString);

    String signingKey = consumerSecret + "&" + token;
    crypto.Hmac hmacSha1 =
    crypto.Hmac(crypto.sha1, utf8.encode(signingKey)); // HMAC-SHA1

    /// The Signature is used by the server to verify the
    /// authenticity of the request and prevent unauthorized access.
    /// Here we use HMAC-SHA1 method.
    crypto.Digest signature = hmacSha1.convert(utf8.encode(baseString));

    String finalSignature = base64Encode(signature.bytes);

    String requestUrl = "";

    if (containsQueryParams == true) {
      requestUrl = url.split("?")[0] +
          "?" +
          parameterString +
          "&oauth_signature=" +
          Uri.encodeQueryComponent(finalSignature);
    } else {
      requestUrl = url +
          "?" +
          parameterString +
          "&oauth_signature=" +
          Uri.encodeQueryComponent(finalSignature);
    }

    return requestUrl;
  }
}

class QueryString {
  /// Parses the given query string into a Map.
  static Map parse(String query) {
    var search = new RegExp('([^&=]+)=?([^&]*)');
    var result = new Map();

// Get rid off the beginning ? in query strings.
    if (query.startsWith('?')) query = query.substring(1);

// A custom decoder.
    decode(String s) => Uri.decodeComponent(s.replaceAll('+', ' '));

// Go through all the matches and build the result map.
    for (Match match in search.allMatches(query)) {
      result[decode(match.group(1)!)] = decode(match.group(2)!);
    }

    return result;
  }
}
