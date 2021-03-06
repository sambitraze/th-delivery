import 'dart:convert';

import 'package:Th_delivery/model/deliveryBoy.dart';
import 'package:http/http.dart' as http;

import '../model/deliveryBoy.dart';

class DeliveryBoyService {
  static Future getDeliveryBoyByEmail(email) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/deliveryBoy/email"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      DeliveryBoy deliveryBoy = DeliveryBoy.fromJson(responseMap[0]);
      return deliveryBoy;
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }

  static Future<bool> updateDeliveryBoy(payload) async {
    http.Response response = await http.put(
      Uri.parse("https://tandoorhut.co/deliveryBoy/update"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.body);
      return false;
    }
  }
}
