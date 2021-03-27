import 'package:CHATS/utils/custom_btn.dart';
import 'package:flutter/material.dart';

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
              leading: GestureDetector(
                  child: Image.asset("assets/icons/arrow_back.png"),
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
              title: Text(
                "Payment Confirmation",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Gilroy-medium",
                ),
              ),
            ),
            body: Column(children: [
              Container(
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                height: 550,
                color: Color(0xff492954).withOpacity(0.05),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 10),
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
                      SizedBox(height: 20),
                      // !End of Column
                    ]),
              ),
              buildExpanded()
            ])),
      ),
    );
  }

  Widget buildExpanded() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Center(
            child: CustomButton(
                // onPressed: () {
                //   print("Confirmation ");
                // },
                // title: "Confirm Transaction",
                ),
          )
        ],
      ),
    );
  }

  Widget paymentDetails() {
    return Column(
      children: [
        SizedBox(height: 30),
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
            SizedBox(height: 20),
          ],
        ),
        SizedBox(height: 70),
      ],
    );
  }
}
