import 'dart:convert';
import 'package:Th_delivery/model/User.dart';
import 'package:Th_delivery/model/deliveryBoy.dart';
import 'package:Th_delivery/services/DeliveryBoyService.dart';
import 'package:Th_delivery/services/UserService.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushService {
  static Future<String> genTokenID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    await _fcm.subscribeToTopic("offers");
    String deviceToken = await _fcm.getToken();
    pref.setString("deviceToken", deviceToken);
    var email = pref.getString("email");
    DeliveryBoy user = await DeliveryBoyService.getDeliveryBoyByEmail(email);
    user.deviceToken = deviceToken;
    await DeliveryBoyService.updateDeliveryBoy(jsonEncode(user.toJson()));
    return deviceToken;
  }

  static Future<String> sendPushToUser(
      String title, String message, String id) async {
    final Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode(
      {"title": title, "message": message, "deviceToken": id},
    );
    http.Response response = await http.post(
        Uri.parse("https://tandoorhut.co/notification/singleDevice"),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<bool> sendToAdmin(
      String title, String message, String topic) async {
    final Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode(
      {"title": title, "message": message, "topic": topic},
    );
    http.Response response = await http.post(
        Uri.parse("https://tandoorhut.co/notification/allDevice"),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
