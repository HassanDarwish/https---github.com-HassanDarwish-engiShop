
import 'package:GiorgiaShop/pojo/order/metaData.dart';

class tax_lines{

  late  int id;
  late  String rate_code;
  late int rate_id;
  late String  label;
  late bool compound;
  late String tax_total;
  late String shipping_tax_total;
  late List<metaData> meta_data;


  tax_lines({id,rate_code,rate_id,label,compound,tax_total,shipping_tax_total,meta_data});
}