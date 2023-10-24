import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';

class HappyShopOrderDetails extends StatefulWidget {
  const HappyShopOrderDetails({Key? key}) : super(key: key);

  @override
  _HappyShopOrderDetailsState createState() => _HappyShopOrderDetailsState();
}

class _HappyShopOrderDetailsState extends State<HappyShopOrderDetails>
    with TickerProviderStateMixin {
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

  int index = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(ORDER_DETAIL, context),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("$ORDER_ID_LBL : 0121345"),
                        const Text("$ORDER_DATE : 01-2-2021"),
                        const Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          "https://smartkit.wrteam.in/smartkit/images/Nikereak4.jpg",
                                      height: 100.0,
                                      width: 100.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Mac"),
                                            const Text("$PAYMENT_METHOD_LBL : PayPal"),
                                            const Text("$QUANTITY_LBL : 5"),
                                            Text("$CUR_CURRENCY 100"),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                ButtonTheme(
                                  child: ButtonBar(
                                    children: <Widget>[
                                      TextButton(
                                        child: const Text(ITEM_CANCEL),
                                        onPressed: () {},
                                      ),
                                      TextButton(
                                        child: const Text(ITEM_RETURN),
                                        onPressed: () {},
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(PRICE_DETAIL,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: primary)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(PRICE_LBL),
                              Text("+ $CUR_CURRENCY 1200")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(DELIVERY_CHARGE),
                              Text("+ $CUR_CURRENCY 190")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("$TAXPER (18%)"),
                              Text("+ $CUR_CURRENCY 2500")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(PROMO_CODE_DIS_LBL),
                              Text("- $CUR_CURRENCY 10")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(WALLET_BAL),
                              Text("- $CUR_CURRENCY 10")
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                TOTAL_PRICE,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$CUR_CURRENCY 1586",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(OTHER_DETAIL,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: primary)),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("$NAME_LBL : Mac"),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("$MOB_LBL : 0123456789"),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("$ADDRESS_LBL : xyz,xyz"),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ORDER_STATUS,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: primary),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              getPlaced("2-2-2020"),
                              getProcessed("3-2-2020", "4-2-2020"),
                              getShipped("4-2-2020", ""),
                              getDelivered("5-2-2021", ""),
                              getCanceled("5-2-2021"),
                              getReturned("6-2-2021"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
            color: primary,
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
                      color: prDate == null ? Colors.grey : primary,
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
                        color: prDate == null ? Colors.grey : primary,
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
                  children: [
                    const Flexible(
                        flex: 1,
                        child: Divider(
                          thickness: 2,
                          color: primary,
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
                          color: primary,
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
                      color: sDate == null ? Colors.grey : primary,
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
                        color: sDate == null ? Colors.grey : primary,
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
                          color: primary,
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
                  color: dDate == null ? Colors.grey : primary,
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
                        color: dDate == null ? Colors.grey : primary,
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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Icon(
                        Icons.radio_button_checked,
                        color: Colors.red,
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

  getReturned(
    String rDate,
  ) {
    return Flexible(
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Icon(
                  Icons.radio_button_checked,
                  color: Colors.red,
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
    );
  }

  productItem(var orderItem, var model) {
    String pDate, prDate, sDate, dDate, cDate, rDate;

    if (orderItem.listStatus.contains(PLACED)) {
      pDate = orderItem.listDate[orderItem.listStatus.indexOf(PLACED)];

      List d = pDate.split(" ");
      pDate = d[0] + "\n" + d[1] + d[2];
    }
    if (orderItem.listStatus.contains(PROCESSED)) {
      prDate = orderItem.listDate[orderItem.listStatus.indexOf(PROCESSED)];
      List d = prDate.split(" ");
      prDate = d[0] + "\n" + d[1] + d[2];
    }
    if (orderItem.listStatus.contains(SHIPED)) {
      sDate = orderItem.listDate[orderItem.listStatus.indexOf(SHIPED)];
      List d = sDate.split(" ");
      sDate = d[0] + "\n" + d[1] + d[2];
    }
    if (orderItem.listStatus.contains(DELIVERD)) {
      dDate = orderItem.listDate[orderItem.listStatus.indexOf(DELIVERD)];
      List d = dDate.split(" ");
      dDate = d[0] + "\n" + d[1] + d[2];
    }
    if (orderItem.listStatus.contains(CANCLED)) {
      cDate = orderItem.listDate[orderItem.listStatus.indexOf(CANCLED)];
      List d = cDate.split(" ");
      cDate = d[0] + "\n" + d[1] + d[2];
    }
    if (orderItem.listStatus.contains(RETURNED)) {
      rDate = orderItem.listDate[orderItem.listStatus.indexOf(RETURNED)];
      List d = rDate.split(" ");
      rDate = d[0] + "\n" + d[1] + "\n" + d[2];
    }
    return Column(
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: orderItem.image,
              height: 100.0,
              width: 100.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(orderItem.name),
                    Text("$PAYMENT_METHOD_LBL : " + model.payMethod),
                    Text("$QUANTITY_LBL : " + orderItem.qty),
                    Text("$CUR_CURRENCY " + orderItem.price),
                  ],
                ),
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
        ),
        model.itemList.length > 1
            ? ButtonTheme(
                child: ButtonBar(
                  children: <Widget>[
                    (!orderItem.listStatus.contains(DELIVERD) &&
                            (!orderItem.listStatus.contains(RETURNED)) &&
                            orderItem.isCancle == "1" &&
                            orderItem.isAlrCancelled == "0")
                        ? TextButton(
                            child: const Text(ITEM_CANCEL),
                            onPressed: () {},
                          )
                        : (orderItem.listStatus.contains(DELIVERD) &&
                                orderItem.isReturn == "1" &&
                                orderItem.isAlrReturned == "0")
                            ? TextButton(
                                child: const Text(ITEM_RETURN),
                                onPressed: () {},
                              )
                            : Container(),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
