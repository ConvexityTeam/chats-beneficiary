import 'dart:convert';
import 'dart:io';
import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/domain/user_service.dart';
import 'package:CHATS/models/api.dart';
import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:CHATS/services/base_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AuthenticationService extends BaseService {
  Future<void> register(BeneficiaryUser userObj, File profilePic) async {
    try {
      if (kDebugMode) {
        print({
          "REGISTERING USER with endpoint '$authUrl/self-registration'",
          userObj,
          'User Object'
        });
      }
      var profilePicBytes = await profilePic.readAsBytes();
      var formData = FormData.fromMap({
        ...userObj.toJson(),
        'profile_pic': MultipartFile.fromBytes(
          profilePicBytes,
          filename: '${userObj.firstName + userObj.lastName}.jpg',
          contentType: new MediaType("image", "jpeg"), //add this
        ),
      });
      // DEBUG REQUEST

      Response registrationResponse = await Dio().post(
        '$authUrl/self-registration',
        data: formData,
      );

      if (kDebugMode)
        print('Tried to register user ... \n${registrationResponse.data}');
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw e;
        print(e.message);
      }
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await Dio()
          .post("$authUrl/login", data: {'email': email, 'password': password});

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO LOGIN",
          response.data['data']['token']
        });
      String token = response.data['data']['token'];
      if (kDebugMode) {
        print({response.data.keys, 'This API response keys!'});
        print({token, 'This is the users API token!'});
      }
      locator<UserService>().token = token;
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw e;
        print(e.request);
        print(e.message);
      }
    }
  }

  String authUrl = BaseService.rootApi + '/auth';
}
