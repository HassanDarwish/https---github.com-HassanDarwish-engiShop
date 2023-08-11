import 'dart:collection';
import 'dart:math';
import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_it/get_it.dart';

import 'getIt/woocommecre/APICustomWooCommerce.dart';

class QueryString {
  /// Parses the given query string into a Map.
  static Map parse(String query) {
    var search = new RegExp('([^&=]+)=?([^&]*)');
    var result = new Map();

// Get rid off the beginning ? in query strings.
    if (query.startsWith('?')) query = query.substring(1);

// A custom decoder.
    decode(String s) => Uri.decodeComponent(s.replaceAll('+', ' '));

// Go through all the matches and build the result map.
    for (Match match in search.allMatches(query)) {
      result[decode(match.group(1)!)] = decode(match.group(2)!);
    }

    return result;
  } }

  String _getOAuthURL(String requestMethod, String queryUrl) {
    String consumerKey = "ck_314081f754984f4ec9a55e8ca4c2171bd071ea56";
    String consumerSecret = "cs_8ae1b05d30d722960f3d65136dd82ee0433417cf";

    String token = "";
    String url = queryUrl;
    bool containsQueryParams = url.contains("?");

    Random rand = Random();
    List<int> codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    /// Random string uniquely generated to identify each signed request
    String nonce = String.fromCharCodes(codeUnits);

    /// The timestamp allows the Service Provider to only keep nonce values for a limited time
    int timestamp = DateTime
        .now()
        .millisecondsSinceEpoch ~/ 1000;

    String parameters = "oauth_consumer_key=" +
        consumerKey +
        "&oauth_nonce=" +
        nonce +
        "&oauth_signature_method=HMAC-SHA1&oauth_timestamp=" +
        timestamp.toString() +
        "&oauth_token=" +
        token +
        "&oauth_version=1.0&";

    if (containsQueryParams == true) {
      parameters = parameters + url.split("?")[1];
    } else {
      parameters = parameters.substring(0, parameters.length - 1);
    }

    Map<dynamic, dynamic> params = QueryString.parse(parameters);
    Map<dynamic, dynamic> treeMap = new SplayTreeMap<dynamic, dynamic>();
    treeMap.addAll(params);

    String parameterString = "";

    for (var key in treeMap.keys) {
      parameterString = parameterString +
          Uri.encodeQueryComponent(key) +
          "=" +
          treeMap[key] +
          "&";
    }

    parameterString = parameterString.substring(0, parameterString.length - 1);

    String method = requestMethod;
    String baseString = method +
        "&" +
        Uri.encodeQueryComponent(
            containsQueryParams == true ? url.split("?")[0] : url) +
        "&" +
        Uri.encodeQueryComponent(parameterString);

    String signingKey = consumerSecret + "&" + token;
    crypto.Hmac hmacSha1 =
    crypto.Hmac(crypto.sha1, utf8.encode(signingKey)); // HMAC-SHA1

    /// The Signature is used by the server to verify the
    /// authenticity of the request and prevent unauthorized access.
    /// Here we use HMAC-SHA1 method.
    crypto.Digest signature = hmacSha1.convert(utf8.encode(baseString));

    String finalSignature = base64Encode(signature.bytes);

    String requestUrl = "";

    if (containsQueryParams == true) {
      requestUrl = url.split("?")[0] +
          "?" +
          parameterString +
          "&oauth_signature=" +
          Uri.encodeQueryComponent(finalSignature);
    } else {
      requestUrl = url +
          "?" +
          parameterString +
          "&oauth_signature=" +
          Uri.encodeQueryComponent(finalSignature);
    }

    return requestUrl;
  }
GetIt getIt = GetIt.instance;
Future<void> main() async {
  getIt.registerSingleton<APICustomWooCommerce>(APICustomWooCommerce_Implementation(),
      signalsReady: true);
  getIt.isReady<APICustomWooCommerce>().then((_) => getIt<APICustomWooCommerce>());

     /* var response = await http.get(Uri.parse(getIt<APICustomWooCommerce>().getOAuthURL(
        "GET", 'http://engy.jerma.net/wp-json/wc/v3/products?category=27')),
        headers: {"Content-Type": "Application/json"});
      */
  var response = await http.get(Uri.parse(getIt<APICustomWooCommerce>().getOAuthURL(
      "GET", 'http://engy.jerma.net/wp-json/wc/v3/products?per_page=100&page=1')),
      headers: {"Content-Type": "Application/json"});
    var i=0;
    // Check the status code of the response.
    if (response.statusCode == 200) {
      // The request was successful.
      print('Response body: ${response.body}');
    } else {
      // The request failed.
      print('Error: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  if (i == 0) {
    _getByBrand(response);

  }




  }

_getByBrand(http.Response response){
  final attributesToFilter = "Brand:Amanda";

  if (response.statusCode == 200) {
    final List<dynamic> products = json.decode(response.body);
    final List<dynamic> filteredProducts = [];

    for (final product in products) {
      final List<dynamic> attributes = product["attributes"];

      for (final attribute in attributes) {
        final String attributeName = attribute["name"];
        final List<dynamic> attributeOptions = attribute["options"];

        if ("$attributeName:${attributeOptions[0]}" == attributesToFilter) {
          filteredProducts.add(product);
          break; // No need to check other attributes for this product
        }
      }
    }
    print("*********************************************************");
    print(filteredProducts);
  } else {
    print("Error: ${response.statusCode}");
  }
}
