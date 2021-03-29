import 'package:CHATS/providers/base_provider_model.dart';
import 'package:CHATS/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import '../../../domain/locator.dart';

class SplashScreenViewModel extends BaseProviderModel {
  final keyStore = locator<SharedPref>();
// setViewState(ViewState.IDLE);
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
}
