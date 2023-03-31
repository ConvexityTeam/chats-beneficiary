import 'package:shared_preferences/shared_preferences.dart';

import '../providers/general_base_provider_model.dart';

class GSharedPref extends GBaseProviderModel {
  GSharedPref() {
    setupShared();
    getUserOption();
  }
  Future<SharedPreferences>? pref;

  static const selected_option = 'selected_option';

  setupShared() {
    pref = SharedPreferences.getInstance();
    notifyListeners();
  }

  Future<String>? myOption;

  getUserOption() {
    myOption = pref!.then((value) {
      return value.getString(selected_option) ?? 'non';
    });
  }

  setUserOption(String content) async {
    final SharedPreferences preferences = await pref!;
    preferences.setString(selected_option, content);
    // myOption = preferences.setString(selected_option, content).then((value) {
    //   print(content);
    //   return content;
    // });
    notifyListeners();
  }
}
