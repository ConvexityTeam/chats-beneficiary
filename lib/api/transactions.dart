import 'dart:convert';
import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/services/base_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TransactionAPI extends BaseService {
  String _transcationsURL =
      BaseService.rootApi + '/users/recent_transactions/7';
  Future<List> recentTransactions() async {
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

  Future<List> allTransactions() async {
    try {
      final response = await http.get("$_transcationsURL", headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $_bearerToken',
      });

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... FOR RECENT TRANSACTIONS",
          jsonDecode(response.body)
        });
      return jsonDecode(response.body);
    } catch (e) {
      throw 'There was an error with our system trying to retrieve transactions';
    }
  }
}
