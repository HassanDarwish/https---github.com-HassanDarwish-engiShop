import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:GiorgiaShop/pojo/order/shipping_lines.dart';
import 'package:http/http.dart' show IOClient;
import 'package:flutter_wp_woocommerce/models/order.dart' as orderr;
import 'package:GiorgiaShop/pojo/favorit/Favorit.dart';
 import 'package:flutter_wp_woocommerce/models/customer.dart';
import 'package:GiorgiaShop/pojo/coupon/coupons.dart';
import 'package:GiorgiaShop/pojo/products.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../pojo/customer/customers.dart';
import '../../pojo/tracking/TrackingOrder.dart';
import '../config/APIConfig.dart';
import 'APICustomWooCommerce.dart';


GetIt getIt = GetIt.instance;

abstract class APICustomWooCommerce {
  String getOAuthURL(String requestMethod, String queryUrl);
  Future<products> getProductByCategory(String catId);
  Future<products> getProductBy_Category(
      String catId, String order, String per_page);
  Future get_coupon(String code);
  Future<customers> getCustomer(String name, String email);
  //Future<customers> updateWooCustomer(String id,WooCustomer cust);
  Future<bool> createOrder2(String userID,String displayName,Map addressList
      ,String cartFinalPrice,String shippingFees,String totalTax,String CUR_CART_COUNTT,Map itemMap,List<product> products,String promocode,String email) ;
  Future<List<Favorit>> ListFavorit(userId);
  Future<bool> deleteFromFavoritlist(userId,productId);
  Future<bool> addToFavorite(String userID,String itemId);

  Future<List<TrackingOrder>> getOrderByUserId(String userId);
  HttpClient client = HttpClient()..badCertificateCallback = (X509Certificate cert, String host, int port) => true;

}

class APICustomWooCommerce_Implementation extends APICustomWooCommerce{
  //String consumerKey ="";// "ck_314081f754984f4ec9a55e8ca4c2171bd071ea56";
  //String consumerSecret ="";// "cs_8ae1b05d30d722960f3d65136dd82ee0433417cf";
  Future<List<TrackingOrder>> getOrderByUserId(String userId)async{
    //var orderList = <orderr.WooOrder>[];
    var orderList = List<TrackingOrder>.empty(growable: true);
    try {
      // TODO: implement getProductByCategory

      var request = await client.getUrl(
        Uri.parse(getOAuthURL(
            "GET",
            'https://engy.jerma.net/wp-json/wc/v3/orders?customer_id=${userId}')),
      ) ;
      request.headers.set('Content-Type', 'application/json');
      //request.headers.set('Authorization', 'Bearer YourAccessToken');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String responseBody = await response.transform(utf8.decoder).join();

       var orders = jsonDecode(responseBody) as List<dynamic>;


        for (var order in orders) {
          orderList.add(TrackingOrder.fromJson(order));
        }

      }
      // var response = await http.get(
      //     Uri.parse(getOAuthURL("GET",
      //         'http://engy.jerma.net/wp-json/wc/v3/orders?customer_id=${userId}')),
      //     headers: {"Content-Type": "Application/json"});
      // Decode the JSON response into a list of WooCommerce order objects.

      // var orders = jsonDecode(response.body) as List<dynamic>;
      // var orderList = List<TrackingOrder>.empty(growable: true);
      // for (var order in orders) {
      //   orderList.add(TrackingOrder.fromJson(order));
      // }
      // return orderList;
      return orderList;
    } catch (e) {
      throw e;
    }

  }
  @override
  Future<bool> addToFavorite(String userId,String productId)async{
    // TODO: implement addToFavorite http://engy.jerma.net/wp-json/wc/v3/favorites?product_id=150&user_id=8
    try {
      var request = await client.postUrl(
        Uri.parse(getOAuthURL(
            "POST",
            'https://engy.jerma.net/wp-json/wc/v3/favorites?product_id=${productId}&user_id=${userId}')),
      ) ;
      request.headers.set('Content-Type', 'application/json');
      //request.headers.set('Authorization', 'Bearer YourAccessToken');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {

      }


       // String url="http://engy.jerma.net/wp-json/wc/v3/favorites?product_id=${productId}&user_id=${userId}";
      // var response = await http.post(
      //     Uri.parse('http://engy.jerma.net/wp-json/wc/v3/favorites?product_id=${productId}&user_id=${userId}') ,
      //     headers: {"Content-Type": "Application/json"}
      // );
      //
      // dynamic JsonResponse = jsonDecode(response.body);

    } catch (e) {
      return false;
      throw e;
      return false;
      //throw e;
    }
    return true;

  }
  @override
  Future<bool> deleteFromFavoritlist(userId, productId) async {
    // TODO: implement deleteFromFavoritlist http://engy.jerma.net/wp-json/wc/v3/favor/${userId}/${productId}/

    /*******************************************************************/
    try{
    var request = await client.deleteUrl(
      Uri.parse(getOAuthURL(
          "DELETE",
          'https://engy.jerma.net/wp-json/wc/v3/favor/${userId}/${productId}')),
    ) ;
    request.headers.set('Content-Type', 'application/json');
    //request.headers.set('Authorization', 'Bearer YourAccessToken');
    HttpClientResponse response = await request.close();
     if (response.statusCode == 200) {

    }

  } catch (e) {
  return false;
  throw e;
  return false;
  //throw e;
  }
  return true;

    // try {
    //   // TODO: implement getProductByCategory
    //   var response = await http.delete(
    //     Uri.parse('http://engy.jerma.net/wp-json/wc/v3/favor/${userId}/${productId}') ,
    //     headers: {"Content-Type": "Application/json"}
    //   );
    //
    //   dynamic JsonResponse = jsonDecode(response.body);
    //   print(JsonResponse);
    // } catch (e) {
    // return false;
    //   throw e;
    // return false;
    //   //throw e;
    // }
    return true;


}

