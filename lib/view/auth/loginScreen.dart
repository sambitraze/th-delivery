import 'dart:convert';

import 'package:Th_delivery/model/deliveryBoy.dart';
import 'package:Th_delivery/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  final scaffkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffkey,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://image.freepik.com/free-photo/empty-wood-table-top-abstract-blurred-restaurant-cafe-background-can-be-used-display-montage-your-products_7191-916.jpg"),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.55), BlendMode.darken)),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage("assets/logo.png"),
                  radius: 50,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: InkWell(
                    onTap: () {
                      SnackBar(
                        content: Text("Version: 1.0"),
                      );
                    },
                    child: Text(
                      'Delivery Partner App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 300,
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: email,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      focusColor: Colors.black26,
                      fillColor: Colors.black26,
                      filled: true,
                      hintText: 'Enter Email',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white30,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white30,
                          width: 4.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  width: 300,
                  alignment: Alignment.center,
                  child: TextFormField(
                    obscureText: true,
                    controller: password,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      focusColor: Colors.black26,
                      fillColor: Colors.black26,
                      filled: true,
                      hintText: 'Enter Password',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white54,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white30,
                          width: 4.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    http.Response response = await http.post(
                      Uri.parse("https://tandoorhut.co/deliveryBoy/email"),
                      headers: {"Content-Type": "application/json"},
                      body: jsonEncode({"email": email.text}),
                    );
                    if (response.statusCode == 200) {
                      var responseMap = json.decode(response.body);
                      DeliveryBoy deliveryBoy =
                          DeliveryBoy.fromJson(responseMap[0]);
                      if (deliveryBoy.password == password.text) {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool("login", true);
                        pref.setString("email", deliveryBoy.email);
                        pref.setString("id", deliveryBoy.id);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('No User Found'),
                        ),
                      );
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  minWidth: 150,
                  padding: EdgeInsets.all(12),
                  color: Colors.greenAccent[400],
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                isLoading ? CircularProgressIndicator() : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
