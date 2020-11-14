import 'package:Th_delivery/model/order.dart';
import 'package:Th_delivery/model/uiconstants.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class OrderCard extends StatelessWidget {
  final Order order;
  bool isVisible = false;
  OrderCard({this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (BuildContext context) {
        //   return OrderDetailsScreen(order: order);
        // }));
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: UIConstants.fitToHeight(10, context),
            left: UIConstants.fitToWidth(15, context),
            right: UIConstants.fitToWidth(15, context)),
        child: Container(
            width: UIConstants.fitToWidth(330, context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Order ID: \n${order.orderId}',
                          style: TextStyle(
                              color: Color(0xff25354E),
                              letterSpacing: 0.14,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('${order.status}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff25354E),
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(height: UIConstants.fitToHeight(20, context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text('RECEIVED ON',
                                style: TextStyle(
                                    color: Color(0xff8BA4A8),
                                    letterSpacing: 0.14,
                                    fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, bottom: 10.0),
                            child: Text(
                              '${order.createdAt.day}-${order.createdAt.month}-${order.createdAt.year}',
                              style: TextStyle(color: Color(0xff25354E)),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text('${order.paymentType}',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Color(0xff25354E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0, bottom: 10.0),
                                child: Text(
                                    '₹ ${order.amount}',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Color(0xff25354E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}