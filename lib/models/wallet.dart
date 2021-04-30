import 'package:flutter/foundation.dart';

class Wallet {
  final String uuid;
  final int accountUserID;
  final int balance;
  final String createdAt;
  final String updatedAt;

  Wallet({
    @required this.uuid,
    @required this.accountUserID,
    @required this.balance,
    @required this.createdAt,
    @required this.updatedAt,
  });

  Wallet.fromJson(Map<String, dynamic> parsedJson)
      : uuid = parsedJson['uuid'],
        accountUserID = parsedJson['AccountUserId'],
        balance = parsedJson['balance'],
        createdAt = parsedJson['createdAt'],
        updatedAt = parsedJson['updatedAt'];

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'AccountUserId': accountUserID,
        'balance': balance,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
