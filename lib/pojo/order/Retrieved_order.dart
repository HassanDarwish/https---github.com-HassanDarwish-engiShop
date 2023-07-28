


import 'package:GiorgiaShop/pojo/order/shipping.dart' as Shipping;
import 'package:GiorgiaShop/pojo/order/shipping_lines.dart' as shippinglines;
import 'package:GiorgiaShop/pojo/order/tax_lines.dart' as taxlines;

import 'billing.dart' as Billing;
import 'lineItems.dart';
import 'link_s.dart';
import 'metaData.dart';

class Retrieved_order{

  late  int id;
  late  int parent_id;
  late String number;
  late String order_key;
  late String created_via;
  late String version;
  late String status;

  late String  currency;  late String date_created;
  late String date_created_gmt;
  late String date_modified;

  late String  date_modified_gmt;
  late String discount_total;
  late String discount_tax;
  late String shipping_total;

  late String  shipping_tax;
  late String cart_tax;
  late String total;
  late String total_tax;

  late bool  prices_include_tax;
  late int customer_id;
  late String customer_ip_address;
  late String customer_user_agent;

  late String  customer_note;
  late Billing.billing billing;
  late Shipping.shipping shipping;
  late String payment_method;

  late String payment_method_title;
  late String transaction_id;
  late String date_paid;
  late String date_paid_gmt;
  late String date_completed;


  late String date_completed_gmt;
  late String cart_hash;
  late List<metaData> meta_data;

  late List<lineItems> line_items;
  late List<taxlines.tax_lines> tax_lines;

  late List<shippinglines.shipping_lines> shipping_lines;
  late List<String> fee_lines;

  late List<String> coupon_lines;
  late List<String> refunds;

 // late link_s _links;

  Retrieved_order({
    id,
    parent_id,
    number,
    order_key,
    created_via,
    version,
    status,
     currency,
    date_created,
    date_created_gmt,
    date_modified,
     date_modified_gmt,
    discount_total,
    discount_tax,
    shipping_total,
     shipping_tax,
    cart_tax,
    total,
    total_tax,

     prices_include_tax,
     customer_id,
    customer_ip_address,
    customer_user_agent,

     customer_note,
     billing,
    shipping,
    payment_method,

    payment_method_title,
    transaction_id,
    date_paid,
    date_paid_gmt,
    date_completed,


    date_completed_gmt,
    cart_hash,
     meta_data,

    line_items,
     tax_lines,

     shipping_lines,
     fee_lines,

     coupon_lines,
     refunds,
    //  link_s links,


  });



}





