import 'package:CHATS/utils/text.dart';
import 'package:CHATS/widgets/home/custom_button.dart';
import 'package:CHATS/domain/general_locator.dart';
import 'package:CHATS/domain/general_sharedPref.dart';
import 'package:CHATS/domain/local_storage.dart';
import 'package:CHATS/models/user_type.dart';
import 'package:flutter/material.dart';

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
            CustomText(
              text: "Sign Up As !",
              fontFamily: 'Gilroy-bold',
              fontSize: 25,
            ),
            SizedBox(height: 10),
            CustomButton(
              // bgColor: Constants.purple,
              // borderRadius: 10,
              onPressed: () {
                LocalStorage().saveUser(userType[UserType.Vendor]);
                print("Saved");
                // locator.setUserOption('vendor');
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (_) => VendorApp()));
              },
              title: '',
              // children: [
              //   Image.asset("icons/profile.png"),
              //   CustomText(
              //     text: "Vendor",
              //     fontFamily: 'Gilroy-bold',
              //     fontSize: 25,
              //     color: Colors.white,
              //   ),
              // ],
            ),
            CustomButton(
                // bgColor: Constants.purple,
                // borderRadius: 10,
                // onTap: () {
                //   LocalStorage().saveUser(userType[UserType.Non_Vendor]);
                //   // LocalStorage().saveUser(UserType.Non_Vendor);
                //   print("Saved");
                //   // locator.setUserOption('beneficiaries');
                //   Navigator.of(context).pushReplacement(
                //       MaterialPageRoute(builder: (_) => NonVendorApp()));
                // },
                // children: [
                //   Image.asset("icons/profile.png"),
                //   CustomText(
                //     color: Colors.white,
                //     text: "Beneficiary",
                //     fontFamily: 'Gilroy-bold',
                //     fontSize: 25,
                //   ),
                // ],
                ),
          ]),
    ));
  }
}
