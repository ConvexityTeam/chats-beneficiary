import 'package:CHATS/ChatsMain/ui/screen/splashscreen.dart';
import 'package:CHATS/screens/descision_page.dart';
import 'package:CHATS/providers/general_base_provider_model.dart';
import 'package:flutter/material.dart';

import 'Vendor/main.dart';
import 'domain/general_locator.dart';
import 'domain/general_sharedPref.dart';

class GSplashScreenViewModel extends GBaseProviderModel {
  final keyStore = newLocator<GSharedPref>();
// setViewState(ViewState.IDLE);
  Future startUp(BuildContext context) async {
    if (await keyStore.myOption == 'non') {
      // print(await keyStore.myOption == 'non');
      await Future.delayed(Duration(seconds: 4));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DescisionPage()));
    } else if (await keyStore.myOption == 'beneficiaries') {
      await Future.delayed(Duration(seconds: 4));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SplashScreen()));
      // await Future.delayed(Duration(seconds: 2));
      // Navigator.pushNamed(context, home);
    } else if (await keyStore.myOption == 'vendor') {
      await Future.delayed(Duration(seconds: 4));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => VendorApp()));
      // await Future.delayed(Duration(seconds: 2));
      // Navigator.pushNamed(context, home);
    }
  }
}
