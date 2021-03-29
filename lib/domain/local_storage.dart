import 'dart:convert';

import 'package:CHATS/models/user_type.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // ignore: unused_field
  SharedPreferences _sharePreference;
  // UserType _userType;
  // UserType get userType => _userType;

  Future saveUser(String user) async {
    _sharePreference = await SharedPreferences.getInstance();
    await _sharePreference.setString("userType", user);
  }

  Future<String> checkUserType() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String user = prefs.getString("userType");
      if (user == userType[UserType.Non] || !prefs.containsKey("userType")) {
        return userType[UserType.Non];
      } else if (user == userType[UserType.Non_Vendor]) {
        return userType[UserType.Non_Vendor];
      } else if (user == userType[UserType.Vendor]) {
        return userType[UserType.Vendor];
      } else {
        return userType[UserType.Non];
      }
    } catch (e) {
      return userType[UserType.Non];
    }
  }
}
