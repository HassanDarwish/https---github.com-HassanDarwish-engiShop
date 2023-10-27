


class Favorit{

  late final String id;
  late final String image_url;
  late final String post_content;
  late final String post_title;
  late String post_excerpt;
  late String post_type;
  List<Favorit> favorit_List=List.empty(growable: true);


  Favorit({required id,required image_url,required post_content,required post_title,required post_excerpt,required post_type}) {

    this.id = id.toString();
    this.image_url = image_url.toString();
    this.post_content = post_content.toString();
    this.post_title = post_title.toString();
    this.post_excerpt = post_excerpt.toString();
    this.post_type = post_type.toString();
  }
  factory Favorit.short(List<Favorit> favorit_List ){
    Favorit fav=new Favorit(id:"",image_url:"",post_content:"",post_title:"",post_excerpt:""
        ,post_type:"");
    fav.favorit_List=favorit_List;
    return fav;
  }
  factory Favorit.fromJson(List<dynamic> json) {
    List<Favorit> favorit_List=List.empty(growable: true);
    json.forEach((item) {
      Favorit favorit =new  Favorit(id: item["ID"],
        image_url: item["image_url"],
        post_content: item["post_content"],
        post_title: item["post_title"],
        post_excerpt: item["post_excerpt"]  ,
        post_type: item["post_type"]  ,);
      favorit_List.add(favorit);
    });

    Favorit temp_Favorit=  Favorit.short(favorit_List);

    return temp_Favorit;
  }
}