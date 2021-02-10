import 'package:CHATS/ChatsMain/ui/screen/Home/Views/payment_confirmation_view.dart';
import 'package:CHATS/ChatsMain/ui/screen/Home/Views/scan_QR_view.dart';
import 'package:CHATS/ChatsMain/ui/screen/bvn_verification_form.dart';
import 'package:CHATS/ChatsMain/ui/screen/login_screen.dart';
import 'package:CHATS/ChatsMain/ui/screen/onboard_screen.dart';
import 'package:CHATS/ChatsMain/ui/screen/sign-up.dart';
import 'package:CHATS/ChatsMain/ui/screen/splashscreen.dart';
import 'package:CHATS/ui/screen/Home/Views/kyc_status.dart';
import 'package:flutter/material.dart';

import 'Home/Views/home_view.dart';
import 'Home/Views/notifications_view.dart';
import 'Home/Views/pofile_view.dart';
import 'Home/Views/scan_NFC_or_OR_view.dart';
import 'Home/Views/wallet_view.dart';

/// here we have the routes  in static variable so it is easy for us to change
const String splash = 'splash';
const String onboard = 'onboard';
const String login = 'login';
const String signUp = 'signUp';
const String forgetPassword = 'forgetPassword';
const String verifyfp = 'verifyfp';
const String home = '/';
const String profile = "profile";
const String scanCode = "scanCode";
const String scanNFCOrQR = "scanNFCOrQR";
const String wallet = "wallet";
const String notification = "notification";
const String paymentConfirmation = "paymentConfirmation";
const String kycStatus = 'kycStatus';
const String bvnVerification = 'bvnVerification';

class Router {
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
