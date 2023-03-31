import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/services/base_service.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

class TransactionAPI extends BaseService {
  String _transcationsURL = BaseService.rootApi + '/beneficiaries/chart';
  Future<Map> recentTransactions(String? period) async {
    try {
      final response =
          await Dio().get("$_transcationsURL/${period != null ? period : ''}",
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
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        // print(e.response.request);
        return {"status": "failded", "message": e.response!.data};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.request);
        print(e.message);
        return {"status": "failed", "message": e.message};
      }
    }
  }

  Future allTransactions(String? period) async {
    try {
      final response =
          await Dio().get('$_transcationsURL/${period != null ? period : ''}',
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
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        // print(e.response.request);
        return {"status": "failed", "message": e.message};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.request);
        print(e.message);
        return {"status": "failed", "message": e.message};
      }
    }
  }

  checkout(String? reference, String? pin, String? walletId,
      String? campaignWalletId) async {
    String _checkoutURL = BaseService.rootApi +
        '/orders/$reference/pay/$walletId/$campaignWalletId';

    try {
      final response = await Dio().post(
        "$_checkoutURL",
        data: {
          "pin": pin,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... FOR USER pending order",
          response,
          response.data.keys
        });
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return e.response!.data;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message};
      }
    }
  }

  getOrder(String? reference) async {
    String _getOrderURL = BaseService.rootApi + '/orders/$reference';

    try {
      final response = await Dio().get(
        "$_getOrderURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO get order",
        });
      return response.data['data'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "error", "message": e.response!.statusMessage};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "error"};
      }
    }
  }

  liquidateFunds(String? amount, Map? bankDetails, campaignId) async {
    String _liquidateURL = BaseService.rootApi +
        '/users/account/$amount/withdraw/${bankDetails?['account_number']}/$campaignId';

    try {
      final response = await Dio().post(
        "$_liquidateURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST .... TO LIQUIDATE BENEFICIARY WALLET",
        });
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "error", "message": e.response!.statusMessage};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "error"};
      }
    }
  }

  transferFunds({
    String fromWallet = 'personal',
    required String username,
    required String pin,
    required double amount,
    String? campaignId,
  }) async {
    String _transferURL =
        BaseService.rootApi + '/beneficiaries/transfer/beneficiary';

    try {
      final response = await Dio().post(
        "$_transferURL",
        data: fromWallet == 'personal'
            ? {
                "from_wallet": fromWallet,
                "username": username,
                "pin": pin,
                "amount": amount.toString(),
              }
            : {
                "from_wallet": fromWallet,
                "username": username,
                "pin": pin,
                "amount": amount.toString(),
                "campaignId": campaignId
              },
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST .... TO TRANSFER FUNDS BETWEEN BENEFICIARIES",
        });
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "error", "message": e.response!.data['message']};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "error"};
      }
    }
  }
}
