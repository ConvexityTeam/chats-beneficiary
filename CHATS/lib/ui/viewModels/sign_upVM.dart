import 'dart:convert';
// import 'dart:io';

import 'package:CHATS/core/providerModels/base_provider_model.dart';
import 'package:CHATS/core/services/authentication_service.dart';
import 'package:CHATS/ui/shared/ui_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:CHATS/core/models/user_model.dart';

class SignUpVM extends BaseProviderModel {
  List<String> imageList = [
    'assets/onboard1.png',
    'assets/onboard2.png',
    'assets/onboard3.png'
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

  login(String email, String password, BuildContext context) async {
    if (isBusy) return;
    errorMessage = '';
    isBusy = true;
    notifyListeners();
    await _authenticationService.login(email, password).then((value) {
      // Sends user to homepage if credentials are correct
      if (value['code'] == 200) {
        Navigator.pushReplacementNamed(context, '/');
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

  register(UserModel model, BuildContext context) async {
    // model.profile_pic = profilePicture;
    print(jsonEncode(model.toJson()));
    savingUser = true;
    signUpErrorMessage = '';
    notifyListeners();
    await _authenticationService.register(model).then((value) {
      if (value['code'] == 201) {
        Navigator.pushReplacementNamed(context, '/');
      } else {
        signUpErrorMessage = value['message'];
      }
    }).catchError((e) {
      print(e);
      print("ss");
    });
    savingUser = false;
    notifyListeners();
  }

  bool isBusy = false;
  bool savingUser = false;
  String errorMessage = '';
  String signUpErrorMessage = '';

  AuthenticationService _authenticationService = new AuthenticationService();

  String profilePicture;

  String validId;
}
