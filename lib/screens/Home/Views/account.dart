import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/models/account_model.dart';
import 'package:CHATS/models/bank_list.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS/widgets/error_widget_handler.dart';
import 'package:flutter/material.dart';
import 'package:snack/snack.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late PageController _pageController;
  late TextEditingController _accNumberController;
  late TextEditingController _bankNameController;

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: pageIndex);
    _accNumberController = TextEditingController(text: '');
    _bankNameController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        title: CustomText(
          text: 'Account',
          fontFamily: 'Gilroy-medium',
          fontSize: 22,
          edgeInset: EdgeInsets.zero,
          textAlign: TextAlign.left,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: locator<UserService>().getBankAccounts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return ErrorWidgetHandler(
              onTap: () {
                setState(() {});
              },
            );
          }

          return PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              locator<UserService>().accounts!.isEmpty
                  ? noAccountScreen()
                  : buildBankCards(locator<UserService>().accounts, context),
              buildNewBankCard(context),
            ],
          );
        },
      ),
    );
  }

  Widget noAccountScreen() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, right: 20, top: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 90,
            backgroundColor: Color.fromRGBO(47, 185, 249, .09),
            child: Icon(
              Icons.house_siding_rounded,
              color: Color.fromRGBO(23, 206, 137, 1),
              size: 65,
            ),
          ),
          SizedBox(height: 40),
          CustomText(
            text:
                'No banks added. Add a new bank to withdraw to your local bank account',
            fontFamily: 'Gilroy-regular',
            fontSize: 20,
            textAlign: TextAlign.center,
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          SizedBox(height: 40),
          SizedBox(
            height: 52,
            child: CustomButton(
              margin: EdgeInsets.zero,
              children: [
                CustomText(
                  text: 'Add A New Bank',
                  color: Colors.white,
                  edgeInset: EdgeInsets.zero,
                  fontFamily: 'Gilroy-bold',
                )
              ],
              onTap: () {
                // setState(() {
                //   pageIndex = 1;
                _pageController.animateToPage(
                  1,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
                // });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildBankCards(List<AccountModel>? cards, context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: buildCard(cards, context),
            ),
          ),
          SizedBox(height: 40),
          CustomButton(
            height: 52,
            margin: EdgeInsets.zero,
            children: [
              CustomText(
                text: 'Add A New Bank',
                color: Colors.white,
                edgeInset: EdgeInsets.zero,
                fontFamily: 'Gilroy-bold',
              )
            ],
            onTap: () {
              // setState(() {
              //   pageIndex = 1;
              _pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              );
              // });
            },
          ),
        ],
      ),
    );
  }

  List<Container> buildCard(List<AccountModel>? cards, context) {
    return cards!
        .map((item) => Container(
              width: MediaQuery.of(context).size.width * .7,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(122, 128, 155, .1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color.fromRGBO(100, 106, 134, 1),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                      text: '${item.accountName}',
                      fontFamily: 'Gilroy-bold',
                      color: Color.fromRGBO(100, 106, 134, 1)),
                  SizedBox(height: 8),
                  CustomText(
                      text: '${item.bankName}',
                      color: Color.fromRGBO(124, 141, 181, 1)),
                  SizedBox(height: 12),
                  CustomText(
                      text: '${item.accountNumber}',
                      fontSize: 21,
                      color: Color.fromRGBO(124, 141, 181, 1)),
                ],
              ),
            ))
        .toList();
  }

  Widget buildNewBankCard(context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextField(
            controller: _accNumberController,
            label: CustomText(
              text: 'Account Number',
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            hintText: 'Enter account number',
          ),
          BankListDropDown(
            onChange: (newValue) {
              _bankNameController.text = newValue!;
            },
          ),

          // CustomTextField(
          //   controller: _bankNameController,
          //   label: CustomText(
          //     text: 'Bank Name',
          //     color: ThemeBuilder.of(context)!.getCurrentTheme() ==
          //             Brightness.light
          //         ? Colors.black
          //         : Colors.white,
          //   ),
          //   hintText: 'Enter bank name',
          // ),
          SizedBox(height: 20),
          SizedBox(
            height: 52,
            child: CustomButton(
              margin: EdgeInsets.zero,
              child: CustomText(
                text: 'Add Bank',
                color: Colors.white,
                edgeInset: EdgeInsets.zero,
                fontFamily: 'Gilroy-bold',
              ),
              onTap: () async {
                if (_accNumberController.text != '' &&
                    _bankNameController.text != '') {
                  String? result =
                      await locator<UserService>().addBankAccount(AccountModel(
                    accountNumber: _accNumberController.text,
                    bankCode: _bankNameController.text,
                  ));
                  var snackBar = SnackBar(content: Text(result ?? ''));
                  snackBar.show(context);
                }
                _accNumberController.clear();
                _bankNameController.clear();

                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _accNumberController.dispose();
    _bankNameController.dispose();
  }
}

class BankListDropDown extends StatefulWidget {
  const BankListDropDown({Key? key, this.onChange}) : super(key: key);

  final Function(String?)? onChange;

  @override
  State<BankListDropDown> createState() => _BankListDropDownState();
}

class _BankListDropDownState extends State<BankListDropDown> {
  String? _bankVal = '058';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          text: 'Bank Name',
          textAlign: TextAlign.left,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
      ),
      SizedBox(height: 10),
      SizedBox(
        width: double.infinity,
        height: 52,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton<String>(
            value: _bankVal,
            icon: const Icon(Icons.arrow_downward),
            iconEnabledColor: Constants.usedGreen,
            iconSize: 24,
            elevation: 8,
            isExpanded: true,
            hint: CustomText(
              text: 'Pick bank',
              fontFamily: 'Gilroy-medium',
              color: Constants.usedGreen,
              edgeInset: EdgeInsets.zero,
            ),
            style: const TextStyle(color: Constants.usedGreen),
            // underline: Container(
            //   height: 2,
            //   color: Colors.green,
            // ),
            onChanged: (String? newValue) {
              print(newValue);
              setState(() {
                _bankVal = newValue!;
              });
              widget.onChange!(newValue);
            },
            items: locator<UserService>()
                .banks
                ?.map<DropdownMenuItem<String>>((BankList value) {
              return DropdownMenuItem<String>(
                value: value.code,
                child: Text(value.name!),
              );
            }).toList(),
          ),
        ),
      ),
    ]);
  }
}


// Container(
//                   width: 130,
//                   height: 130,
//                   margin: EdgeInsets.only(right: 20),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Constants.usedGreen)),
//                   child: InkWell(
//                     onTap: () {},
//                     highlightColor: Colors.transparent,
//                     splashColor: Constants.usedGreen.withOpacity(.4),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.add_circle_rounded,
//                           color: Constants.usedGreen,
//                           size: 32,
//                         ),
//                         SizedBox(height: 10),
//                         CustomText(
//                           text: 'Add New',
//                           fontFamily: 'Gilroy-medium',
//                           color: Constants.usedGreen,
//                           edgeInset: EdgeInsets.zero,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),