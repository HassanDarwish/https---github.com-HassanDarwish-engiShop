import 'package:GiorgiaShop/pojo/order/shipping.dart' as Shipping;
import 'package:GiorgiaShop/pojo/order/billing.dart' as Billing;
class customers{

  late final String id;
  late final String date_created;
  late final String date_created_gmt;
  late final String date_modified;
  late String date_modified_gmt;
  late final String email;
  late final String first_name;
  late final String last_name;
  late final String username;
  late Shipping.shipping shipping;
  late Billing.billing billing;
  late String role;
  late final String is_paying_customer;
  late final String avatar_url;

  customers({
    id,date_created,date_created_gmt,date_modified,date_modified_gmt,email,first_name,
    last_name,username,shipping,billing,role,is_paying_customer,avatar_url
  });
}