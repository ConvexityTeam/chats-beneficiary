// import 'dart:convert';
import 'dart:io';

import 'package:CHATS/domain/locator.dart';
// import 'package:CHATS/models/api.dart';
import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:CHATS/services/base_service.dart';
import 'package:CHATS/services/local_storage_service.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AuthenticationService extends BaseService {
  Future<Map<String, dynamic>> register(
      BeneficiaryUser? userObj, File? profilePic, String identifier) async {
    String registerURL = '${BaseService.rootApi}/auth/self-registration';
    try {
      if (kDebugMode) {
        print({
          "REGISTERING USER with endpoint '$registerURL'",
          userObj?.email,
          userObj?.phone,
          userObj?.location,
          userObj?.password,
          profilePic?.toString(),
          'User Object'
        });
      }
      var profilePicBytes = await profilePic!.readAsBytes();
      var formData = FormData.fromMap({
        ...userObj!.toJson(),
        'device_imei': identifier,
        'profile_pic': MultipartFile.fromBytes(
          profilePicBytes,
          filename: '${userObj.email! + userObj.phone!}.jpg',
          contentType: new MediaType("image", "jpeg"), //add this
        ),
      });
      // DEBUG REQUEST

      Response registrationResponse = await Dio().post(
        '$registerURL',
        data: formData,
      );

      if (kDebugMode)
        print('Tried to register user ... \n${registrationResponse.data}');
      return registrationResponse.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        // print(e.response.request);
        ((DioError e) {
          print("Error data keys: ${e.response?.data.keys}");
        })(e);
        return {"error": true, ...e.response?.data};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);
        print(e.stackTrace);
        return {"error": true, "message": e.message};
      }
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final keyStore = locator<SharedPref>();
      final response = await Dio().post("$authUrl/beneficiary-login",
          data: {'email': email, 'password': password});

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO LOGIN",
          response.data['data']['token']
        });
      String token = response.data['data']['token'];
      String userID = response.data['data']['user']['id'].toString();
      String pin = response.data['data']['user']['pin'];
      if (kDebugMode) {
        print({response.data.keys, 'This API response keys!'});
        print({token, 'This is the users API token!'});
      }
      locator<UserService>().token = token;
      keyStore.saveToDisk('localUserToken', token);
      locator<UserService>().id = userID;
      keyStore.saveToDisk('localUserID', userID);
      locator<UserService>().pin = pin;
      keyStore.saveToDisk('userPinSet', pin);

      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        // print(e.response.request);
        return e.response!.data;
        // throw e;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.request);
        print(e.message);
        return {"message": e.message};
      }
    }
  }

  String authUrl = BaseService.rootApi + '/auth';
}
