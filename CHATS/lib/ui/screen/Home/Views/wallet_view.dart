import 'package:CHATS/core/constants/ui_helper.dart';
import 'package:CHATS/core/utils/colors.dart';
import 'package:CHATS/ui/screen/Home/Views/drawer_view.dart';
import 'package:flutter/material.dart';

class WalletView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
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
                child: Image.asset("assets/Group.png")),
            title: Text(
              "Wallet",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: "Gilroy-medium",
              ),
            ),
          ),
          drawer: AppDrawer(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: UIHelper.sidePadding,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.857,
                      height: 210,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\$${125},000.00",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                fontFamily: "Gilroy-medium",
                                // height: 15,
                              ),
                            ),
                            Text(
                              "Current Balance",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Gilroy-medium",
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 55),
                    // !Row
                    SizedBox(width: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text(
                          "Recent Transactions",
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 16,
                            fontFamily: "Gilroy-medium",
                          ),
                        ),
                        Spacer(),
                        Text(
                          "See all",
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            fontFamily: "Gilroy-medium",
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              children: List.generate(
                                  20, (index) => buildDetails()))),
                    )
                  ],
                ),
                Positioned(
                  top: 180,
                  right: MediaQuery.of(context).size.width / 4,
                  child: Row(
                    children: [
                      buildCard(
                          icon: Image.asset("assets/send.png"), title: "Pay"),
                      SizedBox(width: 35),
                      buildCard(
                          icon: Icon(Icons.compare_arrows), title: "Convert"),
                    ],
                  ),
                ),

                // cards
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          color: Color.fromRGBO(240, 240, 240, 0.4),
          height: 56,
          width: 56,
          child: Center(
            child: Text(
              "C",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
        title: Text(
          "Dangote Nigeria",
          style: TextStyle(
            fontFamily: "Gilroy-medium",
          ),
        ),
        trailing: Text(
          "-\$${1},500.75",
          style: TextStyle(
            color: Color(0xffc20000),
            fontFamily: "Gilroy-medium",
          ),
        ),
        subtitle: Text(
          "25 Nov 2020",
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 13,
            fontFamily: "Gilroy-medium",
          ),
        ),
      ),
    );
  }

  Widget buildCard({Widget icon, String title}) {
    return Card(
      child: Container(
        height: 65,
        width: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: 12,
                fontFamily: "Gilroy-medium",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
