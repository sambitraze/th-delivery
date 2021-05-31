import 'dart:convert';
import 'package:Th_delivery/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  // ignore: missing_return
  static Future<User> getUserByPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString("phoneNo");
    http.Response response = await http.post(
        Uri.parse("https://tandoorhut.co/user/number/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}));
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      User user = User.fromJson(responseMap[0]);
      return user;
    } else {
      print("Debug create user");
    }
  }

  // ignore: missing_return
  static Future<bool> updateUser(User user) async {
    http.Response response = await http.put(
      Uri.parse("https://tandoorhut.co/user/update/${user.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        user.toJson(),
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Debug update user");
      return false;
    }
  }
}
