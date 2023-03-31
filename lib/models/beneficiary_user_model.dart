// import 'package:CHATS/models/assoc_campaigns.dart';
import 'package:CHATS/models/campaign_model.dart';
import 'package:CHATS/models/wallet.dart';
// import 'package:flutter/foundation.dart';

class BeneficiaryUser {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? password;
  final String? location;
  final String? state;
  final String? address;
  final String? country;
  String? status;
  bool? isEmailVerified;
  String? profilePic = 'img';
  String? gender;
  String? dob;
  String? updatedAt;
  List<Wallet>? wallets;
  List<Campaign>? assocCampaigns;

  BeneficiaryUser({
    this.firstName,
    this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    this.location,
    this.state,
    this.address,
    this.country,
    this.profilePic,
    this.gender,
    this.dob,
    this.isEmailVerified,
    this.status,
    this.wallets,
    this.updatedAt,
    this.assocCampaigns,
  });

  BeneficiaryUser.fromJson(Map<String, dynamic> parsedJson)
      : firstName = parsedJson['user']['first_name'],
        phone = parsedJson['user']['phone'],
        password = parsedJson['user']['password'],
        email = parsedJson['user']['email'],
        gender = parsedJson['user']['gender'],
        location = parsedJson['user']['location'],
        state = parsedJson['user']['location'],
        address = parsedJson['user']['address'],
        country = parsedJson['user']['country'],
        dob = parsedJson['user']['dob'],
        lastName = parsedJson['user']['last_name'],
        wallets = parsedJson['user']['Wallet'] != null &&
                parsedJson['user']["Wallet"].length > 0
            ? parsedJson['user']["Wallet"]
                .map<Wallet>((item) => Wallet.fromJson(item))
                .toList()
            : null,
        isEmailVerified = parsedJson['user']['is_email_verified'],
        profilePic = parsedJson['user']['profile_pic'],
        status = parsedJson['user']['status'],
        updatedAt = parsedJson['user']['updatedAt'],
        assocCampaigns = parsedJson['associatedCampaigns'] != null &&
                parsedJson['associatedCampaigns'].length > 0
            ? parsedJson['associatedCampaigns']
                .map<Campaign>((item) => Campaign.fromJson(item))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        // 'first_name': firstName,
        'email': email,
        // 'gender': gender,
        'password': password,
        // 'dob': dob,
        // 'last_name': lastName,
        'phone': phone,
        'location': location,
        'country': country,
        'address': address,
        'state': state,
      };
}
