import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:GiorgiaShop/Helper/SSLLoder.dart';
import 'package:GiorgiaShop/pojo/config.dart';
import 'package:http/io_client.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

abstract class API_Config {
  Future<Config> getConfig();
  Future<bool> isInternet();
  late Config config;
}

class API_Config_Implementation extends API_Config  {


  Future<bool> isInternet() async {
    bool internet = true;
    try {
      final result = await InternetAddress.lookup('www.jerma.net');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internet = true;
      }
    } on SocketException catch (_) {
      internet = false;
    }

    return internet;
  }


  Future<Config> getConfig() async {
    // TODO: implement getProductByCategory
    // Read the certificate content from the file
    int maxRetries = 20;
    int currentRetry = 0;
/*
  var request = Uri.parse('https://www.jerma.net/Engi/api/config.php');
  var headers = {'Content-Type': 'application/json'};
  var body = '{"message": "Hello from Flutter!"}';

  var response = await client.post(request, headers: headers, body: body);
 */
    HttpClient client = HttpClient()..badCertificateCallback = (X509Certificate cert, String host, int port) => true;

    while (currentRetry < maxRetries) {
      try {
        var request = await client.getUrl(
          Uri.parse('https://www.jerma.net/Engi/api/config.php')
        ).timeout(Duration(seconds: 12));
        // Set headers for the request
        request.headers.set('Content-Type', 'application/json');
        //request.headers.set('Authorization', 'Bearer YourAccessToken');
        HttpClientResponse response = await request.close();
         if (response.statusCode == 200) {
          // If the server returns a 200 OK response, parse the JSON and return the config
           String responseBody = await response.transform(utf8.decoder).join();
          config = Config.fromJson(jsonDecode(responseBody));
          break;
        }
 // Break the loop if the request is successful
      } catch (error) {
        // Handle error
        currentRetry++;
      }
    }
    // Make the HTTP request with the custom security context
        return config;
  } //while

  }
