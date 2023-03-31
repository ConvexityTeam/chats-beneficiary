import 'dart:convert';

import 'package:CHATS/models/campaign_model.dart';
import 'package:CHATS/models/wallet.dart';
import 'package:flutter/foundation.dart';

class UserDetails {
  double? totalWalletBalance;
  double? totalWalletReceived;
  double? totalWalletSpent;
  int? id;
  String? referalId;
  int? roleId;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? phone;
  String? bvn;
  String? nin;
  String? maritalStatus;
  String? gender;
  String? status;
  Map<String, dynamic>? location;
  String? pin;
  String? address;
  int? vendorId;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  bool? isBvnVerified;
  bool? isNinVerified;
  bool? isSelfSignup;
  bool? isPublic;
  bool? isTfaEnabled;
  String? lastLogin;
  String? profilePic;
  String? nfc;
  String? dob;
  String? createdAt;
  String? updatedAt;
  String? ip;
  List<Campaign>? campaigns;
  List<Wallet>? wallets = [];
  Wallet? userWallet;
  List<Map>? accounts;

  UserDetails(
      {this.totalWalletBalance,
      this.totalWalletReceived,
      this.totalWalletSpent,
      this.id,
      this.referalId,
      this.roleId,
      this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.phone,
      this.bvn,
      this.nin,
      this.maritalStatus,
      this.gender,
      this.status,
      this.location,
      this.pin,
      this.address,
      this.vendorId,
      this.isEmailVerified,
      this.isPhoneVerified,
      this.isBvnVerified,
      this.isNinVerified,
      this.isSelfSignup,
      this.isPublic,
      this.isTfaEnabled,
      this.lastLogin,
      this.profilePic,
      this.nfc,
      this.dob,
      this.createdAt,
      this.updatedAt,
      this.ip,
      this.campaigns,
      this.wallets,
      this.userWallet,
      this.accounts});

  UserDetails.fromJson(Map<String, dynamic> jsonData) {
    totalWalletBalance = jsonData['total_wallet_balance']?.toDouble();
    totalWalletReceived = jsonData['total_wallet_received']?.toDouble();
    totalWalletSpent = jsonData['total_wallet_spent']?.toDouble();
    id = jsonData['id'];
    referalId = jsonData['referal_id'];
    roleId = jsonData['RoleId'];
    firstName = jsonData['first_name'];
    lastName = jsonData['last_name'];
    username = jsonData['username'];
    email = jsonData['email'];
    phone = jsonData['phone'];
    bvn = jsonData['bvn'];
    nin = jsonData['nin'];
    maritalStatus = jsonData['marital_status'];
    gender = jsonData['gender'];
    status = jsonData['status'];
    location = jsonDecode(jsonData["location"]);
    pin = jsonData['pin'];
    address = jsonData['address'];
    vendorId = jsonData['vendor_id'];
    isEmailVerified = jsonData['is_email_verified'];
    isPhoneVerified = jsonData['is_phone_verified'];
    isBvnVerified = jsonData['is_bvn_verified'];
    isNinVerified = jsonData['is_nin_verified'];
    isSelfSignup = jsonData['is_self_signup'];
    isPublic = jsonData['is_public'];
    isTfaEnabled = jsonData['is_tfa_enabled'];
    lastLogin = jsonData['last_login'];
    profilePic = jsonData['profile_pic'];
    nfc = jsonData['nfc'];
    dob = jsonData['dob'];
    createdAt = jsonData['createdAt'];
    updatedAt = jsonData['updatedAt'];
    if (jsonData['Campaigns'] != null) {
      campaigns = <Campaign>[];
      jsonData['Campaigns'].forEach((v) {
        campaigns!.add(new Campaign.fromJson(v));
      });
    }
    if (jsonData['Wallets'] != null) {
      if (kDebugMode) print({"<<< WALLETS >>>", jsonData["Wallets"]});
      wallets = <Wallet>[];
      jsonData['Wallets'].forEach((w) {
        jsonData['Campaigns'].forEach((c) {
          if (w['CampaignId'] == c['id']) {
            if (c['status'] == 'active' ||
                c['status'] == 'ongoing' && w['balance']?.toDouble() > 0.0) {
              wallets!.add(new Wallet.fromJson(w));
            }
          }
          // else if (w['CampaignId'] == null) {
          //   userWallet = new Wallet.fromJson(w);
          // }
        });
      });
    } else {
      wallets = <Wallet>[];
    }
    if (jsonData['Accounts'] != null) {
      accounts = <Map>[];
      jsonData['Accounts'].forEach((v) {
        // accounts.add(new Null.fromJson(v));
      });
    } else {
      accounts = <Map>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    // data['email'] = this.email;
    if (this.phone != null) data['phone'] = this.phone;
    // data['bvn'] = this.bvn;
    if (this.nin != null && this.nin?.length != 0) data['nin'] = this.nin;
    // data['marital_status'] = this.maritalStatus;
    if (this.gender != null) data['gender'] = this.gender;
    if (this.username != null) data['username'] = this.username;
    if (this.ip != null) data['ip'] = this.ip;
    // data['status'] = this.status;
    // data['location'] = jsonEncode({"country": 'Nigeria', "coordinates": []});
    // data['address'] = this.address;
    // data['currency'] = 'NGN';
    // data['country'] = 'NG';
    if (this.dob != null && this.dob?.length != 0) data['dob'] = this.dob;

    print({data, "Formatted data"});

    return data;
  }
}
