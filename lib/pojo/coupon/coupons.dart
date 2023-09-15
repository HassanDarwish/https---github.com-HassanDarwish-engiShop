import 'dart:convert';

import 'package:GiorgiaShop/pojo/order/metaData.dart' ;

class coupons{

  late final int id;
  late final String code;
  late final String amount;
  late final String status;
  late final String date_created;
  late final String date_created_gmt;
  late final String date_modified;
  late String date_modified_gmt;
  late final String discount_type;
  late final String description;
  late   String date_expires="";
  late final String date_expires_gmt;
  late int usage_count;
  late final bool individual_use;
  late final List product_ids;
  late final List excluded_product_ids;
  late final String usage_limit;
  late String usage_limit_per_user="1";
  late final String limit_usage_to_x_items;
  late final bool free_shipping;
  late final List product_categories;
  late final List excluded_product_categories;
  late bool exclude_sale_items;
  late final String minimum_amount;
  late final String maximum_amount;
  late final List email_restrictions;
  late final List used_by;
  late List meta_data;


  coupons({
       required this.id,  required this.code, required this.amount, required this.status, required this.date_created,  required this.date_created_gmt,
    required this.date_modified, required this.date_modified_gmt, required this.discount_type, required this.description,
    required this.date_expires, required this.date_expires_gmt, required this.usage_count, required this.individual_use, required this.product_ids,
    required this.excluded_product_ids, required this.usage_limit,
    required this.usage_limit_per_user, required this.limit_usage_to_x_items, required this.free_shipping,
    required this.product_categories, required this.excluded_product_categories,
    exclude_sale_items,minimum_amount, required this.maximum_amount, required this.email_restrictions,
    required this.used_by, required this.meta_data,
  });

  factory coupons.fromJson(List<dynamic> json) {

    Map<String,dynamic> json_Map=json[0];

    coupons coupon= coupons(id:json_Map["id"],code:json_Map["code"],amount:json_Map["amount"],status:json_Map["status"],
    date_created: json_Map["date_created"] ?? "",date_created_gmt:json_Map["date_created_gmt"] ?? "",date_modified:json_Map["date_modified"] ?? "",
      date_modified_gmt: json_Map["date_modified_gmt"] ?? "",
    discount_type:json_Map["discount_type"],description:json_Map["description"],date_expires: json_Map["date_expires"] ?? "",
      date_expires_gmt: json_Map["date_expires_gmt"]   ?? "" ,usage_count: json_Map["usage_count"],
      individual_use:json_Map["individual_use"],product_ids: json_Map["product_ids"],excluded_product_ids:  json_Map["excluded_product_ids"],
      usage_limit: json_Map["usage_limit"] ?? "",usage_limit_per_user: json_Map["usage_limit_per_user"] ?? "",
      limit_usage_to_x_items:json_Map["limit_usage_to_x_items"] ?? "",free_shipping: json_Map["free_shipping"],product_categories: json_Map["product_categories"],
      excluded_product_categories: json_Map["excluded_product_categories"],
      exclude_sale_items: json_Map["exclude_sale_items"],minimum_amount: json_Map["minimum_amount"],maximum_amount: json_Map["maximum_amount"],
      email_restrictions: json_Map["email_restrictions"],
      used_by: json_Map["used_by"],meta_data: json_Map["meta_data"],);


    return coupon;
  }

}