import 'package:cached_network_image/cached_network_image.dart';
import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:GiorgiaShop/pojo/tracking/TrackingOrder.dart';
import 'package:GiorgiaShop/provider/Session.dart';
import 'package:GiorgiaShop/provider/woocommerceProvider.dart';
import 'package:GiorgiaShop/Helper/cartEnums.dart';

import '../Helper/SmartKitColor.dart';
import 'HappyShopHome.dart';
class HappyShopTreackOrder extends StatefulWidget {
  final bool? appbar;
    HappyShopTreackOrder({Key? key, this.appbar}) : super(key: key);
  late WoocommerceProvider CustWoocommerceProvider;
  late SessionImplementation sessionImp;
  @override
  _HappyShopTreackOrderState createState() => _HappyShopTreackOrderState();
}

int offset = 0;
int total = 0;
bool isLoadingmore = true;

class _HappyShopTreackOrderState extends State<HappyShopTreackOrder>
    with TickerProviderStateMixin {
  List tempList = [];

  late var orderList = List<TrackingOrder>.empty();
ScrollController controller = ScrollController();
  late Animation buttonSqueezeanimation;
  late AnimationController buttonController;

  @override
  initState()   {
    offset = 0;
    total = 0;

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
    widget.CustWoocommerceProvider =
        Provider.of<WoocommerceProvider>(context, listen: false);
    widget.sessionImp = Provider.of<SessionImplementation>(context,listen: false);
    if(widget.sessionImp.status==sessionEnums.login)
    loadTrackingOrders();

    super.initState();
  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  Future<void> _refresh() async {
    // Replace this delay with the code to be executed during refresh.
    // and return a Future when code finishes execution.
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    // Reload the data.
    setState(() {});
  }
  @override
  void dispose() {
    buttonController.dispose();
    controller.dispose();
    super.dispose();
  }

  // List orderList = [
  //   {
  //     'id': "0123456",
  //     'listStatus': "returned",
  //     'orderDate': "5-2-2021",
  //     'total': "150",
  //     'itemList': [
  //       {
  //         'image': "https://smartkit.wrteam.in/smartkit/images/Nikereak4.jpg",
  //         'name': "test",
  //         'qty': "2",
  //         'price': "75"
  //       }
  //     ]
  //   },
  // ];
loadTrackingOrders() async {

  orderList= await widget.CustWoocommerceProvider.getOrderByUserId(widget.sessionImp.userID);
  setState(() {});
  }
  void showMessageDialog(BuildContext context, String message) {
    if (message != null) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Info'),
              content: Text(message!),
              actions: [
                TextButton(
                  onPressed: () {

                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    widget.CustWoocommerceProvider =
        Provider.of<WoocommerceProvider>(context, listen: false);
    widget.sessionImp = Provider.of<SessionImplementation>(context,listen: false);
    if(widget.sessionImp.status==sessionEnums.login) {
      loadTrackingOrders();
    }
     // showMessageDialog(context,"Please Login to your Order List");
   // if(widget.sessionImp.status!=sessionEnums.login)
   // showMessageDialog(context, "Please Login");

    return  WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(

        appBar: widget.appbar == true
            ? AppBar(
          title: const Text(
            "Track order",
            style: TextStyle(color: Colors.white),
          ),
        )
            : PreferredSize(
            preferredSize: const Size.fromHeight(0), child: AppBar()),
        body:
        RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: widget.sessionImp.status!=sessionEnums.login
            ? SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                height: 1500,
                child: Column(
                  children:[ Padding(
                    padding: const EdgeInsets.only(top: kToolbarHeight),
                    child: Center(child: Text(goToLogin,style: TextStyle(fontSize: 18),)),
                  )],
                ),
              ),
            )
            :  FutureBuilder(
           future: context
          .read<WoocommerceProvider>()
          .getOrderByUserId(widget.sessionImp.userID),
          builder:
    (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
          // Create a list of products
          List<TrackingOrder> orderList = snapshot.data;

          return ListView.builder(
            shrinkWrap: true,
            controller: controller,
            itemCount: snapshot.data.length - 1,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("$ORDER_ID_LBL : " +
                                    orderList[index].id.toString()),
                                Text("$ORDER_DATE : " +
                                    orderList[index].orderDate),
                                Text("$TOTAL_PRICE:$ECUR_CURRENCY " +
                                    orderList[index].total),
                                Text(orderList[index].listStatus,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.red[700])),
                              ],
                            ),
                          ),
                          // IconButton(
                          //     icon: const Icon(
                          //       Icons.keyboard_arrow_right,
                          //       color: primary,
                          //     ),
                          //     onPressed: () async {
                          //       await Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 const HappyShopOrderDetails()),
                          //       );
                          //     })
                        ],
                      ),
                      const Divider(),
                      GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        shrinkWrap: true,
                        itemCount: orderList[index].itemList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return productItem(i, orderList[index].itemList);
                        },
                      ),
                      //const Divider(),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //           //getPlaced("2-2-2020"),
                      //         //getProcessed("3-2-2020", "4-2-2020"),
                      //        // getShipped("4-2-2020", "4-2-2020"),
                      //        // getDelivered("5-2-2021", "4-2-2020"),
                      //       // getCanceled("5-2-2021"),
                      //       // getReturned("6-2-2021", index),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              );
            },
          );
      } else if (snapshot.hasError) {
          return Text(
              "Server Can not be reached  please check connection or Login Please"); //Text(snapshot.error.toString());
      } else {
          // Show a circular progress indicator while loading products
          return Center(
            child: CircularProgressIndicator(),
          );
      }

    }
    ),
        )),
      ),
    ) ;

  }
  cartEmpty() {
    return Center(
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          noCartImage(context),
          noCartText(context),
          noCartDec(context),
          shopNow()
        ]),
      ),
    );
  }
  noCartImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'http://jerma.net/Engi/icons/login-icon-305.png',
      fit: BoxFit.contain,
    );
  }

  noCartText(BuildContext context) {
    return Container(
        child: Text(NO_LOGIN,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: primary, fontWeight: FontWeight.normal)));
  }

  noCartDec(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
      child: Text(Login_DESC,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: lightblack,
            fontWeight: FontWeight.normal,
          )),
    );
  }
  shopNow() {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: CupertinoButton(
        child: Container(
            width: deviceWidth * 0.7,
            height: 45,
            alignment: FractionalOffset.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryLight2, primaryLight3],
                  stops: [0, 1]),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            child: Text(LOGIN_LBL,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: white, fontWeight: FontWeight.normal))),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>   HappyShopHome()),
              ModalRoute.withName('/'));
        },
      ),
    );
  }
  getDelivered(String dDate, String cDate) {
    return cDate == null
        ? Flexible(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Divider(
                  thickness: 2,
                  color: dDate == null ? Colors.grey : happyshopcolor8,
                )),
                Column(
                  children: [
                    const Text(
                      ORDER_DELIVERED,
                      style: TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Icon(
                        dDate == null
                            ? Icons.radio_button_unchecked
                            : Icons.radio_button_checked,
                        color: dDate == null ? Colors.grey : happyshopcolor8,
                      ),
                    ),
                    Text(
                      dDate,
                      style: const TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container();
  }

  getCanceled(String cDate) {
    return cDate != null
        ? Flexible(
            flex: 1,
            child: Row(
              children: [
                const Flexible(
                    flex: 1,
                    child: Divider(
                      thickness: 2,
                      color: Colors.red,
                    )),
                Column(
                  children: [
                    const Text(
                      ORDER_CANCLED,
                      style: TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Icon(
                        Icons.radio_button_checked,
                        color: Colors.red[700],
                      ),
                    ),
                    Text(
                      cDate,
                      style: const TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container();
  }

  getReturned(String rDate, int index) {
    return orderList[index].listStatus.contains(RETURNED)
        ? Flexible(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Flexible(
                    flex: 1,
                    child: Divider(
                      thickness: 2,
                      color: Colors.red,
                    )),
                Column(
                  children: [
                    const Text(
                      ORDER_RETURNED,
                      style: TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Icon(
                        Icons.radio_button_checked,
                        color: Colors.red[700],
                      ),
                    ),
                    Text(
                      rDate,
                      style: const TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container();
  }

  getShipped(String sDate, String cDate) {
    return cDate == null
        ? Flexible(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    flex: 1,
                    child: Divider(
                      thickness: 2,
                      color: sDate == null ? Colors.grey : happyshopcolor8,
                    )),
                Column(
                  children: [
                    const Text(
                      ORDER_SHIPPED,
                      style: TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Icon(
                        sDate == null
                            ? Icons.radio_button_unchecked
                            : Icons.radio_button_checked,
                        color: sDate == null ? Colors.grey : happyshopcolor8,
                      ),
                    ),
                    Text(
                      sDate,
                      style: const TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          )
        : sDate == null
            ? Container()
            : Flexible(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Flexible(
                        flex: 1,
                        child: Divider(
                          thickness: 2,
                        )),
                    Column(
                      children: [
                        const Text(
                          ORDER_SHIPPED,
                          style: TextStyle(fontSize: 8),
                          textAlign: TextAlign.center,
                        ),
                        const Icon(
                          Icons.radio_button_checked,
                          color: happyshopcolor8,
                        ),
                        Text(
                          sDate,
                          style: const TextStyle(fontSize: 8),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              );
  }

  getProcessed(String prDate, String cDate) {
    return cDate == null
        ? Flexible(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    flex: 1,
                    child: Divider(
                      thickness: 2,
                      color: prDate == null ? Colors.grey : happyshopcolor8,
                    )),
                Column(
                  children: [
                    const Text(
                      ORDER_PROCESSED,
                      style: TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Icon(
                        prDate == null
                            ? Icons.radio_button_unchecked
                            : Icons.radio_button_checked,
                        color: prDate == null ? Colors.grey : happyshopcolor8,
                      ),
                    ),
                    Text(
                      prDate,
                      style: const TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          )
        : prDate == null
            ? Container()
            : Flexible(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Flexible(
                        flex: 1,
                        child: Divider(
                          thickness: 2,
                          color: happyshopcolor8,
                        )),
                    Column(
                      children: [
                        const Text(
                          ORDER_PROCESSED,
                          style: TextStyle(fontSize: 8),
                          textAlign: TextAlign.center,
                        ),
                        const Icon(
                          Icons.radio_button_checked,
                          color: happyshopcolor8,
                        ),
                        Text(
                          prDate,
                          style: const TextStyle(fontSize: 8),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              );
  }

  getPlaced(String pDate) {
    return Column(
      children: [
        const Text(
          ORDER_NPLACED,
          style: TextStyle(fontSize: 8),
          textAlign: TextAlign.center,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Icon(
            Icons.radio_button_checked,
            color: happyshopcolor8,
          ),
        ),
        Text(
          pDate,
          style: const TextStyle(fontSize: 8),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  productItem(int index, List<Item> orderItem) {
    return GestureDetector(
      child:
      ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Center(
          child: Column(
            children: [
              Container(
                child: CachedNetworkImage(
                  imageUrl: orderItem[index].image,
                  width: 140.0,
                  height: 140.0,
                   fit: BoxFit.contain,
                ),
              ),
              Text(orderItem[index].name),
               Text("$QUANTITY_LBL: " + orderItem[index].qty.toString()),
              Text("$ECUR_CURRENCY " + orderItem[index].price.toString()),
            ],
          ),
        ),
      ),


    );
  }
  // productItem(int index, orderItem) {
  //
  //
  //   return Row(
  //     children: [
  //       CachedNetworkImage(
  //         imageUrl: orderItem[index].image.toString(),
  //         height: 100.0,
  //         width: 100.0,
  //       ),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(orderItem[index].name),
  //             Text("$QUANTITY_LBL: " + orderItem[index].qty.toString()),
  //             Text("$ECUR_CURRENCY " + orderItem[index].price.toString()),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }
}
