import 'dart:convert';

import 'package:Th_delivery/services/PushServices.dart';
import 'package:Th_delivery/view/Profile/profile.dart';
import 'package:Th_delivery/view/orders/orderHistory.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/deliveryBoy.dart';
import '../services/DeliveryBoyService.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  var location = new Location();
  LocationData userLocation;
  @override
  void initState() {
    getLocation();
    location.changeSettings(interval: 15000);
    super.initState();
    PushService.genTokenID();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(notification.title),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              content: Text(notification.body),
              actions: <Widget>[
                MaterialButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  getLocation() async {
    var p = await location.hasPermission();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DeliveryBoy db = await DeliveryBoyService.getDeliveryBoyByEmail(
        prefs.getString("email"));
    if (p == PermissionStatus.denied || p == PermissionStatus.deniedForever) {
      await location.requestPermission();
    } else {
      location.onLocationChanged.listen((LocationData currentLocation) async {
        db.latitude = currentLocation.latitude.toString();
        db.longitude = currentLocation.longitude.toString();
        bool up =
            await DeliveryBoyService.updateDeliveryBoy(jsonEncode(db.toJson()));
        print(up);
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    OrderHistory(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await PushService.genTokenID();
        },
      ),
      backgroundColor: Colors.black,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Color(0xff80879A),
          selectedItemColor: Colors.orange,
          elevation: 10.0,
          backgroundColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
