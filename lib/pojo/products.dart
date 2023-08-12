

import 'dart:convert';

class products {
  List<product> productList;
  products({required this.productList});

  factory products.fromJson( String json) {
    List<product> product_List=List.empty(growable: true);
    List<dynamic> productList=jsonDecode(json);
    productList.forEach((item)
    {
      product temp_product=new product(id:item["id"],name: item["name"],img: item["images"][0]['src']
        ,description: item["description"],price:item["price"],sale_price: item["sale_price"],
      permalink:item["permalink"],short_description:item["short_description"],
      slug: "",tag: "",rating: "");

      temp_product.name=item["name"];
      temp_product.rating="";
      /*temp_product.id=item["id"];
      temp_product.price=item["price"];
      temp_product.permalink=item["permalink"];
      temp_product.sale_price=item["sale_price"];
      temp_product.img=item["images"][0]['src'];
      temp_product.description=item["description"];
      temp_product.short_description=item["short_description"];
      temp_product.tag=item["tag"];*/
      product_List.add(temp_product);
    });
    products temp_products= products(productList: product_List);


    return temp_products;
  }
}

class product {
  late final String _id;
  late final String _name;

  late final String _slug;
  late final String _permalink;
  late final String _price;
  late final String _sale_price;
  late final String _img;
  late final String _description;
  late final String _short_description;
  late final String _tag;
  late   String _rating="";
  late   String _review="";
  late   String _user_rating="";

  String get user_rating => _user_rating;

  set user_rating(String value) {
    _user_rating = value;
  }

  String get review => _review;

  set review(String value) {
    _review = value;
  }

  String get rating => _rating;

  set rating(String value) {
    _rating = value;
  }

  product( {id,name,slug,permalink,price,sale_price,img,description,short_description,tag,rating}) {
    //this.name = name;

    this.id = id.toString();

    this.slug = slug;

    this.permalink = permalink;

    this.price = price;

    this.sale_price = sale_price;
    this.img = img;
    this.description = description;
    this.short_description = short_description;
    this.tag = tag;


  }

  factory product.fromJson(Map<dynamic, dynamic> json) {
    return product(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      permalink: json['permalink'],
    );
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get tag => _tag;

  set tag(String value) {
    _tag = value;
  }

  String get short_description => _short_description;

  set short_description(String value) {
    _short_description = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get img => _img;

  set img(String value) {
    _img = value;
  }

  String get sale_price => _sale_price;

  set sale_price(String value) {
    _sale_price = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get permalink => _permalink;

  set permalink(String value) {
    _permalink = value;
  }

  String get slug => _slug;

  set slug(String value) {
    _slug = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}