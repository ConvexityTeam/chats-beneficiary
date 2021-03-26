import 'package:CHATS/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
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
              // leading: GestureDetector(
              //     onTap: () {
              //       scaffoldKey.currentState.openDrawer();
              //     },
              //     child: Image.asset("assets/Group.png")),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                "Notification",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: UIHelper.sidePadding,
              child: Column(children: [
                SizedBox(height: 25),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, int index) => builNotificationCard(),
                    separatorBuilder: (context, int index) =>
                        SizedBox(height: 10),
                    itemCount: 10,
                  ),
                )
              ]),
            )),
      ),
    );
  }

  Widget builNotificationCard() {
    int price = 240;
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(240, 240, 240, 0.4),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            )),
        height: 62,
        width: 62,
        child: Center(
          child: Text(
            "C",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: "Gilroy-medium",
            ),
          ),
        ),
      ),
      title: Text(
        "You have recieved \$$price from dangote foundation.",
        style: TextStyle(
          fontFamily: "Gilroy-Regular",
        ),
      ),
    );
  }
}
