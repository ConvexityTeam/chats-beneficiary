import 'dart:convert';
// import 'dart:html';
import 'dart:io';

import 'package:CHATS/api/campaigns_api.dart';
import 'package:CHATS/api/transactions.dart';
import 'package:CHATS/api/user_api.dart';
import 'package:CHATS/models/account_model.dart';
import 'package:CHATS/models/bank_list.dart';
import 'package:CHATS/models/campaign_model.dart';
import 'package:CHATS/models/order_model.dart';
import 'package:CHATS/models/picked_task_model.dart';
import 'package:CHATS/models/task_model.dart';
import 'package:CHATS/models/transactions_model.dart';
import 'package:CHATS/models/user_details_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class UserService extends ChangeNotifier {
  String? token;
  String? pin;
  String? id;
  File? profilePic;
  UserDetails? _data;
  UserDetails? _userDetails;
  Map? _summary;
  List<Campaign>? _campaigns;
  List<AccountModel>? _accounts;
  List<BankList>? _banks;

  OrderModel? _order;
  TransactionsHistory? _history;
  TransactionsHistory? _chatHistory;

  List<TaskModel>? _tasks;
  List<PickedTaskModel>? _pickedTasks;

  bool isNewCampaignActive = false;

  UserDetails? get userDetails {
    return _userDetails;
  }

  UserDetails? get data {
    return _data;
  }

  Map? get summary {
    return _summary;
  }

  List<Campaign>? get campaigns {
    return _campaigns;
  }

  List<AccountModel>? get accounts {
    return _accounts;
  }

  List<BankList>? get banks {
    return _banks;
  }

  OrderModel? get order {
    return _order;
  }

  TransactionsHistory? get history {
    return _history;
  }

  TransactionsHistory? get chatHistory {
    return _chatHistory;
  }

  List<TaskModel>? get tasks {
    return _tasks;
  }

  List<PickedTaskModel>? get pickedTasks {
    return _pickedTasks;
  }

  Future<void> setUserData() async {
    Map<String, dynamic> detailsResponse =
        await UserAPI().getUserDetailsAndWallet();
    if (kDebugMode)
      print({
        'Setting user data...',
        ' ${detailsResponse["location"].runtimeType}',
        detailsResponse['Wallets'],
      });
    _data = UserDetails.fromJson(detailsResponse);
    await this.getPublicCampaigns();
    await this.getBankAccounts();
    isNewCampaignActive = false;
    notifyListeners();
    // await getSummary();
  }

  Future<void> getUserCampaignWallets() async {
    //TODO: Call the get wallet endpoint and serialize data into the wallet model
  }

  Future<void> getSummary() async {
    Map? response = await UserAPI().getFinancialSummary();
    _summary = response;
    if (kDebugMode) print('Getting financial summary... $response');
  }

  Future<void> getUserDetails() async {
    Map<String, dynamic> detailsResponse = await UserAPI().getUserDetails();
    _userDetails = UserDetails.fromJson(detailsResponse);
    if (kDebugMode) print('Getting user details... $detailsResponse');
  }

  Future<void> getPublicCampaigns() async {
    List response = await CampaignAPI().getAllPublicCampaigns();
    // List cashWorkresponse = await CampaignAPI().getAllCashForWork();
    if (kDebugMode) print('Gettign campaign data... $response');
    _campaigns = response.map((item) => Campaign.fromJson(item)).toList();
    _campaigns!.sort((b, a) => a.createdAt!.compareTo(b.createdAt!));
    // if (cashWorkresponse.length > 0)
    //   _campaigns?.addAll(
    //       cashWorkresponse.map((item) => Campaign.fromJson(item)).toList());
    if (kDebugMode)
      print(
        'Getting all public campaigns... $response',
      );
  }

  Future<void> getBankAccounts() async {
    var response = await UserAPI().getBankAccounts();
    if (response['status'] == 'success') {
      _accounts = response['data'].isEmpty
          ? []
          : response['data']
              .map<AccountModel>((item) => AccountModel.fromJson(item))
              .toList();
    }
    this.getBankList();
  }

  Future<void> getBankList() async {
    var response = await UserAPI().getBankList();
    if (response['status'] == 'success') {
      _banks = response['data'].isEmpty
          ? []
          : response['data']
              .map<BankList>((item) => BankList.fromJson(item))
              .toList();
    }
  }

  Future<String?> addBankAccount(AccountModel newBank) async {
    var response = await UserAPI().addBankAccount(newBank);
    if (response['status'] == 'success') {
      return response['message'];
    }
    return response['message'];
  }

  Future<String?> joinCampaign(int campaignId) async {
    var response = await CampaignAPI().joinCampaign(campaignId.toString());
    if (kDebugMode) print('Adding user to campaign... $response');
    await this.setUserData();
    isNewCampaignActive = true;
    notifyListeners();
    return response['message'];
  }

  Future<String?> leaveCampaign(int campaignId) async {
    var response = await CampaignAPI().leaveCampaign(campaignId.toString());
    if (kDebugMode) print('Leaving a campaign... $response');
    await this.setUserData();

    return response['message'];
  }

  Future<String?> getTasksForC4WCampaign(int? campaignId) async {
    var response =
        await CampaignAPI().getAllTasksInCash4WorkCampaign(campaignId);
    if (kDebugMode) print('Getting tasks for c4w campaign... $response');

    if (response['status'] == 'success') {
      _tasks = response['data']['Campaigns'][0]['Jobs']
          .map<TaskModel>((item) => TaskModel.fromJson(item))
          .toList();

      await this.getPickedTasks();
      return null;
    }

    return response['message'];
  }

  Future<String?> getPickedTasks() async {
    var response = await CampaignAPI().fetchAssignedTasks();
    if (kDebugMode) print('Getting picked tasks for beneficiary... $response');

    if (response['status'] == 'success') {
      _pickedTasks = response['data']
          .map<PickedTaskModel>((item) => PickedTaskModel.fromJson(item))
          .toList();
      return null;
    }

    return response['message'];
  }

  Future<Map?> pickC4WTask(taskId) async {
    var response = await CampaignAPI().pickC4WTask(taskId);
    if (kDebugMode)
      print({"PICKING TASK FROM CASH4WORK", response.keys, response});

    return response;
  }

  Future<Map?> submitTaskEvidence(
      int assignmentId, String comment, List<File> evidenceImages) async {
    var response = await CampaignAPI()
        .submitEvidenceUpload(assignmentId, comment, evidenceImages);

    if (kDebugMode)
      print({
        "SUBMITTED TASK EVIDENCE",
        response?.keys,
        response,
      });

    return response;
  }

  Future updateProfile(UserDetails? userDetails) async {
    final response = await UserAPI().updateUserProfile(userDetails);
    if (kDebugMode) print('Updating user details... $response');
    await this.setUserData();
    return response;
  }

  Future<Map?> updateProfileImage() async {
    var response = await UserAPI().updateProfileImage(profilePic);
    if (kDebugMode) print('Updating user profile image... $response');
    // await this.getUserDetails();
    return response;
  }

  Future<String?> updatePassword(
      String? oldPass, String? newPass, String? confirmPass) async {
    String? response =
        await UserAPI().updatePassword(oldPass, newPass, confirmPass);
    if (kDebugMode) print('Updating user password... $response');
    // await this.getUserDetails();
    return response;
  }

  Future<String?> setUserPIN(String? pin) async {
    var response = await UserAPI().setUsersTransactionPIn(pin);
    if (kDebugMode) print('Setting user pin... $response');
    // await this.getUserDetails();
    return response;
  }

  Future<String?> updatePIN(String? oldPin, String? newPin) async {
    var response = await UserAPI().updateUsersTransactionPIn(oldPin, newPin);
    if (kDebugMode) print('Updating user pin... $response');
    // await this.getUserDetails();
    return response;
  }

  Future<Map?> resetUserPasswordReq(String? email, String? phone) async {
    var response = await UserAPI().resetUserPasswordReq(email, phone);
    if (kDebugMode) print('sent req to reset users password... $response');
    return response;
  }

  Future<Map?> resetUserPasswordSetnew(
      String? ref, String? otp, String? newPass, String? confirmNewPass) async {
    var response = await UserAPI()
        .resetUserPasswordSetnew(ref, otp, newPass, confirmNewPass);
    if (kDebugMode) print('Resetting users password... $response');
    return response;
  }

  Future<Map?> deactivateUser() async {
    var response = await UserAPI().deactivateUser(id);

    if (kDebugMode) print('Deactivating users account... $response');
    return response;
  }

  Future<String?> getOrder(String reference) async {
    var response = await TransactionAPI().getOrder(reference);

    if (response.containsKey("status") && response["status"] == "error") {
      return response["message"];
    }
    _order = OrderModel.fromJson(response);
  }

  Future<dynamic> checkOut(String? reference, String? pin, String? walletId,
      String? campaignWalletId) async {
    var response = await TransactionAPI()
        .checkout(reference, pin, walletId, campaignWalletId);

    return response;
  }

  Future<void> retrieveTransactions(String period) async {
    var response = await TransactionAPI().allTransactions(period);
    if (kDebugMode)
      print({"Retrieving the transaction history of the user", response});

    if (response['status'] != "failed") {
      _history = TransactionsHistory.fromJson(response['data']);
    }
  }

  Future<void> retrieveChatTransactions(String period) async {
    var response = await TransactionAPI().allTransactions(period.toLowerCase());
    if (kDebugMode)
      print({
        "Retrieving the transaction history for the chart of the user $period",
        response['data']
      });

    if (response['status'] != "failed") {
      _chatHistory = TransactionsHistory.fromJson(response['data']);
    }
  }

  Future<Map<String, dynamic>> getDeviceCountryNameAndCode() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return {};
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return {};
      }
    }

    _locationData = await location.getLocation();

    debugPrint(
        'location ${_locationData.latitude} & ${_locationData.longitude}');

    final coordinates =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    addresses.forEach((element) {
      print({
        "Object ",
        element.addressLine,
        element.featureName,
        element.locality,
        element.postalCode
      });
    });

    // Check alternate address lines to fix issue of null returned on some devices
    var alt_location = addresses.firstWhere((addy) => addy.addressLine != null);
    print({
      "Name: ${first.countryName}",
      "Code: ${first.countryCode}",
      "State: ${first.locality}",
      "State: ${first.subLocality}",
      "State: ${first.adminArea}",
      "State: ${first.subAdminArea}",
    });
    final Map<String, dynamic> result = {
      "country_name": first.countryName ?? alt_location.countryName,
      "country_code": first.countryCode ?? alt_location.countryCode,
      "state": first.adminArea ?? alt_location.adminArea,
      "address": first.addressLine ?? alt_location.addressLine,
      "location": {
        "latitude": _locationData.latitude,
        "longitude": _locationData.longitude
      }
    };
    return result;
  }

  Future<Map<String, dynamic>> fallBackDeviceCountryNameAndCode() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return {};
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return {};
      }
    }

    _locationData = await location.getLocation();
    Map<String, dynamic> result;
    // Call google geocode api to get data

    var response = await UserAPI().reverseGoecodeAPI(
        _locationData.latitude.toString(), _locationData.longitude.toString());
    print({"Google API docs", response});

    if (response.containsKey("results") && response['status'] == 'OK') {
      var country = response['results'][0]['address_components']
          .singleWhere((val) => val['types'][0] == 'country');
      var state = response['results'][0]['address_components'].singleWhere(
          (val) => val['types'][0] == 'administrative_area_level_1');
      var addy = response['results'][0]['formatted_address'];
      result = {
        "country_name": country['long_name'],
        "country_code": country['short_name'],
        "state": state['long_name'],
        "address": addy,
        "location": {
          "latitude": _locationData.latitude,
          "longitude": _locationData.longitude
        }
      };
      return result;
    } else {
      result = {
        "country_name": 'nil',
        "country_code": 'nil',
        "state": 'nil',
        "address": 'nil',
        "location": {
          "latitude": _locationData.latitude,
          "longitude": _locationData.longitude
        }
      };
      return result;
    }
  }

  Future<List> getCountryCodesList() async {
    var stringData = await rootBundle.loadString('assets/CountryCodes.json');
    return json.decode(stringData);
  }

  Future<String> liquidateUserWallet(
      String? amount, Map? bankDetails, dynamic campaignId) async {
    var response =
        await TransactionAPI().liquidateFunds(amount!, bankDetails, campaignId);
    if (kDebugMode) print({"Liquidating user balance", response});
    return response['message'];
  }

  Future<Map<String, dynamic>> transferFundsToUser({
    String fromWallet = 'personal',
    required String username,
    required String pin,
    required double amount,
    String? campaignId,
  }) async {
    var response = fromWallet == 'personal'
        ? await TransactionAPI().transferFunds(
            username: username,
            pin: pin,
            amount: amount,
          )
        : await TransactionAPI().transferFunds(
            fromWallet: fromWallet,
            username: username,
            pin: pin,
            amount: amount,
            campaignId: campaignId,
          );

    if (kDebugMode) print({"<<< TRANSFER >>>", response});

    return response;
  }
}
