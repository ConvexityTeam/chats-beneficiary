import 'dart:io';

import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/models/account_model.dart';
import 'package:CHATS/models/user_details_model.dart';
import 'package:CHATS/services/base_service.dart';
import 'package:CHATS/services/user_service.dart';
// import 'package:analyzer/file_system/file_system.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

class UserAPI {
  getUserDetailsAndWallet() async {
    String _userURL = BaseService.rootApi + '/beneficiaries/profile';
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
          response.data['data']['Wallets'],
          response.data['data']['associatedCampaigns'],
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
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        throw e;
      }
    }
  }

  getUserDetails() async {
    String _userURL = BaseService.rootApi +
        '/beneficiaries/user-details/${locator<UserService>().id}';

    try {
      final response = await Dio().get("$_userURL",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          }));

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... FOR USER Details",
        });
      return response.data['data']['user'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        throw e;
      }
    }
  }

  updateUsersTransactionPIn(String? oldPin, String? newPin) async {
    String _updatePINURL = BaseService.rootApi + '/users/pin';

    try {
      final response = await Dio().put(
        "$_updatePINURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
        data: {
          "old_pin": oldPin,
          "new_pin": newPin,
        },
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST....TO Update User PIN",
          response.data["code"],
          response.data["status"],
          response.data["message"],
        });

      return response.data["message"];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "failed", "message": e.message};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"status": "failed", "message": e.message};
      }
    }
  }

  setUsersTransactionPIn(String? newPin) async {
    String _updatePINURL = BaseService.rootApi + '/users/pin';

    try {
      final response = await Dio().post(
        "$_updatePINURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
        data: {
          "pin": newPin,
        },
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST....TO SET User PIN",
          response.data["code"],
          response.data["status"],
          response.data["message"],
        });

      return response.data["message"];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "failed", "message": e.message};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"status": "failed", "message": e.message};
      }
    }
  }

  updatePassword(String? oldPass, String? newPass, String? confirmPass) async {
    String _passwordUpdateURL = BaseService.rootApi + '/users/password';

    try {
      final response = await Dio().put(
        "$_passwordUpdateURL",
        data: {
          "old_password": oldPass,
          "new_password": newPass,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          },
        ),
      );

      if (kDebugMode) {
        print({"UPDATING USERS PASSWORD", response.data['data']});

        return response.data["message"];
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "failed", "message": e.response!.statusMessage};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"status": "failed", "message": e.message};
      }
    }
  }

  updateProfileImage(File? image) async {
    String _updateProfileImageURL =
        BaseService.rootApi + '/users/profile-image';

    try {
      var profilePicBytes = image!.readAsBytesSync();
      var formData = FormData.fromMap({
        "userId": locator<UserService>().id,
        "profile_pic": MultipartFile.fromBytes(
          profilePicBytes,
          filename:
              '${locator<UserService>().data!.firstName! + locator<UserService>().data!.lastName!}.jpg',
          contentType: new MediaType("image", "jpeg"), //add this
        ),
      });
      final response = await Dio().put(
        "$_updateProfileImageURL",
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          },
        ),
      );

      if (kDebugMode) print({"UPDATING USERS PROFILE IMAGE", response.data});
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

  updateUserProfile(UserDetails? userDetails) async {
    String _userURL = BaseService.rootApi + '/users/profile';

    try {
      final response = await Dio().put(
        "$_userURL",
        data: userDetails!.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          },
        ),
      );

      if (kDebugMode) print({"UPDATING USERS PROFILE", response.data});
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
        return {'message': e.message, 'status': 'error'};
      }
    }
  }

  resetUserPasswordReq(String? email, String? phone) async {
    // String _resetPasswordURL = BaseService.rootApi + '/users/reset-password';
    String _resetPasswordURL = BaseService.rootApi + '/auth/password/reset';
    if (kDebugMode) print({"ENDPOINT BASE URL", BaseService.rootApi});

    try {
      var response;

      if (email != null) {
        response = await Dio().post(
          "$_resetPasswordURL",
          data: {"email": email},
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );
      } else if (phone != null) {
        response = await Dio().post(
          "$_resetPasswordURL",
          data: {"phone": phone},
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );
      } else {
        return {
          "message": "You must provide either email address or phone number",
          "status": 'error'
        };
      }

      if (kDebugMode) print({"RESETTING USERS PASSWORD", response.data});
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
        return {"message", e.message};
      }
    }
  }

  resetUserPasswordSetnew(String? ref, String? otp, String? newPassword,
      String? confirmNewPass) async {
    // String _resetPasswordURL = BaseService.rootApi + '/users/reset-password';
    String _resetPasswordURL = BaseService.rootApi + '/auth/password/reset';

    try {
      final response = await Dio().put(
        "$_resetPasswordURL",
        data: {
          "ref": ref,
          "otp": otp,
          "password": newPassword,
          "confirm_password": confirmNewPass,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (kDebugMode) print({"RESETTING USERS PASSWORD", response.data});
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
        return {"message", e.message};
      }
    }
  }

  getFinancialSummary() async {
    String _summaryURL = BaseService.rootApi +
        '/users/financials/summary/${locator<UserService>().id}';

    try {
      final response = await Dio().get("$_summaryURL",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          }));

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... FOR USER Financial summary",
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
        return e.response!.data;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message};
      }
    }
  }

  getPendingOrder() async {
    String _summaryURL = BaseService.rootApi +
        '/users/pending/orders/${locator<UserService>().id}';

    try {
      final response = await Dio().get("$_summaryURL",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          }));

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... FOR USER pending order",
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
        return e.response!.data;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message};
      }
    }
  }

// New API implementation
  addBankAccount(AccountModel? newBankDetails) async {
    String _addBankURL = BaseService.rootApi + '/users/accounts';

    try {
      final response = await Dio().post(
        "$_addBankURL",
        data: newBankDetails!.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          },
        ),
      );

      if (kDebugMode) print({"ADD A NEW BANK ACCOUNT TO USER", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"message": e.message, "Status": "failed"};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "failed"};
      }
    }
  }

  getBankAccounts() async {
    String _getBankURL = BaseService.rootApi + '/users/accounts';

    try {
      final response = await Dio().get(
        "$_getBankURL",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          },
        ),
      );

      if (kDebugMode) print({"GET BANK ACCOUNTS OF USER", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"message": e.message, "Status": "failed"};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "failed"};
      }
    }
  }

  getBankList() async {
    String _getBankListURL = BaseService.rootApi + '/utils/banks';

    try {
      final response = await Dio().get(
        "$_getBankListURL",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          },
        ),
      );

      if (kDebugMode) print({"GET BANK LIST FOR USER", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"message": e.message, "Status": "failed"};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "failed"};
      }
    }
  }

  deactivateUser(String? userId) async {
    String _deactivateURL = BaseService.rootApi + '/users/action/deactivate';

    try {
      final response = await Dio().post(
        "$_deactivateURL",
        data: {"userId": int.parse(userId!)},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          },
        ),
      );

      if (kDebugMode) print({"DEACTIVATING USER ACCOUNT", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "failed", "message": e.message};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"status": "failed", "message": e.message};
      }
    }
  }

  reverseGoecodeAPI(String? lat, String? lng) async {
    String _geocoderAPI =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${BaseService.GOOGLE_GEOCODER}';

    try {
      final response = await Dio().post(
        "$_geocoderAPI",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (kDebugMode) print({"GEOLOCATION API DATA RETURN", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "failed", "message": e.message};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"status": "failed", "message": e.message};
      }
    }
  }
}
