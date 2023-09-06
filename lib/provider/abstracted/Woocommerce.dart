


import 'package:flutter/cupertino.dart';

import '../../pojo/products.dart';

abstract class Woocommerce extends ChangeNotifier{

  Future  getCategories();
  Future getCategoriesByCount(int count);
  Future<products> getProductByCategory(String catId) ;
  Future<products> getProductBy_Category(String catId,String order,String per_page);



}