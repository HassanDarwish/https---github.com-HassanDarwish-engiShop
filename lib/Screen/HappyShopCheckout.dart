import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:provider/provider.dart';
import 'package:GiorgiaShop/getIt/woocommecre/APICustomWooCommerce.dart';
import 'package:GiorgiaShop/pojo/products.dart';
import 'HappyShopHome.dart';
import 'package:GiorgiaShop/provider/Cart.dart';
import 'package:GiorgiaShop/getIt/config/APIConfig.dart';
import 'package:get_it/get_it.dart';
import 'package:GiorgiaShop/Helper/cartEnums.dart';
import 'package:GiorgiaShop/Helper/cartEnums.dart';
GetIt getIt = GetIt.instance;

class HappyShopCheckout extends StatefulWidget {
  static const routeName = '/HappyShopCheckout';
  HappyShopCheckout({Key? key}) : super(key: key);
  late final cartProvider;

  @override
  _HappyShopCheckoutState createState() => _HappyShopCheckoutState();
}

class _HappyShopCheckoutState extends State<HappyShopCheckout>
    with TickerProviderStateMixin {
  int _curIndex = 0;
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Widget> fragments;
  late Animation buttonSqueezeanimation;
  late AnimationController buttonController;

  @override
  void initState() {
    super.initState();
    widget.cartProvider = Provider.of<CartImplementation>(context, listen: false);

    fragments = [  Delivery(),   Address(), const Payment()];
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = Tween(
      begin: deviceWidth * 0.7,
      end: 50.0,
    ).animate(CurvedAnimation(
      parent: buttonController,
      curve: const Interval(
        0.0,
        0.150,
      ),
    ));
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }

  getAppBar(String title, BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: primary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: primary,
        ),
      ),
      //brightness: Brightness.light,
      backgroundColor: Colors.white,
      elevation: 5,
    );
  }

  stepper() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          InkWell(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _curIndex == 0 ? primary : Colors.grey,
                  ),
                  width: 20,
                  height: 20,
                  child: const Center(
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text("  $DELIVERY  ",
                    style: TextStyle(color: _curIndex == 0 ? primary : null)),
              ],
            ),
            onTap: () {
              setState(() {
                _curIndex = 0;
              });
            },
          ),
          const Expanded(child: Divider()),
          InkWell(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _curIndex == 1 ? primary : Colors.grey,
                  ),
                  width: 20,
                  height: 20,
                  child: const Center(
                    child: Text(
                      "2",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text("  $ADDRESS_LBL  ",
                    style: TextStyle(color: _curIndex == 1 ? primary : null)),
              ],
            ),
            onTap: () {
              setState(() {
                _curIndex = 1;
              });
            },
          ),
          const Expanded(child: Divider()),
          InkWell(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _curIndex == 2 ? primary : Colors.grey,
                  ),
                  width: 20,
                  height: 20,
                  child: const Center(
                    child: Text(
                      "3",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text("  $PAYMENT  ",
                    style: TextStyle(color: _curIndex == 2 ? primary : null)),
              ],
            ),
            onTap: () {
              if (_curIndex == 0) {
                setState(() {
                  _curIndex = 1;
                });
              } else {
                setState(() {
                  _curIndex = 2;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: getAppBar(CHECKOUT, context),
      body: Column(
        children: [
          stepper(),
          const Divider(),
          Expanded(child: fragments[_curIndex]),
        ],
      ),
      persistentFooterButtons: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  "$TOTAL : $CUR_CURRENCY 6100",
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_curIndex == 0) {
                  setState(() {
                    _curIndex = _curIndex + 1;
                  });
                } else if (_curIndex == 1) {
                  setState(() {
                    _curIndex = _curIndex + 1;
                  });
                } else if (_curIndex == 2) {
                  Navigator.of(context)
                      .pushNamed(HappyShopHome.routeName);
                /*  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const HappyShopHome()));*/
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  ), backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.all(0.0)),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: happyshopgradient,
                ),
                child: Container(
                  height: 40.0,
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  alignment: Alignment.center,
                  child: Text(
                    _curIndex == 2 ? PROCEED : CONTINUE,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class Delivery extends StatefulWidget {
  late final cartProvider;

    Delivery({super.key});

  get provider => null;

  @override
  State<StatefulWidget> createState() {
    return StateDelivery();
  }
}

class StateDelivery extends State<Delivery> with TickerProviderStateMixin {
  late Animation buttonSqueezeanimation;
  late AnimationController buttonController;
  final TextEditingController _textFieldController = TextEditingController();
  TextEditingController get textFieldController => _textFieldController;

  bool _isLoading = false;

  Future<void> asyncApply(CartImplementation cart) async {
    setState(() {
      _isLoading = true;
    });

    // Read from the textField
    String text = _textFieldController.text;


    cart.applyCoupon(text);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Consumer<CartImplementation>(builder:(context ,cart,child) {
          return _deliveryContent(cart);
        })
      ],
    ));
  }

  @override
  void initState() {
    super.initState();
    widget.cartProvider=Provider.of<CartImplementation>(context, listen: false);
  /*  _textFieldController.addListener(() {
      final String text = _textFieldController.text.toLowerCase();
      _textFieldController.value = _textFieldController.value.copyWith(
        text: text,
        selection:
        TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });*/
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = Tween(
      begin: deviceWidth * 0.7,
      end: 50.0,
    ).animate(CurvedAnimation(
      parent: buttonController,
      curve: const Interval(
        0.0,
        0.150,
      ),
    ));
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }
  cartEmpty() {
    return Center(
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Empty Cart "),
        ]),
      ),
    );
  }
  _deliveryContent(CartImplementation cart) {
    return cart.products.isEmpty ? cartEmpty()
      : SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        PROMOCODE_LBL,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      child: const Icon(Icons.refresh),
                      onTap: () {},
                    )
                  ],
                ),
                Consumer<CartImplementation>(builder:(context ,cart,child) {
               return Visibility(
                  visible: cartEnums.couponAdded != cart.status,
                  child: Row(
                    children: [
                        Expanded(
                        child: TextField(
                          controller: _textFieldController,
                          decoration: InputDecoration(
                            enabled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.all(
                              10,
                            ),
                            hintText: 'Promo Code..',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primary),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            print("Apply Clicked");
                            asyncApply(cart);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0.0),
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(0.0)),
                            ),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: happyshopgradient,
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 98.0,
                                  minHeight:
                                  36.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'Apply',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ) ,


                      ),if (_isLoading)
               CircularProgressIndicator(),
                    ],
                  ),
                );
  })],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, top: 10),
                  child: Text(
                    ORDER_SUMMARY,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                ScreenTypeLayout(
                  mobile: Column(
                    children: [
                      Column(
                        children: [
                          const Row(
                            children: [
                              Expanded(flex: 5, child: Text(PRODUCTNAME)),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    QUANTITY_LBL,
                                    textAlign: TextAlign.end,
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    PRICE_LBL,
                                    textAlign: TextAlign.end,
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    SUBTOTAL,
                                    textAlign: TextAlign.end,
                                  )),
                            ],
                          ),
                          const Divider(),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.cartProvider.products.length,
                              physics:   NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return orderItem(index);
                              }),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 28, bottom: 8.0, left: 0, right: 0),
                            child: Row(
                              children: <Widget>[
                                const Text(
                                  SUB,
                                ),
                                const Spacer(),
                                Text("${ECUR_CURRENCY} " +widget.cartProvider.cartTotalPrice )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 8, bottom: 8),
                            child: Row(
                              children: <Widget>[
                                const Text(
                                  DELIVERY_CHARGE,
                                ),
                                const Spacer(),
                                Text("${ECUR_CURRENCY} "+getIt<API_Config>().config.deliveryFees)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 8, bottom: 8),
                            child: Row(
                              children: <Widget>[
                                for (var tax in  getIt<API_Config>().config.tax)
                                  Text(
                                    "$TAXPER(${tax.toString()} %) ",
                                  ),
                                const Spacer(),
                                Text("$ECUR_CURRENCY "+ widget.cartProvider.totalTax)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 8, bottom: 8),
                            child: Row(
                              children: <Widget>[
                                const Text(
                                  "$PROMO_LBL (promocode)",
                                ),
                                const Spacer(),
                                Text("$ECUR_CURRENCY "+ cart.discountValue),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, left: 0, right: 0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  TOTAL_PRICE,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  '${ECUR_CURRENCY} '+ widget.cartProvider.cartFinalPrice,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  orderItem(int index) {

    List<int> itemMapValues =[];
    widget.cartProvider.itemMap.forEach((k, v) => itemMapValues.add(v));
    List<int> itemTotalPriceMapValues = [];
    widget.cartProvider.itemTotalPriceMap.forEach((k, v) => itemTotalPriceMapValues.add(v));
    return   Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: Text(
                widget.cartProvider.products.elementAt(index).name,
              )),
          Expanded(
              flex: 1,
              child: Text(
                itemMapValues.elementAt(index).toString(),
                textAlign: TextAlign.end,
              )),
          Expanded(
              flex: 2,
              child: Text(
                widget.cartProvider.products.elementAt(index).price.toString(),
                textAlign: TextAlign.end,
              )),
          Expanded(
              flex: 2,
              child: Text(
                  itemTotalPriceMapValues.elementAt(index).toString(),
                textAlign: TextAlign.end,
              )),
        ],
      ),
    );
  }

  bool get isLoading => _isLoading;
}

class Address extends StatefulWidget {
  late final provider;
    Address({super.key});

  @override
  State<StatefulWidget> createState() {
    return StateAddress();
  }
}

int selectedAddress = 0;

class StateAddress extends State<Address> with TickerProviderStateMixin {
  late Animation buttonSqueezeanimation;
  late AnimationController buttonController;

  @override
  void initState() {
    super.initState();
    addressList.clear();
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    // Initialize the provider
    widget.provider = Provider.of<CartImplementation>(context, listen: false);

    buttonSqueezeanimation = Tween(
      begin: deviceWidth * 0.7,
      end: 50.0,
    ).animate(CurvedAnimation(
      parent: buttonController,
      curve: const Interval(
        0.0,
        0.150,
      ),
    ));
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }

  List addressList = [
    {
      "address": "lorem ipsum",
      "area": "Bhuj",
      "city": "Bhuj",
      "state": "Gujrat",
      "country": "India",
      "mobile": "0123456789"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: addressList.isEmpty
              ? const Text(NOADDRESS)
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    print(
                        "default***b${addressList[index].isDefault}***${addressList[index].name}");

                    return addressItem(index);
                  }),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () async {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: happyshopgradient,
              ),
              child: Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),

                // min sizes for Material buttons
                alignment: Alignment.center,
                child: const Text(
                  ADDADDRESS,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  addressItem(int index) {
    return RadioListTile(
      value: (index),
      groupValue: selectedAddress,
      onChanged: (val) {},
      title: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              Text(
                addressList[index].name + "  ",
                style: const TextStyle(color: Colors.black),
              ),
              Container(
                decoration: BoxDecoration(
                    color: lightgrey, borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.all(3),
                child: Text(
                  addressList[index].type,
                ),
              )
            ],
          )),
          InkWell(
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.edit,
                color: Colors.black54,
                size: 17,
              ),
            ),
            onTap: () async {},
          ),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.delete,
                color: Colors.black54,
                size: 17,
              ),
            ),
          )
        ],
      ),
      isThreeLine: true,
      subtitle: Text(addressList[index]['address'] +
          ", " +
          addressList[index]['area'] +
          ", " +
          addressList[index]['city'] +
          ", " +
          addressList[index]['state'] +
          ", " +
          addressList[index]['country'] +
          "\n" +
          addressList[index]['mobile']),
    );
  }
}

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<StatefulWidget> createState() {
    return StatePayment();
  }
}

