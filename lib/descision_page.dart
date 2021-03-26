import 'package:CHATS/ChatsMain/main.dart';
import 'package:CHATS/ChatsMain/ui/shared/BTN.dart';
import 'package:CHATS/ChatsMain/ui/shared/TEXT.dart';
import 'package:CHATS/Vendor/main.dart';
import 'package:CHATS/general_locator.dart';
import 'package:CHATS/general_sharedPref.dart';
import 'package:CHATS/local_storage.dart';
import 'package:CHATS/user_type.dart';
import 'package:flutter/material.dart';

import 'ChatsMain/ui/shared/ui_helper.dart';

class DescisionPage extends StatefulWidget {
  @override
  _DescisionPageState createState() => _DescisionPageState();
}

class _DescisionPageState extends State<DescisionPage> {
  final locator = newLocator<GSharedPref>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallH = size.height / 36;
    final smallW = size.height / 46;
    return Scaffold(
        body: Container(
      height: size.height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: Image.asset(
                  'assets/logo.png',
                  width: smallW * 10,
                ),
                margin: EdgeInsets.only(bottom: smallH * 1.2),
              ),
            ),
            SizedBox(height: 10),
            TEXT(
              text: "Sign Up As !",
              fontFamily: 'Gilroy-bold',
              fontSize: 25,
            ),
            SizedBox(height: 10),
            BTN(
              bgColor: Constants.purple,
              borderRadius: 10,
              onTap: () {
                LocalStorage().saveUser(userType[UserType.Vendor]);
                print("Saved");
                // locator.setUserOption('vendor');
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => VendorApp()));
              },
              children: [
                Image.asset("icons/profile.png"),
                TEXT(
                  text: "Vendor",
                  fontFamily: 'Gilroy-bold',
                  fontSize: 25,
                  color: Colors.white,
                ),
              ],
            ),
            BTN(
              bgColor: Constants.purple,
              borderRadius: 10,
              onTap: () {
                LocalStorage().saveUser(userType[UserType.Non_Vendor]);
                // LocalStorage().saveUser(UserType.Non_Vendor);
                print("Saved");
                // locator.setUserOption('beneficiaries');
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => NonVendorApp()));
              },
              children: [
                Image.asset("icons/profile.png"),
                TEXT(
                  color: Colors.white,
                  text: "Beneficiary",
                  fontFamily: 'Gilroy-bold',
                  fontSize: 25,
                ),
              ],
            ),
          ]),
    ));
  }
}
