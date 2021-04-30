import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/models/wallet.dart';
import 'package:CHATS/services/base_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UserAPI {
  String _userURL =
      BaseService.rootApi + '/beneficiaries/user/${locator<UserService>().id}';

  getUserDetailsAndWallet() async {
    try {
      final response = await Dio().get("$_userURL",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          }));

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... FOR Details and Wallet",
          Wallet.fromJson(response.data['data']['user'])
        });
      return response.data['data']['user'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        print(e.response.statusMessage);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw e;
        print(e.request);
        print(e.message);
      }
    }
  }
}
