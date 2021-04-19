import 'package:CHATS/api/user_api.dart';
import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:flutter/foundation.dart';

class UserService extends ChangeNotifier {
  String token;
  String id;
  String profilePic;
  BeneficiaryUser _data;
  BeneficiaryUser get data {
    return _data;
  }

  Future<void> setUserData() async {
    Map<String, dynamic> detailsResponse =
        await UserAPI().getUserDetailsAndWallet();
    _data = BeneficiaryUser.fromJson(detailsResponse);
    if (kDebugMode) print('Setting user data... $detailsResponse');
  }

  retrieveNotifications() {}
}
