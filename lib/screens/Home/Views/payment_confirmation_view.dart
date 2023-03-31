// import 'dart:io' show Platform;
// import 'package:CHATS/router.dart';
// import 'package:CHATS/domain/locator.dart';
// import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
// import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
// import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS/widgets/error_widget_handler.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:barcode_scan2/barcode_scan2.dart';

class PaymentConfirmationView extends StatefulWidget {
  const PaymentConfirmationView({Key? key, this.qrReference}) : super(key: key);

  final String? qrReference;
  @override
  _PaymentConfirmationViewState createState() =>
      _PaymentConfirmationViewState();
}

class _PaymentConfirmationViewState extends State<PaymentConfirmationView> {
  // ScanResult? _result;
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // var orientation = MediaQuery.of(context).orientation;
    // BeneficiaryUser? user = locator<UserService>().data;
    print({"Reference", widget.qrReference});
    return WillPopScope(
      onWillPop: () => onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor:
              ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
          title: CustomText(
            text: 'Payment Confirmation',
            fontFamily: 'Gilroy-medium',
            fontSize: 22,
            edgeInset: EdgeInsets.only(top: 3),
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
        body: FutureBuilder(
          future: locator<UserService>().getOrder(widget.qrReference!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator.adaptive());
            }

            if (snapshot.hasError) {
              return ErrorWidgetHandler(onTap: () {
                setState(() {});
              });
            }

            if (snapshot.data is String) {
              return ErrorWidgetHandler(onTap: () {
                setState(() {});
              });
            }

            return Container(
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
              padding: EdgeInsets.only(left: 20, right: 20, top: 75),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: Color.fromRGBO(124, 141, 181, 1),
                      ),
                      color: Color.fromRGBO(245, 246, 248, 1),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'AMOUNT TO BE PAID',
                                  fontSize: 12,
                                  fontFamily: 'Gilroy-regular',
                                  textAlign: TextAlign.left,
                                  color: Color.fromRGBO(124, 141, 181, 1),
                                ),
                                CustomText(
                                  text:
                                      '${locator<UserService>().order!.totalCost.toString()}',
                                  fontSize: 18,
                                  fontFamily: 'Gilroy-medium',
                                  textAlign: TextAlign.left,
                                  color: Color.fromRGBO(37, 57, 111, 1),
                                ),
                              ],
                            ),
                            SizedBox(width: 55),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'VENDOR',
                                  fontSize: 12,
                                  fontFamily: 'Gilroy-regular',
                                  textAlign: TextAlign.left,
                                  color: Color.fromRGBO(124, 141, 181, 1),
                                ),
                                CustomText(
                                  text:
                                      '${locator<UserService>().order!.order!.vendor!.store!.storeName ?? ''}',
                                  fontSize: 18,
                                  fontFamily: 'Gilroy-medium',
                                  textAlign: TextAlign.left,
                                  color: Color.fromRGBO(37, 57, 111, 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'CURRENT BALANCE',
                                  fontSize: 12,
                                  fontFamily: 'Gilroy-regular',
                                  textAlign: TextAlign.left,
                                  color: Color.fromRGBO(124, 141, 181, 1),
                                ),
                                CustomText(
                                  text:
                                      'NGN ${locator<UserService>().data!.totalWalletBalance.toString()}',
                                  fontSize: 18,
                                  fontFamily: 'Gilroy-medium',
                                  textAlign: TextAlign.left,
                                  color: Color.fromRGBO(37, 57, 111, 1),
                                ),
                              ],
                            ),
                            SizedBox(width: 62),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'PENDING BALANCE',
                                  fontSize: 12,
                                  fontFamily: 'Gilroy-regular',
                                  textAlign: TextAlign.left,
                                  color: Color.fromRGBO(124, 141, 181, 1),
                                ),
                                CustomText(
                                  text:
                                      'NGN ${(locator<UserService>().data!.totalWalletBalance! - locator<UserService>().order!.totalCost!).toString()}',
                                  fontSize: 18,
                                  fontFamily: 'Gilroy-medium',
                                  textAlign: TextAlign.left,
                                  color: Color.fromRGBO(37, 57, 111, 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'GENERATED ON',
                                  fontSize: 12,
                                  fontFamily: 'Gilroy-regular',
                                  textAlign: TextAlign.left,
                                  color: Color.fromRGBO(124, 141, 181, 1),
                                ),
                                CustomText(
                                  text:
                                      '${DateTime.parse(locator<UserService>().order!.order!.createdAt!).day} / ${DateTime.parse(locator<UserService>().order!.order!.createdAt!).month}, ${DateTime.parse(locator<UserService>().order!.order!.createdAt!).year}. ${DateTime.parse(locator<UserService>().order!.order!.createdAt!).hour}:${DateTime.parse(locator<UserService>().order!.order!.createdAt!).minute}',
                                  fontSize: 18,
                                  fontFamily: 'Gilroy-medium',
                                  textAlign: TextAlign.left,
                                  color: Color.fromRGBO(37, 57, 111, 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 70),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: CustomButton(
                      margin: EdgeInsets.zero,
                      onTap: () {
                        print('Go to enter transaction PIN screen');
                        Navigator.pushNamed(context, transactionPin,
                            arguments: widget.qrReference);
                      },
                      children: [
                        CustomText(
                          color: Colors.white,
                          text: "Confirm Transaction",
                          fontSize: 18,
                          fontFamily: 'Gilroy-bold',
                          edgeInset: EdgeInsets.zero,
                        ),
                      ],
                      // style: ButtonStyle(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
