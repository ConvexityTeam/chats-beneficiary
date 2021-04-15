import 'package:flutter/foundation.dart';

class BeneficiaryUser {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  String profilePic;
  final String gender;
  final String dob;

  BeneficiaryUser(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.phone,
      @required this.password,
      this.profilePic,
      @required this.gender,
      @required this.dob});

  BeneficiaryUser.fromJson(Map<String, dynamic> parsedJson)
      : firstName = parsedJson['firstName'],
        phone = parsedJson['phone'],
        password = parsedJson['password'],
        email = parsedJson['email'],
        gender = parsedJson['gender'],
        dob = parsedJson['dob'],
        lastName = parsedJson['lastName'];

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
