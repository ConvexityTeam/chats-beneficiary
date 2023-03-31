import 'dart:io' show Platform;

// import 'package:CHATS/router.dart';
// import 'package:CHATS/domain/locator.dart';
// import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
// import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/utils/otp_pin.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/error_widget_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:barcode_scan2/barcode_scan2.dart';

class TransactionPinView extends StatefulWidget {
  const TransactionPinView({Key? key, this.reference}) : super(key: key);

  final String? reference;
  @override
  _TransactionPinViewState createState() => _TransactionPinViewState();
}

class _TransactionPinViewState extends State<TransactionPinView> {
  // ScanResult? _result;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // var orientation = MediaQuery.of(context).orientation;
    // BeneficiaryUser? user = locator<UserService>().data;
    print({"Reference", widget.reference});
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
            child: Icon(Icons.arrow_back_ios,
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white),
          ),
        ),
        body: FutureBuilder(
          // future: locator<UserService>().getPaymentDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (snapshot.hasError) {
              return ErrorWidgetHandler(onTap: () {
                setState(() {});
              });
            }

            return Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 75),
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Column(
                      children: [
                        CustomText(
                          text:
                              'Enter your transaction PIN below to complete the payment.',
                          textAlign: TextAlign.center,
                          fontFamily: 'Gilroy-regular',
                          fontSize: 19,
                          color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                        ),
                        SizedBox(height: 20),
                        OTPPin(
                          showFieldAsBox: false,
                          onSubmit: (String? value) async {
                            setState(() {
                              loading = true;
                            });
                            print('Pin on submit $value');

                            // Get the userWalletId and campaignWalletId
                            String? userWalletId =
                                locator<UserService>().data?.userWallet?.uuid;
                            String? campaignWalletId = locator<UserService>()
                                .data
                                ?.wallets
                                ?.singleWhere((element) =>
                                    element.campaignId ==
                                    locator<UserService>()
                                        .order
                                        ?.order
                                        ?.campaignId)
                                .uuid;

                            var result = await locator<UserService>().checkOut(
                                widget.reference,
                                value,
                                userWalletId,
                                campaignWalletId);
                            await finishTransaction(result);
                            setState(() {
                              loading = false;
                            });
                          },
                          isTextObscure: true,
                          fields: 4,
                        ),
                        SizedBox(height: 30),
                        loading
                            ? CircularProgressIndicator.adaptive()
                            : Spacer(),
                      ],
                    ),
                  ),
                  // SizedBox(height: 70),
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 58,
                  //   child: CustomButton(
                  //     margin: EdgeInsets.zero,
                  //     onTap: () {
                  //       print('COnfirm transaction PIN');
                  //     },
                  //     children: [
                  //       CustomText(
                  //         color: Colors.white,
                  //         text: "Confirm Transaction",
                  //         fontSize: 18,
                  //         fontFamily: 'Gilroy-bold',
                  //         edgeInset: EdgeInsets.zero,
                  //       ),
                  //     ],
                  //     // style: ButtonStyle(),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  finishTransaction(Map? result) {
    return showDialog(
        context: context,
        builder: (context) {
          return Platform.isAndroid
              ? AlertDialog(
                  title: CustomText(
                    text: result!['status'] == 'success'
                        ? 'Transaction processing'
                        : 'Transaction failed',
                    fontFamily: 'Gilroy-medium',
                    textAlign: TextAlign.center,
                    fontSize: 18,
                  ),
                  content: CustomText(
                    text: result['status'] == 'success'
                        ? 'Your payment transaction is processing'
                        : 'Your payment transaction failed',
                    fontFamily: 'Gilroy-regular',
                    textAlign: TextAlign.center,
                    fontSize: 14,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(home);
                      },
                      child: Text('OKAY'),
                    ),
                  ],
                )
              : Platform.isIOS
                  ? CupertinoAlertDialog(
                      title: CustomText(
                        text: 'Transaction ${result!['status']}',
                        fontFamily: 'Gilroy-medium',
                        textAlign: TextAlign.center,
                        fontSize: 18,
                      ),
                      content: CustomText(
                        text: '${result['message']}',
                        fontFamily: 'Gilroy-regular',
                        textAlign: TextAlign.center,
                        fontSize: 14,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(home);
                          },
                          child: Text('OKAY'),
                        ),
                      ],
                    )
                  : Text('Platform Not recognized');
        });
  }
}