Future<List<Favorit>> ListFavorit(userId) async{
     List  listFavorit=List<Favorit>.empty(growable: true);
     List<dynamic>   list_=List<Favorit>.empty(growable: true);
     Map<String, dynamic> responseMap;
     Favorit favorit;
     /*******************************************************************/
  var request = await client.getUrl(
    Uri.parse(getOAuthURL(
        "GET",
        'https://engy.jerma.net/wp-json/wc/v3/favorites/${userId}/')),
  ) ;
  request.headers.set('Content-Type', 'application/json');
  //request.headers.set('Authorization', 'Bearer YourAccessToken');
  HttpClientResponse response = await request.close();
  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON and return the config
    String responseBody = await response.transform(utf8.decoder).join();

     responseMap = jsonDecode(responseBody);
    List<dynamic> Json=responseMap["products"];
    !Json.isEmpty
        ? favorit=Favorit.fromJson(responseMap)
        : favorit = Favorit.fromJson(responseMap);
  }else{
    favorit = Favorit.empty();
  }

     /******************************************
     Map<String, dynamic> responseMap;
     Favorit favorit;

       // TODO: implement getProductByCategory
       var response = await http.get(
           Uri.parse(
               'http://engy.jerma.net/wp-json/wc/v3/favorites/${userId}/'),
           headers: {"Content-Type": "Application/json"});

       responseMap = jsonDecode(response.body);
       list_=responseMap["products"];
         favorit=Favorit.fromJson(response.body);
*/
    return   favorit.favorit_List;
  }
  Future<bool> createOrder2(String userID,String displayName,Map addressList
      ,String cartFinalPrice,String shippingFees,String totalTax,String CUR_CART_COUNTT,Map itemMap,List<product> products,String promocode,String email) async{

    late var product_List;
    // TODO: implement getProductByCategory
    String shippingFees1;
    double finalExpanses=double.parse(shippingFees)+double.parse(totalTax);
    shippingFees1=finalExpanses.toString();

    Map<String,int> lineItemsMap= {};
    //List<Map<String, dynamic>> lineItems=List.empty(growable: true);
    //List<Map<String, dynamic>> listmetaMap=List.empty(growable: true);
    List<LineItem> lineItems=List.empty(growable: true);
    List<meta_data> listmetaMap=List.empty(growable: true);

    int quantity=0;
    for (var product in products) {
      LineItem lineItemsMap;

           //lineItemsMap['"product_id"']=int.parse(product.id);

          if(product.SelectedAttribute!.length>0) {
            //lineItemsMap['"quantity"'] =itemMap[product.identify_value.toString()];
            int quantity=itemMap[product.identify_value.toString()];
            for (var attr in product.attributes!) {
              //Map<String, dynamic> meta_data={};
              meta_data metaData=new meta_data(value: product.SelectedAttribute![attr.name]!,key: attr.name+'_'+getRandomString());
            //  meta_data['"key"']='"${attr.name+'_'+getRandomString()}"';
            //  meta_data['"value"']='"${product.SelectedAttribute![attr.name]!}"';
              //lineItemsMap['"quantity"']=1;
              quantity=1;
              listmetaMap.add(metaData);

            }
          }else{
            //lineItemsMap['"quantity"'] = itemMap[product.id];
            quantity=itemMap[product.id];
          }
      lineItemsMap=new LineItem(quantity: quantity,product_id: int.parse(product.id));

           lineItems.add(lineItemsMap);
    }
    Billing Bi=new Billing(email: email,last_name:"" ,postcode:"" ,
         city: utf8.decode(utf8.encode(addressList["city"])),
         state:utf8.decode(utf8.encode(addressList["state"]))  ,
        country:utf8.decode(utf8.encode(addressList["country"])) ,
        first_name: displayName,
        phone: utf8.decode(utf8.encode(addressList["mobile"])) ,
        address_1:utf8.decode(utf8.encode(addressList["address"]))
    );


    Shipping Shi=new Shipping(last_name:"" ,postcode:"" ,city:
         utf8.decode(utf8.encode(addressList["city"])),
        state: utf8.decode(utf8.encode(addressList["state"]))  ,
        country: utf8.decode(utf8.encode(addressList["country"])) ,
        first_name: displayName ,
        address_1:utf8.decode(utf8.encode(addressList["address"]))
    );

    ShippingLine Shipping_Line=new ShippingLine(methodId: "flat_rate", method_title:"Flat Rate",total:shippingFees1);
    List<ShippingLine> ShipingList=List<ShippingLine>.empty(growable: true);
    ShipingList.add(Shipping_Line);

    C h=new C(payment_method: "COD", payment_method_title: "CASH On Delever", set_paid: "false",
        total: double.parse(cartFinalPrice), lineItems: lineItems, listmetaMap: listmetaMap, billing: Bi, shipping: Shi,
        shipping_lines: ShipingList);
/*
    Object C={
      '"payment_method"': '"COD"',
      '"payment_method_title"': '"CASH On Delever"',
      '"set_paid"': '"false"',
       '"total"': double.parse(cartFinalPrice),
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
      '"meta_data"':"${listmetaMap}",
      '"shipping_lines"': [
        {
          '"method_id"': '"flat_rate"',
          '"method_title"': '"Flat Rate"',
            '"total"': '"${shippingFees1}"',
        }
      ]

      //"${listmetaMap}",
    };
*/

    String json = jsonEncode(h.toJson());

    try {
      var request = await HttpClient().postUrl(
        Uri.parse(getOAuthURL("POST", 'https://engy.jerma.net/wp-json/wc/v3/orders')),
      );
      request.headers.set('Content-Type', 'application/json; charset=UTF-8');
      request.write(json);
      // Send the request
      HttpClientResponse response = await request.close();

      // Check the response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
         return true;
      } else{
        return false;
      }
 } catch (e) {
      throw e;
    }

    // var response = await http.post(
    //     Uri.parse(getOAuthURL(
    //         "POST",
    //         'http://engy.jerma.net/wp-json/wc/v3/orders' )),
    //     headers: {"Content-Type": "Application/json"},
    //     body: C.toString()
    //
    // );
    //
    // if (response.statusCode== 201) {
    //   return true;
    // } else {
    //   return false;
    //   // The order failed to be created.
    // }
  }



  Future<customers> getCustomer(String name, String email) async {
    //http://engy.jerma.net/wp-json/wc/v3/customers/?search=john.doe&email=john.doe@example.com&role=customer

    customers customer;
     var request = await client.getUrl(
      Uri.parse(getOAuthURL(
          "GET",
          'https://engy.jerma.net/wp-json/wc/v3/customers?search=${name}')),
    ) ;
    request.headers.set('Content-Type', 'application/json');
    //request.headers.set('Authorization', 'Bearer YourAccessToken');
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON and return the config
      String responseBody = await response.transform(utf8.decoder).join();
      List<dynamic> Json = jsonDecode(responseBody);
      !Json.isEmpty
          ? customer = customers.fromJson(jsonDecode(responseBody))
          : customer = customers(email: "empty");
    }else{
      customer = customers(email: "empty");
    }

    return customer;
  }

  Future get_coupon(String code) async {
    coupons? coupon;
    try {
      var request = await client.getUrl(
        Uri.parse(getOAuthURL(
            "GET",
            'https://engy.jerma.net/wp-json/wc/v3/coupons?code=' + code)),
      ) ;
      request.headers.set('Content-Type', 'application/json');
      //request.headers.set('Authorization', 'Bearer YourAccessToken');
      HttpClientResponse response = await request.close();
       if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON and return the config
        String responseBody = await response.transform(utf8.decoder).join();
       List<dynamic> Json = jsonDecode(responseBody);
      !Json.isEmpty
          ? coupon = coupons.fromJson(jsonDecode(responseBody))
          : coupon = null;
      }
    } catch (e) {
      throw e;
    }
    return coupon;
  }
  @override
  Future<products> getProductByCategory(String catId) async {
    late products product_List;
    // TODO: implement getProductByCategory

            var request = await client.getUrl(
            Uri.parse(getOAuthURL(
                "GET",
                'https://engy.jerma.net/wp-json/wc/v3/products?category=' +
                    catId +
                    "&status=publish")),
        ) ;
        request.headers.set('Content-Type', 'application/json');
        //request.headers.set('Authorization', 'Bearer YourAccessToken');
        HttpClientResponse response = await request.close();
        if (response.statusCode == 200) {
          // If the server returns a 200 OK response, parse the JSON and return the config
          String responseBody = await response.transform(utf8.decoder).join();
          product_List = products.fromJson(responseBody);
         }


    return product_List;
  }

  @override
  Future<products> getProductBy_Category(
      String catId, String order, String per_page) async {
    // TODO: implement getProductByCategory
    late products product_List;
    var request = await client.getUrl(
      Uri.parse(getOAuthURL(
          "GET",
          'https://engy.jerma.net/wp-json/wc/v3/products?category=' +
              catId +
              "&order=" +
              order +
              "&per_page=" +
              per_page +
              "&status=publish")),
    ) ;
    request.headers.set('Content-Type', 'application/json');
    //request.headers.set('Authorization', 'Bearer YourAccessToken');
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON and return the config
      String responseBody = await response.transform(utf8.decoder).join();
      product_List = products.fromJson(responseBody);
    }

    return product_List;
  }

