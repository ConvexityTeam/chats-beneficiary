// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseModel _$UserResponseModelFromJson(Map<String, dynamic> json) {
  return UserResponseModel(
    status: json['status'] as String,
    message: json['message'] as String,
    userObj: json['userObj'] == null
        ? null
        : Data.fromJson(json['userObj'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserResponseModelToJson(UserResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'userObj': instance.userObj,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['id'] as int,
    referal_id: json['referal_id'] as String,
    RoleId: json['RoleId'] as int,
    OrganisationId: json['OrganisationId'] as String,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    phone: json['phone'] as String,
    bvn: json['bvn'] as String,
    marital_status: json['marital_status'] as String,
    gender: json['gender'] as String,
    status: json['status'] as String,
    balance: (json['balance'] as num).toDouble(),
    location: json['location'] as String,
    pin: json['pin'] as String,
    blockchain_address: json['blockchain_address'] as String,
    address: json['address'] as String,
    is_email_verified: json['is_email_verified'] as bool,
    is_phone_verified: json['is_phone_verified'] as bool,
    is_bvn_verified: json['is_bvn_verified'] as bool,
    is_self_signup: json['is_self_signup'] as bool,
    is_public: json['is_public'] as bool,
    is_tfa_enabled: json['is_tfa_enabled'] as bool,
    tfa_secret: json['tfa_secret'] as String,
    is_organisation: json['is_organisation'] as bool,
    last_login: json['last_login'] as String,
    long: json['long'] as String,
    lat: json['lat'] as String,
    profile_pic: json['profile_pic'] as String,
    nfc: json['nfc'] as String,
    right_fingers: json['right_fingers'] as String,
    left_fingers: json['left_fingers'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'referal_id': instance.referal_id,
      'RoleId': instance.RoleId,
      'OrganisationId': instance.OrganisationId,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'bvn': instance.bvn,
      'marital_status': instance.marital_status,
      'gender': instance.gender,
      'status': instance.status,
      'balance': instance.balance,
      'location': instance.location,
      'pin': instance.pin,
      'blockchain_address': instance.blockchain_address,
      'address': instance.address,
      'is_email_verified': instance.is_email_verified,
      'is_phone_verified': instance.is_phone_verified,
      'is_bvn_verified': instance.is_bvn_verified,
      'is_self_signup': instance.is_self_signup,
      'is_public': instance.is_public,
      'is_tfa_enabled': instance.is_tfa_enabled,
      'tfa_secret': instance.tfa_secret,
      'is_organisation': instance.is_organisation,
      'last_login': instance.last_login,
      'long': instance.long,
      'lat': instance.lat,
      'profile_pic': instance.profile_pic,
      'nfc': instance.nfc,
      'right_fingers': instance.right_fingers,
      'left_fingers': instance.left_fingers,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
