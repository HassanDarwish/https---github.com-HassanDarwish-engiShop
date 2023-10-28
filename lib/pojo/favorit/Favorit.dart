


import 'dart:convert';

import '../products.dart';

class Favorit{

  late final String id;
  late final String image_url;
  late final String post_content;
  late final String post_title;
  late String post_excerpt;
  late String post_type;
  late String has_attributes;
  late String price;
  List<Favorit> favorit_List=List.empty(growable: true);
  late List <dynamic> attributes= List.empty();


  Favorit({required id,required image_url,required post_content,required post_title,required post_excerpt,required post_type,required has_attributes,required price,required List<dynamic> attributes}) {

    try{
    this.id = id.toString();
    this.image_url = image_url.toString();
    this.post_content = post_content.toString();
    this.post_title = post_title.toString();
    this.post_excerpt = post_excerpt.toString();
    this.post_type = post_type.toString();
    this.has_attributes=has_attributes.toString();
    this.price=price;
    print(attributes);
    print("Ali");

    this.attributes=attributes;
  } catch (e) {
  throw e;
   }
  }
  factory Favorit.short(List<Favorit> favorit_List ){
    Favorit fav=new Favorit(id:"",image_url:"",post_content:"",post_title:"",post_excerpt:""
        ,post_type:"",has_attributes:"false",price: "",attributes:[]);
    fav.favorit_List=favorit_List;
    return fav;
  }
  factory Favorit.fromJson(String json) {
    List<Favorit> favorit_List = List.empty(growable: true);
    try {

      Map<String, dynamic> productList = jsonDecode(json);
      List<dynamic> pro_list = productList["products"];
      pro_list.forEach((item) {
        Favorit favorit = new Favorit(id: item["ID"],
            image_url: item["image_url"],
            post_content: item["post_content"],
            post_title: item["post_title"],
            post_excerpt: item["post_excerpt"],
            post_type: item["post_type"],
            has_attributes: item["has_attributes"],
            price: item["price"],
            attributes: item["has_attributes"]==false ? [] : item["product_attributes"]);
        favorit_List.add(favorit);
      });

    }catch(e){
      throw e;
    }
      Favorit temp_Favorit = Favorit.short(favorit_List);

    return temp_Favorit;
  }
}