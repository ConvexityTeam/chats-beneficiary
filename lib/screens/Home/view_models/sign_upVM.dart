import 'dart:convert';
import 'dart:io';
// import 'dart:io';
import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:CHATS/providers/base_provider_model.dart';
import 'package:CHATS/api/authentication_service.dart';
import 'package:CHATS/services/local_storage_service.dart';
import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:flutter/widgets.dart';

class SignUpVM extends BaseProviderModel {
  List<String> imageList = [
    'assets/onboard2.jpeg',
    'assets/onboard3.jpeg',
    'assets/onboard1.jpeg'
  ];

  List<Widget> scrollText = [
    Container(
      height: 400,
      child: Column(
        children: [
          Container(
            height: 20,
            child: Text(
              'Simple  And Easy',
              style: Constants.kboldTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 20,
              child: Text('Easy and Straightforward onboarding\n process'))
        ],
      ),
    ),
    Container(
      height: 400,
      child: Column(
        children: [
          Container(
            height: 20,
            child: Text(
              'Safe  And Secure',
              style: Constants.kboldTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            child: Text(
                'Convexity is safe  and secured to set up \n \t encrypted security using blockchain'),
          )
        ],
      ),
    ),
    Container(
      height: 400,
      child: Column(
        children: [
          Container(
            height: 20,
            child: Text(
              'Pay Money Instantly',
              style: Constants.kboldTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 50,
              child: Text(
                  'Transfer instantly between vendors and \n \t\t\t                   beneficiaries'))
        ],
      ),
    ),
  ];

  final keyStore = locator<SharedPref>();

  Future startUp(BuildContext context) async {
    if (await keyStore.myFirst ?? true) {
      print(keyStore.myFirst);
      await Future.delayed(Duration(seconds: 4));
      keyStore.setIsFirstTime(false);
      Navigator.pushNamed(context, 'onboard');
    } else {
      await Future.delayed(Duration(seconds: 4));
      Navigator.pushNamed(context, 'login');
      // await Future.delayed(Duration(seconds: 2));
      // Navigator.pushNamed(context, home);
    }
  }

  login(String email, String password, BuildContext context) async {
    if (isBusy) return;
    errorMessage = '';
    isBusy = true;
    notifyListeners();
    await _authenticationService.login(email, password).then((value) {
      // Sends user to homepage if credentials are correct
      if (value['code'] == 200) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        errorMessage = value['message'];
        print(value['code']);
      }
    }).catchError((e) {
      print(e);
    });
    isBusy = false;
    notifyListeners();
  }

  BeneficiaryUser user;
  register(BuildContext context) async {
    savingUser = true;
    signUpErrorMessage = '';
    notifyListeners();
    try {
      Map<String, dynamic> value =
          await AuthenticationService().register(user, this.profilePicture);

      // if (value['code'] == 201) {
      //   Navigator.pushReplacementNamed(context, '/home');
      // } else {
      //   signUpErrorMessage = value['message'];
      // }
    } catch (err) {
      print(err);
      print("ss");
    }

    savingUser = false;
    notifyListeners();
  }

  bool isBusy = false;
  bool savingUser = false;
  String errorMessage = '';
  String signUpErrorMessage = '';

  AuthenticationService _authenticationService = new AuthenticationService();

  File profilePicture;

  String validId;
}
