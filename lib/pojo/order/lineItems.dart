import 'dart:ffi';

import 'package:GiorgiaShop/pojo/order/metaData.dart' as metaDatas;
import 'package:GiorgiaShop/pojo/order/taxes.dart' as taxess;

import 'metaData.dart';

class lineItems{

  late  int id;
  late  String name;
  late int product_id;
  late int  variation_id;
  late int quantity;
  late String tax_class;
  late String subtotal;

  late  String subtotal_tax;
  late  String total;
  late String total_tax;
  late List<taxess.taxes>  taxes;
  late List<metaDatas.metaData> meta_data;

  late String sku;
  late int price;


  lineItems({id,name,product_id,variation_id,quantity,tax_class,subtotal,
    subtotal_tax,total,total_tax,taxes,meta_data,sku,price});
}