/*
  Future<customers> updateWooCustomer(String id,WooCustomer cust) async
  {
    customers customer;
    String json = jsonEncode(cust);
    try {
      // TODO: implement getProductByCategory

      var request = await HttpClient().putUrl(
        Uri.parse(getOAuthURL("PUT", 'https://engy.jerma.net/wp-json/wc/v3/customers/${id}')),
      );
      request.headers.set('Content-Type', 'application/json');
      request.write(json);
      // Send the request
      HttpClientResponse response = await request.close();

      // Check the response status code
      if (response.statusCode == 200) {
        String responseBody = await response.transform(utf8.decoder).join();
        List<dynamic> Json = jsonDecode(responseBody);
        !Json.isEmpty
             ? customer = customers.fromJson(jsonDecode(responseBody))
             : customer = customers(email: "empty");
      }else{
        customer = customers(email: "empty");
      }

      // var response = await http.post(
      //   Uri.parse(getOAuthURL("PUT",
      //       'http://engy.jerma.net/wp-json/wc/v3/customers/${id}')),
      //   headers: {"Content-Type": "Application/json"},
      //   body: json,
      // );
      //  List<dynamic> Json = jsonDecode(response.body);
      // !Json.isEmpty
      //     ? customer = customers.fromJson(jsonDecode(response.body))
      //     : customer = customers(email: "empty");
    } catch (e) {
      throw e;
    }

    return customer;
  }
  */
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
}//class end

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

