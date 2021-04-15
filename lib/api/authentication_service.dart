import 'dart:convert';
import 'dart:io';
import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:CHATS/services/base_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AuthenticationService extends BaseService {
  Future<Map<String, String>> register(
      BeneficiaryUser userObj, File profilePic) async {
    try {
      var profilePicBytes = await profilePic.readAsBytes();
      var formData = FormData.fromMap({
        ...userObj.toJson(),
        'profile_pic': MultipartFile.fromBytes(
          profilePicBytes,
          filename: 'test.jpg',
          contentType: new MediaType("image", "jpeg"), //add this
        ),
      });
      // DEBUG REQUEST
      if (kDebugMode) {
        print({
          "REGISTERING USER with endpoint '$authUrl/self-registration'",
          userObj.toJson(),
          'User Object'
        });
      }

      Response registrationResponse = await Dio().post(
        '$authUrl/self-registration',
        data: formData,
      );

      if (kDebugMode)
        print('Tried to register user ... \n${registrationResponse.data}');

      // Log user in
      Map<String, dynamic> response =
          await this.login(userObj.email, userObj.password);

      return response;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post("$authUrl/login",
          body: jsonEncode({"email": email, "password": password}),
          headers: header);

      print(jsonDecode(response.body));
      return jsonDecode(response.body)['token'];
    } catch (e) {
      return e;
    }
  }

  String authUrl = BaseService.rootApi + '/auth';
}
