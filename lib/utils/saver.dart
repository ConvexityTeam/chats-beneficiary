import 'dart:convert';
import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Saver {
  static String token;
  static BeneficiaryUser user;
  static bool isNewlyInstalled = true;

  static saveToken(String token) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("token", token);
      token = pref.getString("token");
    } catch (e) {
      print(e);
    }
  }

  static saveUser(var model) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("user", jsonEncode(model).toString());
      // user = UserModel.fromJson(jsonDecode(pref.getString("user")));
    } catch (e) {
      print(e);
    }
  }
}
