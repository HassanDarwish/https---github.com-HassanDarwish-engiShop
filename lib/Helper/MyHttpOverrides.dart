import

'dart:io';

class MyHttpOverrides  extends HttpOverrides

{
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final httpClient = super.createHttpClient(context);

    // Allow self-signed certificates
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port)=> true; // Accept the certificate
    return httpClient;
  }
}