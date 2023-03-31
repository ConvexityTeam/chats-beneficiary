import 'package:CHATS/router.dart';
import 'package:CHATS/screens/auth/login_screen.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final drawarFontColor =
        ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
            ? Color.fromRGBO(37, 57, 111, 1)
            : Colors.white;
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
                    Image.asset(
                      "assets/cancel.png",
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white,
                    )
                  ])),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, home);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(children: [
                SizedBox(width: 10),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/cl_home.png",
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? null
                          : Colors.white),
                ),
                SizedBox(width: 10),
                Text(
                  "Home",
                  style: TextStyle(
                    color: drawarFontColor,
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
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(children: [
                SizedBox(width: 10),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/wallet.png",
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? null
                          : Colors.white),
                ),
                SizedBox(width: 10),
                Text(
                  "Wallet",
                  style: TextStyle(
                    color: drawarFontColor,
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
              Navigator.pushReplacementNamed(context, campaigns);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(children: [
                SizedBox(width: 10),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/campaigns.png",
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? null
                          : Colors.white),
                ),
                SizedBox(width: 10),
                Text(
                  "My Campaigns",
                  style: TextStyle(
                    color: drawarFontColor,
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
              Navigator.pushReplacementNamed(context, tasks);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(children: [
                SizedBox(width: 10),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/tasks.png",
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? null
                          : Colors.white),
                ),
                SizedBox(width: 10),
                Text(
                  "My Tasks",
                  style: TextStyle(
                    color: drawarFontColor,
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
              Navigator.pushReplacementNamed(context, scanNFCOrQR);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(children: [
                SizedBox(width: 10),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/barcode.png",
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? null
                          : Colors.white),
                ),
                SizedBox(width: 10),
                Text(
                  "Scan QR code",
                  style: TextStyle(
                    color: drawarFontColor,
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
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(children: [
                SizedBox(width: 10),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/notifications.png",
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? null
                          : Colors.white),
                ),
                SizedBox(width: 10),
                Text(
                  "Notifications",
                  style: TextStyle(
                    color: drawarFontColor,
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
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(children: [
                SizedBox(width: 10),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/profile.png",
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? null
                          : Colors.white),
                ),
                SizedBox(width: 10),
                Text(
                  "Profile",
                  style: TextStyle(
                    color: drawarFontColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: "Gilroy-Regular",
                  ),
                ),
              ]),
            ),
          ),
          // SizedBox(height: 25),
          // InkWell(
          //   onTap: () {
          //     // Navigator.pushReplacementNamed(context, scanCode);
          //     print('Contact Us Page');
          //   },
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 10),
          //     child: Row(children: [
          //       SizedBox(width: 10),
          //       SizedBox(
          //         width: 24,
          //         height: 24,
          //         child: Image.asset("assets/contact.png"),
          //       ),
          //       SizedBox(width: 10),
          //       Text(
          //         "Contact Us",
          //         style: TextStyle(
          //           color: drawarFontColor,
          //           fontWeight: FontWeight.w400,
          //           fontSize: 15,
          //           fontFamily: "Gilroy-Regular",
          //         ),
          //       ),
          //     ]),
          //   ),
          // ),
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
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(children: [
                SizedBox(width: 10),
                Icon(Icons.power_settings_new, color: Colors.red),
                SizedBox(width: 10),
                Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.red,
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
