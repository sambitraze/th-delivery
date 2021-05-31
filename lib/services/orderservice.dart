import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/order.dart';

class OrderService {

  static Future updateOrder(payload) async {
    http.Response response = await http.put(
      Uri.parse("https://tandoorhut.co/order/update"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      print(responsedata);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  static Future getAllOrdersById(id) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/order/delivery"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": id})
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      List<Order> orderList = responsedata.map<Order>((itemMap) => Order.fromJson(itemMap)).toList();
      return orderList;
    } else {
      print(response.body);
      return false;
    }
  }
}