import 'package:CHATS/router.dart';
import 'package:CHATS/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              height: 200,
              alignment: Alignment.topRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Column(children: [
                    SizedBox(height: 50),
                    Image.asset("assets/cancel.png")
                  ])),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, home);
            },
            child: Container(
              child: Row(children: [
                SizedBox(width: 10),
                Image.asset("assets/cl_home.png"),
                SizedBox(width: 10),
                Text(
                  "Home",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: "Gilroy-Regular",
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(height: 25),
          InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, wallet);
              },
              child: Container(
                child: Row(children: [
                  SizedBox(width: 10),
                  Image.asset("assets/wallet.png"),
                  SizedBox(width: 10),
                  Text(
                    "Wallet",
                    style: TextStyle(
                      // color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      fontFamily: "Gilroy-Regular",
                    ),
                  ),
                ]),
              )),
          SizedBox(height: 25),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, scanNFCOrQR);
            },
            child: Container(
              child: Row(children: [
                SizedBox(width: 10),
                Image.asset("assets/barcode.png"),
                SizedBox(width: 10),
                Text(
                  "Generate/Scan QR code",
                  style: TextStyle(
                    // color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: "Gilroy-Regular",
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(height: 25),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, notification);
            },
            child: Container(
              child: Row(children: [
                SizedBox(width: 10),
                Image.asset("assets/notifications.png"),
                SizedBox(width: 10),
                Text(
                  "Notifications",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: "Gilroy-Regular",
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(height: 25),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, profile);
            },
            child: Container(
              child: Row(children: [
                SizedBox(width: 10),
                Image.asset("assets/profile.png"),
                SizedBox(width: 10),
                Text(
                  "Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: "Gilroy-Regular",
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(height: 25),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, scanCode);
            },
            child: Container(
              child: Row(children: [
                SizedBox(width: 10),
                Image.asset("assets/contact.png"),
                SizedBox(width: 10),
                Text(
                  "Contact Us",
                  style: TextStyle(
                    // color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: "Gilroy-Regular",
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(height: 25),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (BuildContext context, Animation animation,
                        Animation secondaryAnimation) {
                      return LoginScreen();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(
                                  1.0,
                                  0.0,
                                ),
                                end: Offset.zero)
                            .animate(animation),
                        child: child,
                      );
                    },
                  ),
                  (route) => false);
            },
            child: Container(
              child: Row(children: [
                SizedBox(width: 10),
                Icon(Icons.power_settings_new, color: Colors.red),
                SizedBox(width: 10),
                Text(
                  "Log Out",
                  style: TextStyle(
                    // color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: "Gilroy-Regular",
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