class Billing{
  String first_name="";
  String last_name="";
  String address_1="";
  String city="";
  String state="";
  String postcode="";
  String country="";
  String email="";
  String phone="";
  Billing({
    required this.first_name,
    required this.last_name,
    required this.address_1,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.email,
    required this.phone,
  });
  Map<String, dynamic> toJson() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'address_1': address_1,
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': country,
      'email': email,
      'phone': phone,
    };
  }
}
class Shipping{
  String first_name="";
  String last_name="";
  String address_1="";
  String city="";
  String state="";
  String postcode="";
  String country="";
  Shipping({
    required this.first_name,
    required this.last_name,
    required this.address_1,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
  });
  Map<String, dynamic> toJson() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'address_1': address_1,
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': country,
    };
  }
}
class ShippingLine {
  String methodId;
  String method_title;
  String total;
  ShippingLine.empty()
      : methodId = '',
        method_title = '',
        total = "0";

  ShippingLine({
    required this.methodId,
    required this.method_title,
    required this.total,
  });
  Map<String, dynamic> toJson() {
    return {
      'method_id': methodId,
      'method_title': method_title,
      'total': total,
    };
  }
  factory ShippingLine.fromJson(Map<String, dynamic> json) {
    return ShippingLine(
      methodId: json['method_id'],
      method_title: json['method_title'],
      total: json['total'],
    );
  }
}
class meta_data{
  String key;
  String value;
  meta_data({required this.key, required this.value});

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}
class LineItem {
  int product_id;
  int quantity;

