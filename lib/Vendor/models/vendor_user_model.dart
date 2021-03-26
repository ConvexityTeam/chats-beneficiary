import 'package:json_annotation/json_annotation.dart';
part 'vendor_user_model.g.dart';

@JsonSerializable()
class VendorUserModel {
  String referal_id = "";
  String OrganisationId = "2";
  String first_name = "";
  String last_name = "";
  String email = "";
  String phone = "";
  String password = "";
  int status = 0;
  String bvn = "";
  String location = "";
  String long = "";
  String lat = "";
  String profile_pic = "";
  String nfc = "";
  String pin = "";
  String blockchain_address = "";
  String address = "";
  String last_login = "";
  String marital_status = "";
  String gender = "";

  VendorUserModel();
  factory VendorUserModel.fromJson(Map<String, dynamic> json) =>
      _$VendorUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$VendorUserModelToJson(this);
}
