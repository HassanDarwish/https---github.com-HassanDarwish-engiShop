import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:GiorgiaShop/pojo/config.dart';
import 'package:http/io_client.dart';
import 'package:flutter/services.dart';
 import 'package:http/http.dart' as http;
abstract class API_Config {
  Future<Config> getConfig();
  Future<bool> isInternet();
  late Config config;
}

class API_Config_Implementation extends API_Config {


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
    int maxRetries = 10;
    int currentRetry = 0;

    final certificateAsset = await rootBundle.load('assets/certificate.pem');
    final certificateContent = utf8.decode(
        certificateAsset.buffer.asUint8List());

    // Convert certificate content to bytes
    List<int> certificateBytes = utf8.encode(certificateContent);
    // Create a SecurityContext and add the certificate to it
    SecurityContext securityContext = SecurityContext.defaultContext;
    securityContext.setTrustedCertificatesBytes(certificateBytes);

    while (currentRetry < maxRetries) {
      try {
        var response = await http.get(
          Uri.parse('https://www.jerma.net/Engi/api/config.php'),
          // Use 'https' instead of 'http'
          headers: {"Content-Type": "application/json"},
        ).timeout(Duration(seconds: 4));
        // Make HTTP request
        if (response.statusCode == 200) {
          // If the server returns a 200 OK response, parse the JSON and return the config
          config = Config.fromJson(jsonDecode(response.body));
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
