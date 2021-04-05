import 'dart:convert';
import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:CHATS/services/base_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TransactionAPI extends BaseService {
  Future<List> recentTransactions() async {
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
      print(e);
      throw 'There was an error with our system trying to retrieve transactions';
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

  String _transcationsURL =
      BaseService.rootApi + '/users/recent_transactions/7';
  // String _bearerToken =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJPcmdhbmlzYXRpb25JZCI6NCwiUm9sZUlkIjozLCJpYXQiOjE2MTM5ODY0ODEsImV4cCI6MTYxNDA3Mjg4MX0.q604urZGWhPArBg6SeorKfQ-5aW_s8Q8FFITluSM1KA';
}
