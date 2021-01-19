import 'dart:convert';

import 'package:Th_delivery/model/deliveryBoy.dart';
import 'package:Th_delivery/model/order.dart';
import 'package:Th_delivery/model/uiconstants.dart';
import 'package:Th_delivery/services/DeliveryBoyService.dart';
import 'package:Th_delivery/services/orderservice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order order;
  OrderDetailsScreen({this.order});
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Order order;
  int selectedRadio;
  bool isVisible = true;
  final scaffkey = new GlobalKey<ScaffoldState>();
  // User user;

  //Fields
  String status = '';

  @override
  void initState() {
    super.initState();
    order = widget.order;
    isVisible = getStatus();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  getStatus() {
    if (order.status == 'Shipped' || order.status == 'Out for Delivery')
      return true;
    else
      return false;
  }

  callAction(String number) async {
    String url = 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $number';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffkey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Color(0xff25354E), //change your color here
        ),
      ),
      body: Container(
        height: UIConstants.fitToHeight(640, context),
        width: UIConstants.fitToWidth(360, context),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Details',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(height: UIConstants.fitToHeight(25, context)),
                Text('Order Id: ${order.orderId}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: UIConstants.fitToHeight(1.5, context)),

                Text(
                  'Received on ${DateTime.parse(order.createdAt.toString()).toLocal()}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: UIConstants.fitToHeight(20, context)),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    //height: UIConstants.fitToHeight(150, context), //remove this
                    width: UIConstants.fitToWidth(340, context),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 14.0),
                          child: Text('ITEMS',
                              style: TextStyle(
                                  color: Color(0xff25354E),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Sl No.',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text('Item Name',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text('Quantity',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text('Price',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: order.items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('${index + 1}.',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    Text('${order.items[index].item.name}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    Text('x${order.items[index].count}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    Text('₹${order.items[index].item.price}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(height: UIConstants.fitToHeight(15, context))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: UIConstants.fitToHeight(40, context)),
                Text('Delivery Details',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                deliveryDetails('Name', '${order.customer.name}', false),
                deliveryDetails('Phone', '${order.customer.phone}', true),
                // deliveryDetails('Email', '${order}', false),k
                deliveryDetails('Address', '${order.customer.address}', false),
                SizedBox(
                  height: UIConstants.fitToHeight(25, context),
                ),
                (order.status == "placed")
                    ? ListTile(
                        title: Text(
                          'Start Delivery',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        trailing: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.transparent)),
                          onPressed: () async {
                            setState(() {
                              order.status = "out for delivery";
                            });
                            await OrderService.updateOrder(
                                jsonEncode(order.toJson()));
                          },
                          child: Text('Start',
                              style: TextStyle(color: Colors.black)),
                        ),
                      )
                    : Container(),
                (order.status == "out for delivery")
                    ? ListTile(
                        title: Text(
                          'Payment Status',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        trailing: order.paid
                            ? RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side:
                                        BorderSide(color: Colors.transparent)),
                                onPressed: () {},
                                child: Text('Paid',
                                    style: TextStyle(color: Colors.black)),
                              )
                            : RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side:
                                        BorderSide(color: Colors.transparent)),
                                onPressed: () async {
                                  setState(() {
                                    order.status = "completed";
                                    order.paid = true;
                                  });
                                  await OrderService.updateOrder(
                                      jsonEncode(order.toJson()));
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  var email = pref.getString("email");
                                  DeliveryBoy deliveryBoy =
                                      await DeliveryBoyService
                                          .getDeliveryBoyByEmail(email);
                                  setState(() {
                                    deliveryBoy.assigned =
                                        (int.parse(deliveryBoy.assigned) - 1)
                                            .toString();
                                    deliveryBoy.completed =
                                        (int.parse(deliveryBoy.completed) + 1)
                                            .toString();
                                  });
                                  await DeliveryBoyService.updateDeliveryBoy(
                                      jsonEncode(deliveryBoy.toJson()));                                },
                                child: Text('unpaid',
                                    style: TextStyle(color: Colors.black)),
                              ),
                      )
                    : Container(),
                SizedBox(height: UIConstants.fitToHeight(25, context)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: order.status == 'out for delivery'
          ? FloatingActionButton(
              backgroundColor: Color(0xff141518),
              onPressed: () async {
                //org/des
                await launch(
                    "https://www.google.com/maps/dir/'20.311521,85.825042'/20.3115278,85.8250556/");
              },
              child: Icon(Icons.directions),
            )
          : null,
    );
  }

  Widget deliveryDetails(String title, String subtitle, bool call) {
    return ListTile(
      leading: Text('$title: ',
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
      title: Text('$subtitle',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500)),
      trailing: call
          ? IconButton(
              icon: Icon(
                Icons.call,
                color: Colors.green,
              ),
              onPressed: () {
                callAction('$subtitle');
              })
          : Text(''),
    );
  }
}
