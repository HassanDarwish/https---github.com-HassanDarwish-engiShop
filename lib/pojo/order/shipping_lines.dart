


import 'package:GiorgiaShop/pojo/order/metaData.dart';

class shipping_lines{

  late  int id;

  late String method_title;
  late String  method_id;
  late String total;
  late String total_tax;
  late List<String> taxes;
  late List<metaData> meta_data;


  shipping_lines({id,method_title,method_id,total,total_tax,taxes,meta_data});
}