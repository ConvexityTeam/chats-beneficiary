import 'dart:io';

import 'package:CHATS/api/authentication_service.dart';
import 'package:CHATS/domain/locator.dart';
// import 'dart:io';
import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:CHATS/providers/base_provider_model.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/services/local_auth_service.dart';
import 'package:CHATS/services/local_storage_service.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snack/snack.dart';
import 'package:unique_identifier/unique_identifier.dart';

class SignUpVM extends BaseProviderModel {
  bool get loading {
    return _loading;
  }

  bool _loading = false;

  toggleLoader() {
    _loading = !_loading;
    notifyListeners();
  }

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
              child: Text(
                  'Disbursed cash voucher token to beneficiaries\n is safe and secured using the Blockchain'))
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

  Future<bool?> shouldAuthenticate(BuildContext context) async {
    isFPEnabled = await keyStore.getFromDisk(isFPEnabledKey);
    if (isFPEnabled != null && isFPEnabled!) {
      var snackBar = SnackBar(
        content: Text(
          'Touch ID is required to continue using the app. Scan fingerprint to unlock',
        ),
      );
      snackBar.show(context);
      bool? service = await LocalAuthService().authenticate();
      if (service) {
        // setup data push to home screen
        locator<UserService>().token =
            await keyStore.getFromDisk('localUserToken');
        locator<UserService>().id = await keyStore.getFromDisk('localUserID');
        locator<UserService>().pin = await keyStore.getFromDisk('userPinSet');
        Navigator.pushNamed(context, home);
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  login(String email, String password, BuildContext context) async {
    if (isBusy) return;
    errorMessage = '';
    isBusy = true;
    notifyListeners();
    await _authenticationService.login(email, password).then((value) {
      // Sends user to homepage if credentials are correct
      print({value, 'value'});
      if (value['code'] == 200) {
        Navigator.pushReplacementNamed(context, home);
      } else {
        errorMessage = value['message'];
        print(value['message'].runtimeType);
      }
    }).catchError((e) {
      print(e);
    });
    isBusy = false;
    notifyListeners();
  }

  BeneficiaryUser? user;
  Future<String?> register(BuildContext context) async {
    savingUser = true;
    signUpErrorMessage = '';
    registerErrorMessage = '';
    notifyListeners();
    try {
      var deviceInfo = DeviceInfoPlugin();
      String? identifier = await UniqueIdentifier.serial;
      AndroidDeviceInfo deviceId = await deviceInfo.androidInfo;
      identifier = '${deviceId.model}:${deviceId.id}';
      print({"Device ID", identifier});

      await AuthenticationService()
          .register(user!, this.profilePicture!, identifier)
          .then((value) async {
        print({value, 'value'});
        if (value['status'] == 'success' ||
            value['code'] == 201 ||
            value['code'] == 200) {
          await AuthenticationService().login(user!.email!, user!.password!);
          Navigator.pushReplacementNamed(context, home);
        } else {
          print({value['message'], "Error message"});
          // if (value['message']['message'] != null) {
          //   for (final entry in value['message']['message']['errors'].entries) {
          //     final key = entry.key;
          //     final err = entry.value;

          //     registerErrorMessage += err[0] + '\n';

          //     print('Key: $key, Value: $err');
          //   }
          // } else {
          registerErrorMessage = value['message'];
          // }
          print(registerErrorMessage);
          print({value['code'], value['message']});
        }
      }).catchError((e) {
        print(e);
      });
    } catch (err) {
      print(err);
      print("ss");
    }

    savingUser = false;
    notifyListeners();
  }

  bool isBusy = false;
  bool savingUser = false;
  bool otpVerified = false;
  String errorMessage = '';
  String registerErrorMessage = '';
  String signUpErrorMessage = '';
  final isFPEnabledKey = 'isFingerprintEnabled';
  bool? isFPEnabled = false;

  AuthenticationService _authenticationService = new AuthenticationService();

  File? profilePicture;

  String? validId;
}
