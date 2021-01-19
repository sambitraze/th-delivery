import 'package:Th_delivery/model/deliveryBoy.dart';
import 'package:Th_delivery/model/uiconstants.dart';
import 'package:Th_delivery/services/DeliveryBoyService.dart';
import 'package:Th_delivery/view/auth/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recase/recase.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DeliveryBoy deliveryBoy;
  bool _isLoading = false;
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    deliveryBoy = await DeliveryBoyService.getDeliveryBoyByEmail(email);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: !_isLoading
          ? Container(
              color: Colors.black,
              height: UIConstants.fitToHeight(640, context),
              width: UIConstants.fitToWidth(360, context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(children: [
                      Positioned(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          //height: UIConstants.fitToHeight(380, context), // Change
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0.0),
                                bottomLeft: Radius.circular(27.0),
                                bottomRight: Radius.circular(27.0),
                                topRight: Radius.circular(0.0),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: UIConstants.fitToHeight(30, context)),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:20.0, horizontal: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(children: [
                                      Text(
                                        'Assigned',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.46),
                                      ),
                                      Text(
                                        '${deliveryBoy.assigned}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.46,
                                        ),
                                      ),
                                    ]),
                                     Column(children: [
                                      Text(
                                        'Completed',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.46),
                                      ),
                                      Text(
                                        '${deliveryBoy.completed}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.46,
                                        ),
                                      ),
                                    ])
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: UIConstants.fitToHeight(25, context)),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50.5,
                                child: Text(
                                  '${deliveryBoy.name.substring(0, 1).toUpperCase()}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                              ),
                              SizedBox(
                                  height: UIConstants.fitToHeight(10, context)),
                              FlatButton.icon(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (BuildContext context) {
                                  //   return EditProfileScreen(user: user);
                                  // })).then((value) async {
                                  //   user = await UserService.getUser();
                                  //   setState(() {});
                                  // });
                                },
                                label: Text('Edit Profile',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.24)),
                              ),
                              SizedBox(
                                  height: UIConstants.fitToHeight(25, context)),
                              Text('${deliveryBoy.name.sentenceCase}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.46)),
                              SizedBox(
                                  height: UIConstants.fitToHeight(25, context)),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    profileInfo(
                        'Phone Number', '${deliveryBoy.phone}', Icons.call),
                    profileInfo('Email', '${deliveryBoy.email}', Icons.mail),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Color(0xff25354E),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setBool("login", false);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        },
        child: Icon(
          Icons.power_settings_new_outlined,
          size: 25,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget profileInfo(String labelText, String labelValue, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text('$labelText',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 17,
              fontWeight: FontWeight.bold)),
      subtitle: Text(
        '$labelValue',
        style: TextStyle(
            fontFamily: 'Montserrat', fontSize: 15, color: Colors.white),
      ),
    );
  }
}
