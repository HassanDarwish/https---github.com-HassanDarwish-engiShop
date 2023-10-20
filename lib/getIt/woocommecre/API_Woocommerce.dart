import 'dart:math';

import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:flutter_wp_woocommerce/models/customer.dart';


import 'package:get_it/get_it.dart';

import 'package:flutter_wp_woocommerce/models/order.dart' as order;
import 'package:flutter_wp_woocommerce/models/order_payload.dart';
import '../../pojo/products.dart';
import '../config/APIConfig.dart';

GetIt getIt = GetIt.instance;

abstract class API_Woocommerce {
  Future getCategories();
  Future getCategoriesByCount(int count);
  Future searchCustomerByEmail(String email);
  Future<bool> createWooCustomer(String email,String username,address, city, state, phoneArea, country);
  Future<WooCustomer> updateWooCustomer(String id,Map data);
  Future<bool>  createOrder(String userID,String displayName,Map addressList
  ,String cartFinalPrice,String CUR_CART_COUNTT,Map itemMap,List<product> products,String promocode) ;
  
  late Future<List<WooProductCategory>> listCategories;
  late Future<List<WooProductCategory>> listAllCategories;
  late Future<List<WooCustomer>> listWooCustomer;
   

  //http://engy.jerma.net/wp-json/wc/v3/customers?username=HassanAli&email=hassanaly@msn.com&password&first_name=Hassan&last_name=Ali
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
  Future<WooCustomer> updateWooCustomer(String userID,Map mapData) async{
    String consumerKey = getIt<API_Config>().config.consumerKey;
    String consumerSecret = getIt<API_Config>().config.consumerSecret;

    WooCommerce woocommerce = WooCommerce(
        baseUrl: baseUrl,
        consumerKey: consumerKey,
        consumerSecret: consumerSecret);
  //  WooCustomer customer=WooCustomer();

    // var order = await woocommerce.createOrder(userID, mapData);
    //   productId,
    //   quantity,
    //   attributeValues: attributeValues,
    // );
    WooCustomer result=await woocommerce.updateCustomer(id: int.parse(userID),data:mapData);
  return result;
  }
  Future<bool> createWooCustomer(String email,String username,address, city, state, phoneArea, country) async{



 String consumerKey = getIt<API_Config>().config.consumerKey;
    String consumerSecret = getIt<API_Config>().config.consumerSecret;
    WooCommerce woocommerce = WooCommerce(
        baseUrl: baseUrl,
        consumerKey: consumerKey,
        consumerSecret: consumerSecret);
    WooCustomer customer=WooCustomer();
    customer.email=email;
    customer.firstName=username;
    customer.username=username;
    customer.password=randomString();
    customer.billing=Billing(phone: phoneArea,country: country,state: state,address1: address,firstName: username,
    lastName: "",city: city,postcode: "",company: "",email: email,address2: "");


    try {
      await woocommerce.createCustomer(customer);
    }catch(e){
      return false;
    }
  return true;
  }
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
  String randomString(){
    Random rand = Random();
    List<int> codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    /// Random string uniquely generated to identify each signed request
    String nonce = String.fromCharCodes(codeUnits);
    return nonce;
  }

  @override
  Future<bool> createOrder(String userID,String displayName,Map addressList
      ,String cartFinalPrice,String CUR_CART_COUNTT,Map itemMap,List<product> products,String promocode) async {
try {
  String consumerKey = getIt<API_Config>().config.consumerKey;
  String consumerSecret = getIt<API_Config>().config.consumerSecret;
  WooCommerce woocommerce = WooCommerce(
      baseUrl: baseUrl,
      consumerKey: consumerKey,
      consumerSecret: consumerSecret);

  // quantity , attribute
  // if SelectedAttribute > 0 then get _identify_value to be Map key to get quantity
  // else get id as Map key to get value as quantity

  // if SelectedAttribute >0 then attribute name from attributes in index order 0=>0  1=>1  SelectedAttribute[0]=attributes[0]
  // SelectedAttribute contain value of attribute selection
  List<WooOrderPayloadMetaData> listMetaData=List<WooOrderPayloadMetaData>.empty(growable: true);
  List<LineItems>  line_Item=List<LineItems>.empty(growable: true);

  int counter=0;
  for (var product in products) {
    LineItems item=LineItems();


      item.name=product.name;
      item.productId=int.parse(product.id);
      if(product.SelectedAttribute.length>0) {
        item.quantity = itemMap[product.identify_value.toString()];
        for (var attr in product.attributes) {
          WooOrderPayloadMetaData itemdMetaData=WooOrderPayloadMetaData();
          itemdMetaData.key=attr.name;
          itemdMetaData.value=product.SelectedAttribute[attr.name];
          listMetaData.add(itemdMetaData);
        }


      }else{
        item.quantity = itemMap[product.id];
      }

    line_Item.add(item);
  }
  //String userID,String displayName,Map addressList
  WooOrderPayloadShipping  shippingInfo=WooOrderPayloadShipping();
  shippingInfo.firstName=displayName;
  for (String key in addressList.keys) {
    if(key=="address")
      shippingInfo.address1=addressList["address"];
    if(key=="city")
      shippingInfo.city=addressList["city"];
    if(key=="state")
      shippingInfo.state=addressList["state"];
    if(key=="mobile")
      shippingInfo.address2=addressList["mobile"];
    if(key=="country")
      shippingInfo.country=addressList["country"];
  }
  WooOrder order = await woocommerce.createOrder(WooOrderPayload(
      shipping: shippingInfo,
      metaData: listMetaData,
      lineItems: line_Item
  ));
  if (order != null) {
    return true;
  } else {
    return false;
    // The order failed to be created.
  }
}catch(e)
    {
      print(e);
      print("Ali Hassan");
    }
return false;
    // WooOrder order2=WooOrder(id:4);
    // List<LineItems>? lineItems;
    // LineItems Line_Items=LineItems();
    //
    // lineItems?.add(Line_Items);
    //
    // order2.lineItems=lineItems;


  }

}

/////