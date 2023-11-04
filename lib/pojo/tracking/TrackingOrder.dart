import 'dart:ffi';

class TrackingOrder {
  int id;
  String listStatus;
  String orderDate;
  String total;
  List<Item> itemList=List.empty(growable: true);

  TrackingOrder({
    required this.id,
    required this.listStatus,
    required this.orderDate,
    required this.total,
    required this.itemList,
  });

  factory TrackingOrder.fromJson(Map<String, dynamic> json) {
    return TrackingOrder(
      id: json['id'] ,
      listStatus: json['status'] as String,
      orderDate: json['date_created']! as String,
      total: json['total'] ,
      itemList: (json['line_items'] as Iterable<dynamic>).map((item) => Item.fromJson(item)).toList(growable: true),
    );
  }
}

class Item {
  String image;
  String name;
  int qty;
  num  price;

  Item({
    required this.image,
    required this.name,
    required this.qty,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      image: json['image']['src'] as String,
      name: json['name'] as String,
      qty: json['quantity'],
      price: json['price'],
    );
  }



}