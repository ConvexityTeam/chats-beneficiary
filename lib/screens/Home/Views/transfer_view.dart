import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/models/wallet.dart';
import 'package:CHATS/screens/Home/views/drawer_view.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS/widgets/error_widget_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class TransferView extends StatefulWidget {
  final int? campaignId;

  TransferView({
    this.campaignId,
  });

  @override
  _TransferViewState createState() => _TransferViewState();
}

class _TransferViewState extends State<TransferView> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  late PageController pageController;
  TextEditingController _transferAmountController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  late bool isTransferSuccessful = false;
  late String messageResponse = '';

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    _transferAmountController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print({
      locator<UserService>().data!.wallets,
      locator<UserService>().data!.wallets?.length,
      locator<UserService>().data!.wallets?.isEmpty,
      locator<UserService>().data!.totalWalletBalance,
      "Wallet object returned"
    });

    final _balance = widget.campaignId != null
        ? locator<UserService>()
            .data!
            .wallets
            ?.firstWhere((w) => w.campaignId == widget.campaignId,
                orElse: () => locator<UserService>().data!.wallets!.first)
            .balance
        : locator<UserService>().data!.totalWalletBalance;

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () => onBackPressed(context),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor:
              ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: CustomText(
            text: "Transfer",
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
            fontSize: 22,
            fontFamily: "Gilroy-medium",
            edgeInset: EdgeInsets.zero,
          ),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: null,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator.adaptive());
            }

            if (snapshot.hasError) {
              return ErrorWidgetHandler(onTap: () {
                setState(() {});
              });
            }

            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 42),
                            CustomText(
                              text: 'Amount',
                              fontSize: 16,
                              fontFamily: 'Gilroy-Medium',
                            ),
                            SizedBox(height: 12),
                            Padding(
                              padding: EdgeInsets.only(left: 32, right: 32),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  hintText: '0.00',
                                  helperText:
                                      '${widget.campaignId != null ? 'Campaign' : 'Personal'} Balance:',
                                  counterText: '${_balance}',
                                  counterStyle:
                                      TextStyle(fontFamily: 'Gilroy-Bold'),
                                ),
                                style: TextStyle(
                                  fontSize: 36,
                                  fontFamily: 'Gilroy-Medium',
                                ),
                                controller: _transferAmountController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                cursorColor: Constants.usedGreen,
                                validator: (val) => val!.isEmpty
                                    ? 'Amount cannot be empty'
                                    : null,
                              ),
                            ),
                            SizedBox(height: 32),
                            CustomTextField(
                              label: CustomText(text: 'Transfer to'),
                              prefixText: "@",
                              hintText: 'username',
                              controller: _usernameController,
                              validateFn: (val) => val!.isEmpty
                                  ? 'Username cannot be empty'
                                  : null,
                            ),
                            CustomButton(
                              onTap: () async {
                                formKey.currentState!.save();
                                if (formKey.currentState!.validate()) {
                                  var pin = await showPinDialog();
                                  if (kDebugMode)
                                    print({
                                      '<<<<TRANSFER STATUS>>>>',
                                      pin,
                                      widget.campaignId,
                                    });
                                  final Map<String, dynamic> service =
                                      await locator<UserService>()
                                          .transferFundsToUser(
                                    fromWallet: widget.campaignId == null
                                        ? 'personal'
                                        : 'campaign',
                                    username: _usernameController.text.trim(),
                                    pin: pin,
                                    amount: double.parse(
                                        _transferAmountController.text),
                                    campaignId: widget.campaignId.toString(),
                                  );

                                  final bool isSuccessful =
                                      service['status'] == 'success';

                                  setState(() {
                                    isTransferSuccessful = isSuccessful;
                                    messageResponse = service['message'];
                                  });

                                  pageController.animateToPage(
                                    1,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.ease,
                                  );
                                }
                              },
                              height: 52,
                              child: CustomText(
                                text: 'Send',
                                fontFamily: 'Gilroy-Bold',
                                textAlign: TextAlign.center,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 42),
                          Icon(
                            isTransferSuccessful
                                ? Icons.check_circle_rounded
                                : Icons.cancel_rounded,
                            size: 72,
                            color: isTransferSuccessful
                                ? Constants.usedGreen
                                : Colors.redAccent.shade400,
                          ),
                          SizedBox(height: 32),
                          CustomText(
                            text: isTransferSuccessful
                                ? 'Transfer successful'
                                : 'Transfer failed',
                            fontSize: 24,
                            fontFamily: 'Gilroy-Bold',
                          ),
                          SizedBox(height: 16),
                          CustomText(
                            text: messageResponse,
                            // isTransferSuccessful
                            //     ? 'You sent NGN${_transferAmountController.text} to @${_usernameController.text}'
                            //     : 'The transfer failed while processing!',
                            fontSize: 16,
                            fontFamily: 'Gilroy-Regular',
                          ),
                          SizedBox(height: 38),
                          CustomButton(
                            onTap: () {
                              pageController.animateToPage(
                                0,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.ease,
                              );
                            },
                            child: CustomText(
                              text: 'Ok, got it',
                              color: Constants.usedGreen,
                              textAlign: TextAlign.center,
                              fontFamily: 'Gilroy-Bold',
                            ),
                            bgColor: Colors.transparent,
                            borderColor: Constants.usedGreen,
                            height: 52,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future showPinDialog() {
    return showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height * .32,
              // width: 120,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Authorize Transfer',
                    textAlign: TextAlign.center,
                    fontFamily: 'Gilroy-Bold',
                  ),
                  SizedBox(height: 16),
                  OTPTextField(
                    length: 4,
                    width: double.infinity,
                    fieldWidth: 45,
                    style: TextStyle(fontSize: 18, fontFamily: 'Gilroy-Medium'),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    obscureText: true,
                    otpFieldStyle: OtpFieldStyle(
                      focusBorderColor: Constants.usedGreen,
                      backgroundColor: Colors.transparent,
                    ),
                    onCompleted: (value) {
                      // TODO: Call transFer funds and return dialog
                      Navigator.pop(context, value);
                    },
                    onChanged: (currentPin) {
                      if (kDebugMode) print({'<<<<PIN CHANGE>>>>', currentPin});
                    },
                  ),
                  // CustomButton(
                  //   height: 52,
                  //   margin: EdgeInsets.all(24),
                  //   onTap: () {},
                  //   child: CustomText(
                  //     text: 'Authorize',
                  //     textAlign: TextAlign.center,
                  //     fontFamily: 'Gilroy-Bold',
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }

  String getWalletsBalance(List<Wallet>? wallets) {
    double? totalBalance = 0;
    for (var w in wallets!) {
      totalBalance = totalBalance! + w.balance!;
    }
    print({'totalBalance', totalBalance});
    return "\$$totalBalance.00";
  }
}
