import 'dart:convert';

import 'package:GiorgiaShop/pojo/config.dart';
import 'package:http/http.dart' as http;
abstract class API_Config {
  Future<Config> getConfig();
  late Config config;
}

class API_Config_Implementation extends API_Config {


  Future<Config> getConfig() async {
    // TODO: implement getProductByCategory
    var response = await http.get(Uri.parse('http://www.jerma.net/Engi/api/config.php'),
        headers: {"Content-Type": "Application/json"});
//List<dynamic> list = jsonDecode(jsonString);
      config = Config.fromJson(jsonDecode(response.body));
      return config;
  }
}