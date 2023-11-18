import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:GiorgiaShop/provider/Session.dart';
import 'package:GiorgiaShop/provider/woocommerceProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'Helper/HappyShopColor.dart';
import 'Helper/HappyShopString.dart';
import 'Helper/MyHttpOverrides.dart';
import 'Screen/HappyShopCart.dart';
import 'Screen/HappyShopCatgories.dart';
import 'Screen/HappyShopCheckout.dart';
import 'Screen/HappyShopHome.dart';
import 'Screen/HappyShopSplash.dart';
import 'getIt/config/APIConfig.dart';
import 'getIt/woocommecre/APICustomWooCommerce.dart';
import 'getIt/woocommecre/API_Woocommerce.dart';
import 'provider/Cart.dart';
GetIt getIt = GetIt.instance;


loadRepository()async{
  getIt.registerSingleton<API_Config>(API_Config_Implementation(),
      signalsReady: true);
  getIt.isReady<API_Config>().then((_) => getIt<API_Config>());

     getIt.registerSingleton<API_Woocommerce>(API_Woocommerce_Implementation(),
        signalsReady: true);
    getIt.isReady<API_Woocommerce>().then((_) => getIt<API_Woocommerce>());

    getIt.registerSingleton<APICustomWooCommerce>(
        APICustomWooCommerce_Implementation(),
        signalsReady: true);
    getIt.isReady<APICustomWooCommerce>().then((_) =>
        getIt<APICustomWooCommerce>());

}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await loadRepository();
  runApp(

      MultiProvider(
        providers: [
          ChangeNotifierProvider<CartImplementation>(
            create: (context) => CartImplementation(config: getIt<API_Config>()),
          ),
          ChangeNotifierProvider<SessionImplementation>(
            create: (context) => SessionImplementation(),
          ),
          ChangeNotifierProvider<WoocommerceProvider>(
            create: (context) =>
                WoocommerceProvider(api_Woocommerce: getIt<API_Woocommerce>(),
                    api_CustomWoocommerce: getIt<APICustomWooCommerce>()),
          ),
        ],
      child: MaterialApp(
          home: HappyShopSplash(),
          title: App_title,
          theme: ThemeData(
            primarySwatch: primary_app,
            textTheme: const TextTheme(
                titleLarge: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.w600,
                )),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: primary,
            ),
            fontFamily: 'Open sans',
          ),
          routes: {
            HappyShopHome.routeName: (context) =>   HappyShopHome(),
            HappyShopCatogeryAll.routeName:(context) =>   HappyShopCatogeryAll(),
            HappyShopCart.routeName:(context) =>  HappyShopCart(),
            HappyShopCheckout.routeName:(context) =>  HappyShopCheckout(),

          },

        ),
      ));

}

class MyApp extends StatelessWidget {

    MyApp({
    Key? key,
  }) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Confirm that you have user permission for screen recording


    return    MaterialApp(
        home: HappyShopSplash()      ,
      title: App_title,
      theme: ThemeData(
        primarySwatch: primary_app,
        textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: primary,
              fontWeight: FontWeight.w600,
            )),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primary,
        ),
        fontFamily: 'Open sans',
      ),
      routes: {
        HappyShopHome.routeName: (context) =>   HappyShopHome(),
        HappyShopCatogeryAll.routeName:(context) => const HappyShopCatogeryAll(),
        HappyShopCart.routeName:(context) =>  HappyShopCart(),
        HappyShopCheckout.routeName:(context) =>  HappyShopCheckout(),

      },
    ) ;


  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future _getProducts() async {
    WooCommerce woocommerce = WooCommerce(
        baseUrl: "http://engy.jerma.net",
        consumerKey: "ck_314081f754984f4ec9a55e8ca4c2171bd071ea56",
        consumerSecret: "cs_8ae1b05d30d722960f3d65136dd82ee0433417cf");
    Future<List<WooProductCategory>> x = woocommerce.getProductCategories();

    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // Create a list of products
            List<WooProductCategory> WooProductCategorydata = snapshot.data;

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                WooProductCategory category = WooProductCategorydata[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Image.network(category.image!.src!),
                  ),
                  title: Text(category.name!),
                  subtitle: Text("Buy now for \$ " + category.name!),
                );
              },
            );
          }

          // Show a circular progress indicator while loading products
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
