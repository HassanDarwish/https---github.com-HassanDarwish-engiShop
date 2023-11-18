import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http_client/http_client.dart';
import 'package:http_client/console.dart';
import 'package:flutter/services.dart';

class SSLLoader{


  Future<void>  ConfigSSLLoader() async {
    HttpClient client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
/*
    final certificateAsset = await rootBundle.load('assets/WooCertificate.pem');
    final certificateBytes = certificateAsset.buffer.asUint8List();

    SecurityContext securityContext = SecurityContext.defaultContext;
    securityContext.setTrustedCertificatesBytes(certificateBytes);
    securityContext.useCertificateChainBytes(certificateBytes);


    List<String> alpnProtocols = ['h2', 'http/1.1'];
    securityContext.setAlpnProtocols(alpnProtocols, true);
*/
  }

  Future<void> WooSSLLoader() async {
    HttpClient client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
/*
    final certificateAsset = await rootBundle.load('assets/WooCertificate.pem');
    final certificateBytes = certificateAsset.buffer.asUint8List();

    SecurityContext securityContext = SecurityContext.defaultContext;
    securityContext.setTrustedCertificatesBytes(certificateBytes);
    securityContext.useCertificateChainBytes(certificateBytes);


    List<String> alpnProtocols = ['h2', 'http/1.1'];
    securityContext.setAlpnProtocols(alpnProtocols, true); */
  }

}