  LineItem({
    required this.product_id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': product_id,
      'quantity': quantity,
    };
  }
}
class C {
  String payment_method="";
  String payment_method_title="";
  String set_paid="false";
  double total=0;
  List<LineItem> lineItems = List.empty(growable: true);
  List<meta_data> listmetaMap = List.empty(growable: true);
  late Billing billing;
  late Shipping shipping;
  List<ShippingLine> shipping_lines = [];

  C({
    required this.payment_method,
    required this.payment_method_title,
    required this.set_paid,
    required this.total,
    required this.lineItems,
    required this.listmetaMap,
    required this.billing,
    required this.shipping,
    required this.shipping_lines,
  });

  C.fromJson(Map<String, dynamic> json) {
    payment_method = json['payment_method'];
    payment_method_title = json['payment_method_title'];
    set_paid = json['set_paid'];
    total = json['total'];
    lineItems = json['line_items'];
    listmetaMap = json['meta_data'];
    // billing = Billing.fromJson(json['billing']);
    // shipping = Shipping.fromJson(json['shipping']);
    shipping_lines = json['shipping_lines'].map((line) => ShippingLine.fromJson(line)).toList();
  }
  Map<String, dynamic> toJson() {
    return {
      'payment_method': payment_method,
      'payment_method_title': payment_method_title,
      'set_paid': set_paid,
      'total': total,
      'line_items': lineItems,
      'meta_data': listmetaMap,
      'billing': billing.toJson(),
      'shipping': shipping.toJson(),
      'shipping_lines': shipping_lines.map((line) => line.toJson()).toList(),
    };
  }
}