import 'package:GiorgiaShop/pojo/order/billing.dart' as Billing;
import 'package:GiorgiaShop/pojo/order/shipping.dart' as Shipping;

class customers {
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

  customers(
      {id,
      date_created,
      date_created_gmt,
      date_modified,
      date_modified_gmt,
      email,
      first_name,
      last_name,
      username,
      shipping,
      billing,
      role,
      is_paying_customer,
      avatar_url});
  customers.short(
      {required this.id,
      required this.email,
      required this.username,
      required this.billing});

  factory customers.fromJson(List<dynamic> json) {
    Map<String, dynamic> json_Map = json[0];
    Map<String, dynamic> x = json_Map["billing"];
    customers customer = customers.short(
        id: json_Map["id"].toString(),
        email: json_Map["email"],
        username: json_Map["username"],
        billing: Billing.billing.short(
            first_name: json_Map["billing"]['first_name'],
            address_1: json_Map["billing"]['address_1']));

    return customer;
  }
}
