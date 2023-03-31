// import 'dart:convert';
import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/services/base_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

class NotificationAPI extends BaseService {
  Future<List?>? recentTransactions() async {
    try {
      final response = await Dio().get("$_transcationsURL",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          }));

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... FOR RECENT TRANSACTIONS",
          response.data
        });
      return response.data['data'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        // print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.request);
        print(e.message);
        throw e;
      }
    }
  }

  String _transcationsURL =
      BaseService.rootApi + '/users/recent_transactions/7';
  // String _bearerToken =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJPcmdhbmlzYXRpb25JZCI6NCwiUm9sZUlkIjozLCJpYXQiOjE2MTM5ODY0ODEsImV4cCI6MTYxNDA3Mjg4MX0.q604urZGWhPArBg6SeorKfQ-5aW_s8Q8FFITluSM1KA';
}
