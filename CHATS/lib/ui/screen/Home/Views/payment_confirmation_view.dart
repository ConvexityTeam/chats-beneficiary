import 'package:CHATS/core/constants/ui_helper.dart';
import 'package:CHATS/ui/screen/Home/Widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';

class PaymentConfirmationView extends StatelessWidget {
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
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "Payment Confirmation",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: "Gilroy-Regular",
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: UIHelper.sidePadding,
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Center(child: paymentDetails())),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: CustomButton(
                        onPressed: () {
                          print("Confirmation ");
                        },
                        title: "Confirm Transaction",
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentDetails() {
    return Column(
      children: [
        SizedBox(height: 50),
        Column(
          children: [
            Text(
              "AMOUNT TO BE PAID",
              style: TextStyle(
                color: Color(0xff222222),
                fontSize: 12,
                fontFamily: "Gilroy-Regular",
              ),
            ),
            Text(
              "\$${7500.00}",
              style: TextStyle(
                color: Color(0xff222222),
                fontSize: 16,
                fontFamily: "Gilroy-medium",
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
        Column(
          children: [
            Text(
              "VENDOR",
              style: TextStyle(
                fontFamily: "Gilroy-Regular",
                color: Color(0xff222222),
                fontSize: 12,
              ),
            ),
            Text(
              "Cadbury Nigeria",
              style: TextStyle(
                color: Color(0xff222222),
                fontFamily: "Gilroy-medium",
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
        Column(
          children: [
            Text(
              "CURRENT BALANCE",
              style: TextStyle(
                color: Color(0xff222222),
                fontFamily: "Gilroy-Regular",
                fontSize: 12,
              ),
            ),
            Text(
              "\$${12},${500.00}",
              style: TextStyle(
                color: Color(0xff222222),
                fontSize: 16,
                fontFamily: "Gilroy-medium",
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
        Column(
          children: [
            Text(
              "PENDING BALANCE",
              style: TextStyle(
                color: Color(0xff222222),
                fontFamily: "Gilroy-Regular",
                fontSize: 12,
              ),
            ),
            Text(
              "\$${7},${500.00}",
              style: TextStyle(
                color: Color(0xff222222),
                fontSize: 16,
                fontFamily: "Gilroy-medium",
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
        Column(
          children: [
            Text(
              "GENERATED ON",
              style: TextStyle(
                color: Color(0xff222222),
                fontFamily: "Gilroy-Regular",
                fontSize: 12,
              ),
            ),
            Text(
              "03 Dec, 2020. 12:45 pm",
              style: TextStyle(
                color: Color(0xff222222),
                fontFamily: "Gilroy-medium",
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(height: 70),
      ],
    );
  }
}
