// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';

class LocalAuthService {
  // final _auth = LocalAuthentication();
  Future<bool> authenticate() async {
    // check if biometric is available
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await LocalAuthentication.authenticate(
          localizedReason: 'Scan fingerprint or face to authenticate',
          biometricOnly: true,
          useErrorDialogs: true);
    } on PlatformException catch (e) {
      print({"Auth Error", e.message});
      return false;
    }
  }

  Future<bool> hasBiometrics() async {
    try {
      return await LocalAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<List<BiometricType>> getBiometrics() async {
    try {
      return await LocalAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e.message);
      return <BiometricType>[];
    }
  }
}
