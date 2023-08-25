import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:GiorgiaShop/pojo/config.dart';
import 'package:http/http.dart' as http;
abstract class API_Config {
  Future<Config> getConfig();
  Future<bool> isInternet();
  late Config config;
}

class API_Config_Implementation extends API_Config {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;


  Future<bool> isInternet () async {
    bool internet=true;
    try {
      final result = await InternetAddress.lookup('www.jerma.net');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
       internet=true;
      }
    } on SocketException catch (_) {
      internet=false;
    }

    return internet;
  }


  Future<Config> getConfig() async {
    // TODO: implement getProductByCategory
    var response = await http.get(Uri.parse('http://www.jerma.net/Engi/api/config.php'),
        headers: {"Content-Type": "Application/json"});
//List<dynamic> list = jsonDecode(jsonString);
      config = Config.fromJson(jsonDecode(response.body));
      return config;
  }
}