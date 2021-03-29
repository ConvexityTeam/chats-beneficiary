import 'package:CHATS/screens/auth/login_screen.dart';
import 'package:CHATS/screens/auth/sign-up.dart';
import 'package:CHATS/screens/home/Views/bvn_verification_form.dart';
import 'package:CHATS/screens/home/Views/onboard_screen.dart';
import 'package:CHATS/screens/home/views/home_view.dart';
import 'package:CHATS/screens/home/views/kyc_status.dart';
import 'package:CHATS/screens/home/views/notifications_view.dart';
import 'package:CHATS/screens/home/views/payment_confirmation_view.dart';
import 'package:CHATS/screens/home/views/personal_info_view.dart';
import 'package:CHATS/screens/home/views/profile_view.dart';
import 'package:CHATS/screens/home/views/scan_NFC_or_OR_view.dart';
import 'package:CHATS/screens/home/views/scan_QR_view.dart';
import 'package:CHATS/screens/home/views/splashscreen.dart';
import 'package:CHATS/screens/home/views/wallet_view.dart';
import 'package:flutter/material.dart';

/// here we have the routes  in static variable so it is easy for us to change
const String splash = 'splash';
const String onboard = 'onboard';
const String login = 'login';
const String signUp = 'signUp';
const String forgetPassword = 'forgetPassword';
const String verifyfp = 'verifyfp';
const String home = 'home';
const String profile = "profile";
const String scanCode = "scanCode";
const String scanNFCOrQR = "scanNFCOrQR";
const String wallet = "wallet";
const String notification = "notification";
const String paymentConfirmation = "paymentConfirmation";
const String kycStatus = 'kycStatus';
const String bvnVerification = 'bvnVerification';
const String personalInfo = 'personal-info';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case paymentConfirmation:
        return MaterialPageRoute(builder: (_) => PaymentConfirmationView());
        break;
      case scanNFCOrQR:
        return MaterialPageRoute(builder: (_) => ScanNFCOrQRView());
        break;
      case scanCode:
        return MaterialPageRoute(builder: (_) => ScanQRView());
        break;
      case bvnVerification:
        return MaterialPageRoute(builder: (_) => BVNVerificationScreen());
        break;
      case notification:
        return MaterialPageRoute(builder: (_) => NotificationsView());
        break;
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
        break;
      case wallet:
        return MaterialPageRoute(builder: (_) => WalletView());
        break;
      case home:
        return MaterialPageRoute(builder: (_) => HomeView());
        break;
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
        break;

      case onboard:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
        break;

      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;

      case signUp:
        return MaterialPageRoute(builder: (_) => SignUpView());
        break;

      case personalInfo:
        return MaterialPageRoute(builder: (_) => PersonalInfo());
        break;

      case kycStatus:
        return MaterialPageRoute(builder: (_) => KYCstatus());
        break;

      default:
        print(settings.name);
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No Route define for ${settings.name}'),
                  ),
                ));
    }
  }
}
