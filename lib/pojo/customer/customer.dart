import 'package:GiorgiaShop/pojo/order/shipping.dart' as Shipping;
import 'package:GiorgiaShop/pojo/order/billing.dart' as Billing;

class customer{

  late final String email;
  late final String first_name;
  late final String last_name;
  late final String username;
  late Shipping.shipping shipping;
  late Billing.billing billing;


  customer({email,first_name,last_name,username,shipping,billing});
}