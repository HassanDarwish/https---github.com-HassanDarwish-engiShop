
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class SSLLoader{


    ConfigSSLLoader() async {
    final certificateAsset = await rootBundle.load('assets/certificate.pem');
    final certificateContent = utf8.decode(
        certificateAsset.buffer.asUint8List());

    // Convert certificate content to bytes
    List<int> certificateBytes = utf8.encode(certificateContent);
    // Create a SecurityContext and add the certificate to it
    SecurityContext securityContext = SecurityContext.defaultContext;
    securityContext.setTrustedCertificatesBytes(certificateBytes);
  }
    WooSSLLoader() async {
        final certificateAsset = await rootBundle.load('assets/WooCertificate.pem');
        final certificateContent = utf8.decode(
            certificateAsset.buffer.asUint8List());

        // Convert certificate content to bytes
        List<int> certificateBytes = utf8.encode(certificateContent);
        // Create a SecurityContext and add the certificate to it
        SecurityContext securityContext = SecurityContext.defaultContext;
        securityContext.setTrustedCertificatesBytes(certificateBytes);
    }
}