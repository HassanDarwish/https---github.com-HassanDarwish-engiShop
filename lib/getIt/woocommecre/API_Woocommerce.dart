import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:logger/logger.dart';
import 'dart:developer' as developer;
import 'package:GiorgiaShop/pojo/Woo/WooCustomer.dart' as WooCusomerr;
import 'package:GiorgiaShop/pojo/Woo/WooProductCategory.dart';
import 'package:GiorgiaShop/pojo/Woo/WooOrderPayload.dart' as WooOrderPayload;
import 'package:GiorgiaShop/pojo/Woo/WooOrder.dart' as WooOrder;
import 'package:get_it/get_it.dart';
import 'package:GiorgiaShop/pojo/products.dart';
import 'package:GiorgiaShop/getIt/config/APIConfig.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;
import 'package:GiorgiaShop/pojo/customer/customers.dart';

import '../../pojo/Woo/WooCustomer.dart';
import '../../pojo/customer/customer.dart';
GetIt getIt = GetIt.instance;

abstract class API_Woocommerce {
  Future getCategories();
  Future getCategoriesByCount(int count);
  Future searchCustomerByEmail(String email);
  Future<bool> createWooCustomer(String email,String username,address, city, state, phoneArea, country);
  Future updateWooCustomer(String id,Map data);

  
  late Future<List<WooProductCategory>> listCategories;
  late Future<List<WooProductCategory>> listAllCategories;
  late Future<List<WooCusomerr.WooCustomer>> listWooCustomer;


  //http://engy.jerma.net/wp-json/wc/v3/customers?username=HassanAli&email=hassanaly@msn.com&password&first_name=Hassan&last_name=Ali
}

class API_Woocommerce_Implementation extends API_Woocommerce {
  late Future<List<WooProductCategory>> listCategories;
  late Future<List<WooProductCategory>> listAllCategories;
  late Future<List<WooCusomerr.WooCustomer>> listWooCustomer;
  var baseUrl = "http://engy.jerma.net";

  //var consumerKey = "ck_314081f754984f4ec9a55e8ca4c2171bd071ea56";
  //var consumerSecret = "cs_8ae1b05d30d722960f3d65136dd82ee0433417cf";

  /*
  Notes
  https://woocommerce.github.io/woocommerce-rest-api-docs/

   */

  Future updateWooCustomer(String userID,Map mapData) async {
    late WooCusomerr.WooCustomer result;
    result =await update_WooCustomer(  userID,  mapData);
    return result;
  }

  Future<WooCusomerr.WooCustomer> update_WooCustomer(String userID,Map mapData) async{

    String jsonData = json.encode(mapData);

    //WooCustomer result=await woocommerce.updateCustomer(id: int.parse(userID),data:mapData);
    //var url = Uri.parse('https://yourstore.com/wp-json/wc/v3/customers/$userID');
    try {
    var response = await http.put(
      Uri.parse(getOAuthURL("PUT",
          'http://engy.jerma.net/wp-json/wc/v3/customers/${userID}')),
      headers: {"Content-Type": "Application/json"},
      body: json,
    );

// Convert the customer data to JSON format
      if (response.statusCode == 200) {

        final Map<String, dynamic> jsonList = jsonDecode(response.body);
        return WooCusomerr.WooCustomer.fromJson(jsonList);

        /*
        List<dynamic> Json = jsonDecode(response.body);
        !Json.isEmpty
            ? customer = customers.fromJson(jsonDecode(response.body))
            : customer = customers(email: "empty");*/
      }
      }catch(e){
      Logger().e(e.toString()+'GiorgiaShop Error erro in updateWooCustomer');
    }


      WooCusomerr.WooCustomer customer=WooCusomerr.WooCustomer (email: "empty");
    return customer ;
  }
  Future<bool> createWooCustomer(String email,String username,address, city, state, phoneArea, country) async{



    WooCustomer customer=WooCustomer();
    customer.email=email;
    customer.firstName=username;
    customer.username=username;
    customer.password=randomString();
    customer.billing=Billing(phone: phoneArea,country: country,state: state,address1: address,firstName: username,
    lastName: "",city: city,postcode: "",company: "",email: email,address2: "");
    String jsonData = json.encode(customer);
    try {
      var response = await http.post(
        Uri.parse(getOAuthURL("POST",
            'https://engy.jerma.net/wp-json/wc/v3/customers')),
        headers: {"Content-Type": "Application/json"},
        body: jsonData,
      );
    }catch(e){
      Logger().e(e.toString()+'GiorgiaShop Error erro in createWooCustomer');
    }

  return true;
  }
  Future<List<WooCusomerr.WooCustomer>> search_CustomerByEmail(String email) async {

    try {
      var response = await http.get(
        Uri.parse(getOAuthURL("GET",
            'https://engy.jerma.net/wp-json/wc/v3/customers?email=${email}')),
        headers: {"Content-Type": "Application/json"},

      );
      late customers customer;
// Convert the customer data to JSON format
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => WooCusomerr.WooCustomer.fromJson(json)).toList();


      }
    }catch(e){
      Logger().e(e.toString()+'GiorgiaShop Error erro in searchCustomerByEmail');
    }
  return [];
  }
  Future searchCustomerByEmail(String email) async {
    listWooCustomer=search_CustomerByEmail(email);
  }
  Future<List<WooProductCategory>> get_Categories() async {

    try {
      var response = await http.get(
        Uri.parse(getOAuthURL("GET",
            'http://engy.jerma.net/wp-json/wc/v3/products/categories')),
        headers: {"Content-Type": "Application/json"},
      );
      late customers customer;
// Convert the customer data to JSON format
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => WooProductCategory.fromJson(json)).toList();

      }
    }catch(e){
      Logger().e(e.toString()+'GiorgiaShop Error erro in searchCustomerByEmail');
    }
    return [];
  }
  Future getCategories() async {
    listAllCategories=get_Categories();
  }
  Future<List<WooProductCategory>>  get_CategoriesByCount(int count) async {
    try {
      var response = await http.get(
        Uri.parse(getOAuthURL("GET",
            'http://engy.jerma.net/wp-json/wc/v3/products/categories?per_page=${count}')),
        headers: {"Content-Type": "Application/json"},
      );
      late customers customer;
// Convert the customer data to JSON format
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => WooProductCategory.fromJson(json)).toList();
    }
    }catch(e){
    Logger().e(e.toString()+'GiorgiaShop Error  in searchCustomerByEmail');
    }

    return [];
  }
  Future getCategoriesByCount(int count) async {
    //wp-json/wc/v3/products/categories?per_page=8
    listCategories=get_CategoriesByCount(count);

  }

  }
  String randomString(){
    Random rand = Random();
    List<int> codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    /// Random string uniquely generated to identify each signed request
    String nonce = String.fromCharCodes(codeUnits);
    return nonce;
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
  }}