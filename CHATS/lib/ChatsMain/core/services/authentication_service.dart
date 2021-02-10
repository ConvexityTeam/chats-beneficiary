import 'dart:convert';
import 'package:CHATS/ChatsMain/core/models/beneficiary_user_model.dart';
import 'package:CHATS/ChatsMain/core/services/base_service.dart';
import 'package:http/http.dart' as http;

class AuthenticationService extends BaseService {
  Future<Map<String, dynamic>> register(BeneficiaryUserModel userObj) async {
    try {
      final response = await http.post("$authUrl/register",
          body: jsonEncode(userObj.toJson()), headers: header);

      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post("${authUrl}/login",
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