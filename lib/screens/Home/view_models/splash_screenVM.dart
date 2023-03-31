import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/providers/base_provider_model.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/services/local_storage_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:flutter/material.dart';

class SplashScreenViewModel extends BaseProviderModel {
  final keyStore = locator<SharedPref>();
// (ViewState.IDLE);
  Future startUp(BuildContext context) async {
    var result = await keyStore.getFromDisk('isDarkModeEnabled');
    if (result != null)
      ThemeBuilder.of(context)!.changeTheme(result);
    else
      print("Value has not been set yet");
    if (await keyStore.myFirst!) {
      print(keyStore.myFirst);
      await Future.delayed(Duration(seconds: 5));
      keyStore.setIsFirstTime(false);
      Navigator.pushNamedAndRemoveUntil(
          context, onboard, (Route<dynamic> route) => false);
    } else {
      await Future.delayed(Duration(seconds: 5));
      Navigator.pushNamedAndRemoveUntil(
          context, login, (Route<dynamic> route) => false);
      // await Future.delayed(Duration(seconds: 2));
      // Navigator.pushNamed(context, home);
    }
  }
}
