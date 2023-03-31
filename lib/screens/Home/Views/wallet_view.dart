import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/models/wallet.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/screens/Home/views/drawer_view.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS/widgets/error_widget_handler.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:snack/snack.dart';

class WalletView extends StatefulWidget {
  @override
  _WalletViewState createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Map? withdrawBank = {};
  int? selectedWallet = 0;
  int? selectedWalletCampaignId;
  bool? withdrawLoading = false;
  TextEditingController _withdrawAmountController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    print({
      locator<UserService>().data!.wallets,
      locator<UserService>().data!.wallets?.length,
      locator<UserService>().data!.wallets?.isEmpty,
      "Wallet object returned"
    });
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
          leading: GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Image.asset("assets/Group.png",
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white),
          ),
          title: CustomText(
            text: "Wallet",
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
          future: locator<UserService>().data != null &&
                  locator<UserService>().isNewCampaignActive != true
              ? null
              : locator<UserService>().setUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator.adaptive());
            }

            if (snapshot.hasError) {
              return ErrorWidgetHandler(onTap: () {
                setState(() {});
              });
            }

            return RefreshIndicator(
              onRefresh: () async {
                locator<UserService>().setUserData();
                setState(() {});
              },
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 210,
                              child: locator<UserService>().data!.wallets ==
                                          null ||
                                      locator<UserService>()
                                          .data!
                                          .wallets!
                                          .isEmpty
                                  ? Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      height: 210,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              // getWalletsBalance(
                                              //     locator<UserService>().data!.wallets),
                                              'No Campaign wallet',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  fontFamily: "Gilroy-medium",
                                                  color: Constants.usedGreen
                                                  // height: 10,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Constants.usedGreen
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 220,
                                      child: ListView.builder(
                                        shrinkWrap: false,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: locator<UserService>()
                                            .data!
                                            .wallets
                                            ?.length,
                                        itemBuilder: (context, i) {
                                          print({"Index campaign Id"});
                                          return GestureDetector(
                                            onTap: () {
                                              if (selectedWallet != (i + 1)) {
                                                setState(() {
                                                  selectedWallet = (i + 1);
                                                  selectedWalletCampaignId =
                                                      locator<UserService>()
                                                          .data!
                                                          .wallets![i]
                                                          .campaignId;
                                                });
                                                _withdrawAmountController
                                                    .text = locator<
                                                        UserService>()
                                                    .data!
                                                    .wallets![selectedWallet! ==
                                                            0
                                                        ? selectedWallet!
                                                        : selectedWallet! - 1]
                                                    .balance!
                                                    .toStringAsFixed(2);
                                              } else {
                                                setState(() {
                                                  selectedWallet = 0;
                                                  selectedWalletCampaignId =
                                                      null;
                                                });
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              alignment: Alignment.center,
                                              width: locator<UserService>()
                                                          .data!
                                                          .wallets
                                                          ?.length ==
                                                      1
                                                  ? MediaQuery.of(context)
                                                      .size
                                                      .width
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.80,
                                              height: 200,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Checkbox(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          activeColor: Constants
                                                              .usedGreen,
                                                          // fillColor:
                                                          //     MaterialStateProperty.all(
                                                          //         Constants.usedGreen),
                                                          value:
                                                              selectedWallet ==
                                                                  (i + 1),
                                                          onChanged: (checked) {
                                                            // set value and return
                                                            if (checked!) {
                                                              setState(() {
                                                                selectedWallet =
                                                                    (i + 1);
                                                                selectedWalletCampaignId = locator<
                                                                        UserService>()
                                                                    .data!
                                                                    .wallets![i]
                                                                    .campaignId;
                                                              });
                                                              _withdrawAmountController
                                                                  .text = locator<
                                                                      UserService>()
                                                                  .data!
                                                                  .wallets![selectedWallet! ==
                                                                          0
                                                                      ? selectedWallet!
                                                                      : selectedWallet! -
                                                                          1]
                                                                  .balance!
                                                                  .toStringAsFixed(
                                                                      2);
                                                            } else {
                                                              setState(() {
                                                                selectedWallet =
                                                                    0;
                                                                selectedWalletCampaignId =
                                                                    null;
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 6),
                                                    Text(
                                                      "${i + 1} of ${locator<UserService>().data!.wallets?.length.toString()}",
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontFamily:
                                                            "Gilroy-medium",
                                                      ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      "Current Balance",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            "Gilroy-regular",
                                                      ),
                                                    ),
                                                    Text(
                                                      // getWalletsBalance(
                                                      //     locator<UserService>().data!.wallets),
                                                      '${locator<UserService>().data?.campaigns?.firstWhere((element) => element.id == locator<UserService>().data!.wallets![i].campaignId).type != 'item' ? locator<UserService>().data!.wallets![i].localCurrency : ''} ${locator<UserService>().data!.wallets != null ? locator<UserService>().data!.wallets![i].balance?.toStringAsFixed(2) : 0}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 32,
                                                          fontFamily:
                                                              "Gilroy-medium",
                                                          color: Constants
                                                              .usedGreen
                                                          // height: 10,
                                                          ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      // locator<UserService>().data!.wallets![i].campaignId == locator<UserService>().data!.campaigns![i <= 0 ? 0 : --i].id ? locator<UserService>().data!.campaigns![i <= 0 ? 0 : --i].title : 'Not found' : ''
                                                      '${locator<UserService>().data!.wallets![i].campaignId != null ? locator<UserService>().data?.campaigns?.firstWhere((element) => element.id == locator<UserService>().data!.wallets![i].campaignId).title : 'Not a campaign wallet'}',
                                                      style: TextStyle(
                                                        fontSize: 13.5,
                                                        fontFamily:
                                                            "Gilroy-medium",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: Constants.usedGreen
                                                    .withOpacity(0.1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ),
                            SizedBox(height: 50),
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height * .63),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 20.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Recent Transactions",
                                          style: TextStyle(
                                            color: ThemeBuilder.of(context)!
                                                        .getCurrentTheme() ==
                                                    Brightness.light
                                                ? Color(0xff333333)
                                                : Colors.white,
                                            fontSize: 16,
                                            fontFamily: "Gilroy-medium",
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, notification);
                                          },
                                          child: Text(
                                            "See all",
                                            style: TextStyle(
                                              color: ThemeBuilder.of(context)!
                                                          .getCurrentTheme() ==
                                                      Brightness.light
                                                  ? Color(0xff333333)
                                                  : Colors.white,
                                              fontSize: 14,
                                              fontFamily: "Gilroy-medium",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  History(),
                                ],
                              ),
                            ),
                            // Container(
                            //   child: Placeholder(),
                            // ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 183,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        // right: MediaQuery.of(context).size.width / 2 - 135,
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Go to scan QR code screen
                                  if (locator<UserService>()
                                              .data!
                                              .wallets
                                              ?.length ==
                                          0 ||
                                      locator<UserService>().data!.wallets ==
                                          null) {
                                    var snackBar = SnackBar(
                                      content: Text(
                                        'You have no active campaign wallet, try joining a campaign',
                                        // color: ThemeBuilder.of(context)!
                                        //             .getCurrentTheme() ==
                                        //         Brightness.light
                                        //     ? Colors.white
                                        //     : Colors.black,
                                      ),
                                    );
                                    snackBar.show(context);
                                    return;
                                  }
                                  Navigator.pushNamed(context, scanNFCOrQR);
                                },
                                child: buildCard(
                                  icon: Image.asset("assets/send.png",
                                      color: Colors.black),
                                  title: "Pay",
                                ),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  if (selectedWallet == 0) {
                                    new SnackBar(
                                      content: Text(
                                          'Select a wallet to withdraw from!'),
                                    ).show(context);
                                    return;
                                  }
                                  _bottomDrawerController.open();
                                },
                                child: buildCard(
                                  icon: Icon(
                                    Icons.vertical_align_bottom_outlined,
                                    color: Colors.black,
                                  ),
                                  title: "Withdraw",
                                ),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  if (locator<UserService>()
                                          .data!
                                          .wallets!
                                          .isEmpty ||
                                      locator<UserService>().data!.wallets ==
                                          null) {
                                    new SnackBar(
                                      content: Text(
                                        'You are not in any campaign',
                                      ),
                                    ).show(context);
                                    return;
                                  }
                                  Navigator.pushNamed(context, transferView,
                                      arguments: selectedWalletCampaignId);
                                },
                                child: buildCard(
                                  icon: RotatedBox(
                                    quarterTurns: 1,
                                    child: Icon(
                                      Icons.sync_alt_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  title: "Transfer",
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      BottomDrawer(
                        controller: _bottomDrawerController,
                        header: Container(),
                        body: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .54,
                          padding: EdgeInsets.symmetric(vertical: 30),
                          decoration: BoxDecoration(
                              color:
                                  ThemeBuilder.of(context)?.getCurrentTheme() ==
                                          Brightness.light
                                      ? Colors.white
                                      : primaryColorDarkMode,
                              border: Border.all(color: Constants.usedGreen),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40),
                              )),
                          child: CarouselSlider(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                              height: double.infinity,
                              initialPage: 0,
                              aspectRatio: 16 / 9,
                              enlargeCenterPage: true,
                              viewportFraction: 0.9,
                              autoPlay: false,
                              scrollDirection: Axis.horizontal,
                              scrollPhysics: NeverScrollableScrollPhysics(),
                            ),
                            items: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: CustomText(
                                          text: 'Withdrawal Confirmation',
                                          color: ThemeBuilder.of(context)
                                                      ?.getCurrentTheme() ==
                                                  Brightness.light
                                              ? Color.fromRGBO(37, 57, 111, 1)
                                              : Colors.white,
                                          fontSize: 22,
                                          fontFamily: 'Gilroy-bold',
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            // toggleVisibilty(); //Close Bottom Drawer code here
                                            _bottomDrawerController.close();
                                          },
                                          icon: Icon(
                                            Icons.close_rounded,
                                            color: ThemeBuilder.of(context)
                                                        ?.getCurrentTheme() ==
                                                    Brightness.light
                                                ? Color.fromRGBO(37, 57, 111, 1)
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 17),
                                  locator<UserService>().accounts != null
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                text:
                                                    'You are about to withdraw, please select account to withdraw to.',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 19,
                                                fontFamily: 'Gilroy-medium',
                                                textAlign: TextAlign.center,
                                                color: ThemeBuilder.of(context)
                                                            ?.getCurrentTheme() ==
                                                        Brightness.light
                                                    ? Color.fromRGBO(
                                                        37, 57, 111, 1)
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),

                                  // ListTile goes here
                                  SizedBox(height: 15),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: locator<UserService>()
                                                    .accounts !=
                                                null
                                            ? locator<UserService>()
                                                .accounts!
                                                .map<Widget>(
                                                  (account) => Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 5),
                                                    margin: EdgeInsets.only(
                                                        bottom: 14),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: ThemeBuilder.of(
                                                                          context)
                                                                      ?.getCurrentTheme() ==
                                                                  Brightness
                                                                      .light
                                                              ? Color.fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  1)
                                                              : Colors.white,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: ListTile(
                                                      dense: false,
                                                      leading: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              245, 246, 248, 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Image.asset(
                                                            "assets/bank.png",
                                                            width: 30,
                                                            height: 30,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      title: CustomText(
                                                        text: account.bankName!,
                                                        color: ThemeBuilder.of(
                                                                        context)
                                                                    ?.getCurrentTheme() ==
                                                                Brightness.light
                                                            ? Color.fromRGBO(
                                                                37, 57, 111, 1)
                                                            : Colors.white,
                                                      ),
                                                      subtitle: CustomText(
                                                        text: account
                                                            .accountNumber!,
                                                        color: ThemeBuilder.of(
                                                                        context)
                                                                    ?.getCurrentTheme() ==
                                                                Brightness.light
                                                            ? Color.fromRGBO(
                                                                37, 57, 111, 1)
                                                            : Colors.white,
                                                      ),
                                                      onTap: () {
                                                        // Set selected bank to the state
                                                        setState(() {
                                                          withdrawBank = {
                                                            'account_name':
                                                                account
                                                                    .bankName,
                                                            'account_number':
                                                                account
                                                                    .accountNumber,
                                                            'bank_code':
                                                                account.bankCode
                                                          };
                                                        });
                                                        // Move to next carousel and confirm withdraw request
                                                        _carouselController
                                                            .nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        400),
                                                                curve: Curves
                                                                    .easeIn);
                                                      },
                                                    ),
                                                  ),
                                                )
                                                .toList()
                                            : [
                                                CustomText(
                                                  text:
                                                      'You have not added any bank account',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 21,
                                                  fontFamily: 'Gilroy-medium',
                                                  textAlign: TextAlign.center,
                                                  color: ThemeBuilder.of(
                                                                  context)
                                                              ?.getCurrentTheme() ==
                                                          Brightness.light
                                                      ? Color.fromRGBO(
                                                          37, 57, 111, 1)
                                                      : Colors.white,
                                                ),
                                              ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Text(
                                          'Withdrawal Confirmation',
                                          style: TextStyle(
                                            color: ThemeBuilder.of(context)
                                                        ?.getCurrentTheme() ==
                                                    Brightness.light
                                                ? Color.fromRGBO(37, 57, 111, 1)
                                                : Colors.white,
                                            fontSize: 22,
                                            fontFamily: 'Gilroy-bold',
                                          ),
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            _bottomDrawerController
                                                .close(); //Close bottom drawer
                                            _carouselController.jumpToPage(0);
                                          },
                                          icon: Icon(
                                            Icons.close_rounded,
                                            color: ThemeBuilder.of(context)
                                                        ?.getCurrentTheme() ==
                                                    Brightness.light
                                                ? Color.fromRGBO(37, 57, 111, 1)
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  // Transaction confirmation goes here

                                  // ListTile goes here
                                  WithdrawAmountForm(
                                    selectedWallet: selectedWallet,
                                    withdrawBank: withdrawBank,
                                    withdrawAmountController:
                                        _withdrawAmountController,
                                    onWithdrawTapped: () async {
                                      var message = await locator<UserService>()
                                          .liquidateUserWallet(
                                              // locator<UserService>()
                                              //     .data
                                              //     ?.wallets?[
                                              //         selectedWallet! == 0
                                              //             ? selectedWallet!
                                              //             : selectedWallet! -
                                              //                 1]
                                              //     .balance
                                              //     ?.toStringAsFixed(0),
                                              _withdrawAmountController.text,
                                              withdrawBank,
                                              selectedWalletCampaignId);

                                      new SnackBar(content: Text(message))
                                          .show(context);
                                      // setState(() {
                                      //   withdrawLoading = false;
                                      // });
                                      _carouselController.jumpToPage(0);
                                      setState(() {
                                        withdrawBank = {};
                                        selectedWallet = 0;
                                      });
                                      print(
                                          {withdrawBank, "The selected bank"});
                                      _bottomDrawerController.close();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        headerHeight: 0,
                        drawerHeight: MediaQuery.of(context).size.height * .54,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCard({Widget? icon, String? title}) {
    return Card(
      child: Container(
        // height: 55,
        // width: 120,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            SizedBox(width: 5),
            Text(
              title!,
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

  String getWalletsBalance(List<Wallet>? wallets) {
    double? totalBalance = 0;
    for (var w in wallets!) {
      totalBalance = totalBalance! + w.balance!;
    }
    print({'totalBalance', totalBalance});
    return "\$$totalBalance.00";
  }

  BottomDrawerController _bottomDrawerController = BottomDrawerController();
  CarouselController _carouselController = new CarouselController();
}

class WithdrawAmountForm extends StatefulWidget {
  WithdrawAmountForm(
      {Key? key,
      this.selectedWallet,
      this.withdrawBank,
      this.withdrawAmountController,
      this.onWithdrawTapped})
      : super(key: key);
  int? selectedWallet;
  Map? withdrawBank;
  TextEditingController? withdrawAmountController;
  Function()? onWithdrawTapped;

  @override
  State<WithdrawAmountForm> createState() => _WithdrawAmountFormState();
}

class _WithdrawAmountFormState extends State<WithdrawAmountForm> {
  final GlobalKey<FormState> withdrawAmountFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: withdrawAmountFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: locator<UserService>().data!.wallets!.isNotEmpty
                  ? 'You\'re about to withdraw to ${widget.withdrawBank?['account_name']} with account number ${widget.withdrawBank?['account_number']}'
                  : '',
              // ${locator<UserService>().data!.wallets?[widget.selectedWallet! == 0 ? widget.selectedWallet! : widget.selectedWallet! - 1].localCurrency} ${widget.withdrawAmountController?.value.text}
              fontWeight: FontWeight.w400,
              fontSize: 21,
              fontFamily: 'Gilroy-medium',
              textAlign: TextAlign.center,
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Color.fromRGBO(37, 57, 111, 1)
                  : Colors.white,
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: widget.withdrawAmountController,
              label: CustomText(
                text: 'Amount to withdraw from wallet',
                fontFamily: 'Gilroy-medium',
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              validateFn: (val) {
                if (val == null)
                  return "A withdraw amount is required to proceed";
                else if (val.isEmpty)
                  return "Enter amount to withdraw";
                else if (double.parse(val) >
                    locator<UserService>()
                        .data!
                        .wallets![widget.selectedWallet! == 0
                            ? widget.selectedWallet!
                            : widget.selectedWallet! - 1]
                        .balance!) return "Insufficient wallet balance";
              },
            ),
            Spacer(),
            SizedBox(
              height: 52,
              child: CustomButton(
                onTap: () async {
                  if (withdrawAmountFormKey.currentState!.validate())
                    await widget.onWithdrawTapped!();
                },
                bgColor: Constants.usedGreen,
                loadColor: Colors.white,
                child: CustomText(
                  text: 'Confirm',
                  fontFamily: 'Gilroy-bold',
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  color: Colors.white,
                ),
                // mainAxisAlignment: withdrawLoading!
                //     ? MainAxisAlignment.end
                //     : MainAxisAlignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locator<UserService>().retrieveTransactions('monthly'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long),
                  CustomText(
                    text: 'There was an issue fetching transaction history',
                    color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontSize: 18,
                    edgeInset: EdgeInsets.all(20),
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    fontFamily: 'Gilroy-medium',
                  ),
                ],
              ),
            ),
          );
        }

        if (locator<UserService>().history?.transactions?.count == 0) {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long),
                  CustomText(
                    text:
                        'You\'ve not made any transaction(s) in the past week',
                    color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontSize: 18,
                    edgeInset: EdgeInsets.all(20),
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    fontFamily: 'Gilroy-medium',
                  ),
                ],
              ),
            ),
          );
        }
        if (locator<UserService>().history == null) {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long),
                  CustomText(
                    text:
                        'There was an issue fetching your transactions, check at a later time',
                    color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontSize: 18,
                    edgeInset: EdgeInsets.all(20),
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    fontFamily: 'Gilroy-medium',
                  ),
                ],
              ),
            ),
          );
        }

        return Expanded(
          child: ListView.separated(
            // reverse: true,
            itemBuilder: (context, int index) => buildDetails(new List.from(
                locator<UserService>()
                    .history!
                    .transactions!
                    .rows!
                    .reversed)[index]),
            separatorBuilder: (context, int index) => Divider(
              height: 20,
              thickness: 1,
            ),
            itemCount:
                locator<UserService>().history!.transactions!.rows!.length > 10
                    ? 10
                    : locator<UserService>()
                        .history!
                        .transactions!
                        .rows!
                        .length,
          ),
        );
      },
    );
  }

  Widget buildDetails(Map? item) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ListTile(
        isThreeLine: true,
        leading: Container(
          decoration: BoxDecoration(
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Color.fromARGB(81, 57, 57, 57)
                  : Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              )),
          height: 62,
          width: 62,
          child: Center(
            child: Text(
              "C",
              style: TextStyle(
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.white
                    : Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 11,
              fontFamily: "Gilroy-medium",
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            text: 'Ref: ${item?["reference"]}\n',
            children: [
              TextSpan(
                text: "${item?['narration']}",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Gilroy-bold",
                  color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              )
            ],
          ),
        ),
        trailing: Text(
          "\#${item?['amount']}",
          style: TextStyle(
            color: item?['transaction_type'] != 'credit'
                ? Color(0xffc20000)
                : Colors.greenAccent.shade400,
            fontFamily: "Gilroy-medium",
          ),
        ),
        subtitle: Text(
          "${DateTime.parse(item?['createdAt']).toString().substring(0, 11)}",
          style: TextStyle(
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Color(0xff333333)
                    : Colors.white,
            fontSize: 13,
            fontFamily: "Gilroy-medium",
          ),
        ),
      ),
    );
  }
}
