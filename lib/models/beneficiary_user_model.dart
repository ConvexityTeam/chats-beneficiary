import 'package:CHATS/models/wallet.dart';
import 'package:flutter/foundation.dart';

class BeneficiaryUser {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  String status;
  bool isEmailVerified;
  String profilePic = '';
  String gender;
  String dob;
  String updatedAt;
  Wallet wallet;

  BeneficiaryUser(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.phone,
      @required this.password,
      this.profilePic,
      @required this.gender,
      @required this.dob,
      this.isEmailVerified,
      this.status,
      this.wallet,
      this.updatedAt});

  BeneficiaryUser.fromJson(Map<String, dynamic> parsedJson)
      : firstName = parsedJson['first_name'],
        phone = parsedJson['phone'],
        password = parsedJson['password'],
        email = parsedJson['email'],
        gender = parsedJson['gender'],
        dob = parsedJson['dob'],
        lastName = parsedJson['last_name'],
        wallet = Wallet.fromJson(parsedJson['Wallet']),
        isEmailVerified = parsedJson['is_email_verified'],
        profilePic = parsedJson['profile_pic'],
        status = parsedJson['status'],
        updatedAt = parsedJson['updatedAt'];

  Map<String, String> toJson() => {
        'first_name': firstName,
        'email': email,
        'gender': gender,
        'password': password,
        'dob': dob,
        'last_name': lastName,
        'phone': phone,
      };
}
