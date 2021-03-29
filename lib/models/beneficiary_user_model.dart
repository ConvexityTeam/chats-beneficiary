part 'beneficiary_user_model.g.dart';

class BeneficiaryUserModel {
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

  BeneficiaryUserModel();
  factory BeneficiaryUserModel.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryUserModelToJson(this);
}
