import 'dart:convert';
import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:CHATS/services/base_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthenticationService extends BaseService {
  Future<Map<String, dynamic>> register(BeneficiaryUser userObj) async {
    try {
      // Register User
      await http.post("$authUrl/register",
          body: userObj.toJson(), headers: header);
      if (kDebugMode) {
        print({"REGISTERING USER", userObj.toJson(), 'User Object'});
      }
      // Log user in
      final response = await this.login(userObj.email, userObj.password);
      // return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post("$authUrl/login",
          body: jsonEncode({"email": email, "password": password}),
          headers: header);

      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } catch (e) {
      return e;
    }
  }

  String authUrl = BaseService.rootApi + '/auth';
}
