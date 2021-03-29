import 'package:CHATS/router.dart';
import 'package:CHATS/screens/home/views/drawer_view.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class ScanNFCOrQRView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Exit Application ?"),
            content: Text(
                "Are you sure you want to exit this application ? click No to cancel, and Yes to continue."),
            actions: [
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          ),
        );
      },
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                scaffoldKey.currentState.openDrawer();
              },
              child: Image.asset("assets/Group.png"),
            ),
            title: Text(
              "Scan QR Code",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Gilroy-medium",
                fontSize: 20,
              ),
            ),
          ),
          drawer: AppDrawer(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: UIHelper.sidePadding,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 246,
                        width: 150,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: UIHelper.borderRadius,
                          color: backgroundColor,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Image.asset(
                                  "assets/barcode.png",
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "   Scan\nNFC Card",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: "Gilroy-medium",
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Scan a customer\n  NFC Card",
                              style: TextStyle(
                                fontSize: 13,
                                // fontFamily: "Gilroy-medium",
                                color: Color(0xff4F4F4F),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(),
                            )
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(width: 5),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, scanCode);
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          height: 246,
                          width: 150,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: UIHelper.borderRadius,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Image.asset("assets/qr code.png",
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "  Scan\nQR Code",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontFamily: "Gilroy-medium",
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "    Complete a\npayment with an\nalready created\n   QR code.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff4F4F4F),
                                  // fontFamily: "Gilroy-medium",
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
