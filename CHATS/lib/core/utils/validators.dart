class Validators {
  static String validateName(String newVal) {
    return newVal.isEmpty ? "cannot be empty" : null;
  }

  static String validateEmail(String newVal) {
    if (newVal.isEmpty) {
      return " email cannot be empty";
    } else if (!(newVal.contains('@'))) {
      return 'enter a valid email';
    } else {
      return null;
    }
  }

  static String validatePhone(String newVal) {
    if (newVal.isEmpty) {
      return " email cannot be empty";
    } else if (newVal.length < 11) {
      return 'enter a valid phone Number';
    } else {
      return null;
    }
  }

  static String validatePassword(String newVal) {
    if (newVal.isEmpty) {
      return " enter a 4-digit pin";
    } else if (newVal.length < 3) {
      return 'enter a valid password';
    } else {
      return null;
    }
  }
}
