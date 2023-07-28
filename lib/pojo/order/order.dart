

import 'package:GiorgiaShop/pojo/order/productQ.dart';
import 'package:GiorgiaShop/pojo/order/shipping.dart' as Shipping;
import 'package:GiorgiaShop/pojo/order/billing.dart' as Billing_bill;
import 'package:GiorgiaShop/pojo/order/shipping_address.dart';


class order {

  late  String payment_method;
  late  String payment_method_title;
  late bool set_paid;
  late Billing_bill.billing  billing;
  late Shipping.shipping shipping;
  late List<productQ> line_items;
  late List<shipping_address> shipping_lines;



  order({payment_method,payment_method_title,set_paid,billing,shipping,line_items,shipping_lines});

}
