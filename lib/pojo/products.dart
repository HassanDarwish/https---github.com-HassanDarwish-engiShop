

import 'dart:convert';

class products {
  List<product> productList;
  products({required this.productList});

  factory products.fromJson( String json) {
    List<product> product_List=List.empty(growable: true);
    List<dynamic> productList=jsonDecode(json);
    productList.forEach((item)
    {
      product temp_product=new product();
      temp_product.name=item["name"];
      temp_product.id=item["id"];
      temp_product.price=item["price"];
      temp_product.permalink=item["permalink"];
      temp_product.sale_price=item["sale_price"];
      temp_product.img=item["images"][0]['src'];
      temp_product.description=item["description"];
      temp_product.short_description=item["short_description"];
      product_List.add(temp_product);
    });
    products temp_products= products(productList: product_List);


    return temp_products;
  }
}

class product {
  late final int id;
  late final String name;
  late final String slug;
  late final String permalink;
  late final String price;
  late final String sale_price;
  late final String img;
  late final String description;
  late final String short_description;

  product({id,name,slug,permalink,price,sale_price,img,description,short_description});

  factory product.fromJson(Map<dynamic, dynamic> json) {
    return product(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      permalink: json['permalink'],
    );
  }
}