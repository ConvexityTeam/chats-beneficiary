import 'package:json_annotation/json_annotation.dart';
part 'user_response.g.dart';

@JsonSerializable()
class UserResponseModel {
  String? status;
  String? message;
  Data? userObj;
  UserResponseModel({this.status, this.message, this.userObj});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  int? id = 0;
  String? referal_id = '';
  int? RoleId = 0;
  String? OrganisationId = '';
  String? first_name = '';
  String? last_name = '';
  String? email = '';
  String? password = '';
  String? phone = '';
  String? bvn = '';
  String? marital_status = '';
  String? gender = '';
  String? status = '';
  double? balance = 0.0;
  String? location = '';
  String? pin = '';
  String? blockchain_address = '';
  String? address = '';
  bool? is_email_verified;
  bool? is_phone_verified;
  bool? is_bvn_verified;
  bool? is_self_signup;
  bool? is_public;
  bool? is_tfa_enabled;
  String? tfa_secret;
  bool? is_organisation;
  String? last_login;
  String? long;
  String? lat;
  String? profile_pic;
  String? nfc;
  String? right_fingers;
  String? left_fingers;
  String? createdAt;
  String? updatedAt;
  Data({
    this.id,
    this.referal_id,
    this.RoleId,
    this.OrganisationId,
    this.first_name,
    this.last_name,
    this.email,
    this.password,
    this.phone,
    this.bvn,
    this.marital_status,
    this.gender,
    this.status,
    this.balance,
    this.location,
    this.pin,
    this.blockchain_address,
    this.address,
    this.is_email_verified,
    this.is_phone_verified,
    this.is_bvn_verified,
    this.is_self_signup,
    this.is_public,
    this.is_tfa_enabled,
    this.tfa_secret,
    this.is_organisation,
    this.last_login,
    this.long,
    this.lat,
    this.profile_pic,
    this.nfc,
    this.right_fingers,
    this.left_fingers,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  // Map<String, dynamic> toJson() => _$DataToJson(this);
}
