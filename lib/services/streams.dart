import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class SignUpPasswordController {
  Map<String, dynamic> initialValues = {"strength": 0.0, "password": ''};
  BehaviorSubject<Map<String, dynamic>>? _subjectPassword;

  SignUpPasswordController({required this.initialValues}) {
    _subjectPassword = BehaviorSubject.seeded(initialValues);
  }

  ValueStream<Map<String, dynamic>> get stream$ => _subjectPassword!.stream;
  // Map<String, dynamic> _values = _subjectPassword!.value;

  // Subjec

  // String get current = _password

  void onStrengthChange(double strength) {
    if (kDebugMode) print({"Strength", strength});
    initialValues['strength'] = strength;
    _subjectPassword!.sink.add(initialValues);
  }

  void onPasswordChange(String password) {
    initialValues['password'] = password;
    _subjectPassword!.sink.add(initialValues);
  }

  void dispose() {
    _subjectPassword!.close();
  }
}
