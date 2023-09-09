import 'dart:convert';

import 'package:GiorgiaShop/pojo/order/metaData.dart' ;

class coupons{

  late final String id;
  late final String date_created;
  late final String date_created_gmt;
  late final String date_modified;
  late String date_modified_gmt;
  late final String discount_type= "percent";
  late final String description;
  late final String date_expires;
  late final String date_expires_gmt;
  late String usage_count;
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
  late metaData meta_data;

  coupons({
    id,date_created,date_created_gmt,date_modified,date_modified_gmt,discount_type,description,
    date_expires,date_expires_gmt,usage_count,individual_use,product_ids,excluded_product_ids,usage_limit,
    usage_limit_per_user,limit_usage_to_x_items,free_shipping,product_categories,excluded_product_categories,
    exclude_sale_items,minimum_amount,maximum_amount,email_restrictions,used_by,meta_data
  });

  factory coupons.fromJson(List<dynamic> json) {
    coupons c= coupons(id:json[0]);

    print (c.id+"***************************************************************************");
    return c;
  }

}