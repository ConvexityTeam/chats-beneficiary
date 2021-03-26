import 'package:shared_preferences/shared_preferences.dart';

import 'general_base_provider_model.dart';

class GSharedPref extends GBaseProviderModel {
  GSharedPref() {
    setupShared();
    getUserOption();
  }
  Future<SharedPreferences> pref;

  static const selected_option = 'selected_option';

  setupShared() {
    pref = SharedPreferences.getInstance();
    notifyListeners();
  }

  Future<String> myOption;

  getUserOption() {
    myOption = pref.then((value) {
      return value.getString(selected_option) ?? 'non';
    });
  }

  setUserOption(String content) async {
    final SharedPreferences preferences = await pref;
    preferences.setString(selected_option, content);
    // myOption = preferences.setString(selected_option, content).then((value) {
    //   print(content);
    //   return content;
    // });
    notifyListeners();
  }

  // void _saveToDisk<T>(String key, T coFntent) {
  //   if (content is String) {
  //     _pref?.setString(key, content);
  //   }
  //   if (content is bool) {
  //     _pref.setBool(key, content);
  //   }
  //   if (content is int) {
  //     _pref?.setInt(key, content);
  //   }
  //   if (content is double) {
  //     _pref?.setDouble(key, content);
  //   }
  // }
}
