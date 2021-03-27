import 'package:CHATS/router.dart';
import 'package:CHATS/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppDrawer extends StatelessWidget {
  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // AppDrawer({@required this.scaffoldKey});
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
                    // color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: "Gilroy-Regular",
                  ),
                ),
              ]),
            ),
            // child: ListTile(
            //   title: Text(
            //     "Home",
            //     style: TextStyle(
            //       // color: Colors.black,
            //       fontWeight: FontWeight.w400,
            //       fontSize: 15,
            //       fontFamily: "Gilroy-Regular",
            //     ),
            //   ),
            //   leading: Image.asset("assets/cl_home.png"),
            // ),
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
              )
              // child: ListTile(
              //   title: Text(
              //     "Wallet",
              //     style: TextStyle(
              //       fontWeight: FontWeight.w400,
              //       fontSize: 15,
              //       fontFamily: "Gilroy-Regular",
              //     ),
              //   ),
              //   leading: Image.asset("assets/wallet.png"),
              // ),
              ),
          SizedBox(height: 25),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, scanNFCOrQR);
            },
            //   child: ListTile(
            //     title: Text(
            //       "Generate/Scan QR code",
            //       style: TextStyle(
            //         fontWeight: FontWeight.w400,
            //         fontSize: 15,
            //         fontFamily: "Gilroy-Regular",
            //       ),
            //     ),
            //     leading: Image.asset("assets/barcode.png"),
            //   ),
            // ),
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
            // child: ListTile(
            //   title: Text(
            //     "Notifications",
            //     style: TextStyle(
            //       fontWeight: FontWeight.w400,
            //       fontSize: 15,
            //       fontFamily: "Gilroy-Regular",
            //     ),
            //   ),
            //   leading: Image.asset("assets/notifications.png"),
            // ),
            child: Container(
              child: Row(children: [
                SizedBox(width: 10),
                Image.asset("assets/notifications.png"),
                SizedBox(width: 10),
                Text(
                  "Notifications",
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
              Navigator.pushReplacementNamed(context, profile);
            },
            // child: ListTile(
            //   title: Text(
            //     "Profile",
            //     style: TextStyle(
            //       fontWeight: FontWeight.w400,
            //       fontSize: 15,
            //       fontFamily: "Gilroy-Regular",
            //     ),
            //   ),
            //   leading: Image.asset("assets/profile.png"),
            // ),
            child: Container(
              child: Row(children: [
                SizedBox(width: 10),
                Image.asset("assets/profile.png"),
                SizedBox(width: 10),
                Text(
                  "Profile",
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
              // Navigator.pushReplacementNamed(context, scanCode);
            },
            // child: ListTile(
            //   title: Text(
            //     "Contact Us",
            //     style: TextStyle(
            //       fontWeight: FontWeight.w400,
            //       fontSize: 15,
            //       fontFamily: "Gilroy-Regular",
            //     ),
            //   ),
            //   leading: Image.asset("assets/contact.png"),
            // ),
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
            // child: ListTile(
            //   title: Text(
            //     "Log Out",
            //     style: TextStyle(
            //       fontWeight: FontWeight.w400,
            //       fontSize: 15,
            //       fontFamily: "Gilroy-Regular",
            //     ),
            //   ),
            //   leading: Icon(Icons.power_settings_new, color: Colors.red),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, 'login');
            //   },
            // ),
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
