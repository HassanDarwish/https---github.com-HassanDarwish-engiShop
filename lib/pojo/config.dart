import 'package:GiorgiaShop/pojo/location/Area.dart' ;



class Config {
  int per_page=100;
  int page=1;
 late List<DeliveryArea?> deliveryAreas;
  late List<String> tax;
  late String deliveryFees;
  late String consumerKey;
  late String consumerSecret;

  Config({required this.deliveryAreas, required this.tax, required this.deliveryFees, required this.consumerKey,required this.consumerSecret});

  factory Config.fromJson(Map<String, dynamic> json) {
      List<DeliveryArea?> deliveryAreass= <DeliveryArea>[];
      List<String> tax=[];
      String deliveryFees;
      String consumerKey;
      String consumerSecret;
    if (json['deliveryAreas'] != null) {
      deliveryAreass = <DeliveryArea>[];
      json['deliveryAreas'].forEach((v) {
        deliveryAreass!.add(DeliveryArea.fromJson(v));
      });
    }
    if (json['tax'] != null) {
      tax = [];
      json['tax'].forEach((v) {
        tax!.add(v);
      });
    }
    deliveryFees = json['deliveryFees'];
    consumerKey = json['consumerKey'];
    consumerSecret = json['consumerSecret'];

    Config config= new Config(deliveryAreas:deliveryAreass, tax:tax,deliveryFees:deliveryFees,consumerKey:consumerKey,
        consumerSecret:consumerSecret);
  return config;
  }


}