class StatePayment extends State<Payment> with TickerProviderStateMixin {
  late String allowDay, startingDate;
  late bool cod, paypal, razorpay, paumoney, paystack, flutterwave;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> paymentMethodList = [
    COD_LBL,
    PAYPAL_LBL,
    PAYUMONEY_LBL,
    RAZORPAY_LBL,
    PAYSTACK_LBL,
    FLUTTERWAVE_LBL
  ];
  late Animation buttonSqueezeanimation;
  late AnimationController buttonController;

  @override
  void initState() {
    super.initState();
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = Tween(
      begin: deviceWidth * 0.7,
      end: 50.0,
    ).animate(CurvedAnimation(
      parent: buttonController,
      curve: const Interval(
        0.0,
        0.150,
      ),
    ));
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }

  var _isUseWallet = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: ScreenTypeLayout(
            mobile: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CheckboxListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    value: _isUseWallet,
                    onChanged: (bool? value) {
                      setState(() {
                        _isUseWallet = value!;
                      });
                    },
                    title: const Text(
                      USE_WALLET,
                      style: TextStyle(fontSize: 15, color: primary),
                    ),
                    subtitle: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "250.0",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ),
                )),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          PREFERED_TIME,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Container(
                        height: 80,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return dateCell(index);
                            }),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          PAYMENT_METHOD_LBL,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return paymentItem(index);
                          }),
                    ],
                  ),
                )
              ],
            ),
            desktop: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CheckboxListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    value: _isUseWallet,
                    onChanged: (bool? value) {
                      setState(() {
                        _isUseWallet = value!;
                      });
                    },
                    title: const Text(
                      USE_WALLET,
                      style: TextStyle(fontSize: 15, color: primary),
                    ),
                    subtitle: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "250.0",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ),
                )),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 4,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                PREFERED_TIME,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Container(
                              height: 80,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return dateCell(index);
                                  }),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 4,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                PAYMENT_METHOD_LBL,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return paymentItem(index);
                                }),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  var isselect = false;
  var selsectindex = 0;
  dateCell(int index) {
    var date = DateTime.now();
    DateTime today = (date);
    return InkWell(
      child: Container(
        decoration: isselect == false
            ? BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(10),
                color: selsectindex != index ? Colors.white : primary)
            : BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(10),
                color: selsectindex != index ? Colors.white : primary),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEE').format(today.add(Duration(days: index))),
              style: const TextStyle(color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                DateFormat('dd').format(today.add(Duration(days: index))),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selsectindex == index ? Colors.white : primary),
              ),
            ),
            Text(
              DateFormat('MMM').format(today.add(Duration(days: index))),
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          selsectindex = index;
          print('SELSECTINDEX: $selsectindex');
          isselect != true ? isselect = true : isselect = false;
        });
      },
    );
  }

  setSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 1.0,
    ));
  }

  Widget timeSlotItem(int index) {
    var selectedTime;
    return RadioListTile(
      dense: true,
      value: (index),
      groupValue: selectedTime,
      onChanged: (val) {},
      title: const Text(
        "",
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
    );
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  int selectedRadioTile = 0;
  Widget paymentItem(int index) {
    return RadioListTile(
      value: index,
      groupValue: selectedRadioTile,
      title: Text(
        paymentMethodList[index],
      ),
      // subtitle: Text("Radio 2 Subtitle"),
      onChanged: (index) {
        setState(() {
          selectedRadioTile = index as int;
        });

        print("Radio Tile pressed $index");
        // setSelectedRadioTile(index);
      },
      // activeColor: Colors.red,
      // selected: true,
    );
    // RadioListTile(
    //   // dense: fa,
    //   activeColor: Colors.red,
    //   value: index,
    //   groupValue: selectedMethod,
    //   onChanged: (index) {
    //     print('INDEX: ${index}');

    //     selectedMethod = index;
    //   },

    //   title: Text(
    //     paymentMethodList[index],
    //     style: TextStyle(color: Colors.black, fontSize: 15),
    //   ),
    // );
  }
}
