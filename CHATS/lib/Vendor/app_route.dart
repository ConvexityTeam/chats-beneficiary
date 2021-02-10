import 'package:CHATS/Vendor/core/constants/route_paths.dart';
import 'package:CHATS/Vendor/ui/screen/accept_payment_view.dart';
import 'package:CHATS/Vendor/ui/screen/account_settings_view.dart';
import 'package:CHATS/Vendor/ui/screen/card_and%20_payment_view.dart';
import 'package:CHATS/Vendor/ui/screen/home.dart';
import 'package:CHATS/Vendor/ui/screen/login_screen.dart';
import 'package:CHATS/Vendor/ui/screen/on_board.dart';
import 'package:CHATS/Vendor/ui/screen/profile_settings_view.dart';
import 'package:CHATS/Vendor/ui/screen/profile_view.dart';
import 'package:CHATS/Vendor/ui/screen/scan_code_view.dart';
import 'package:CHATS/Vendor/ui/screen/security_view.dart';
import 'package:CHATS/Vendor/ui/screen/sign_up.dart';
import 'package:CHATS/Vendor/ui/screen/support_view.dart';
import 'package:CHATS/Vendor/ui/screen/transaction_view.dart';
import 'package:CHATS/Vendor/ui/screen/wallet_view.dart';
import 'package:flutter/material.dart';

class RoutePath {
  // ignore: missing_return
  static Route<dynamic> routePath(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.acceptPaymentsView:
        return MaterialPageRoute(builder: (_) => AcceptPaymentsView());
        break;
      case Routes.walletView:
        return MaterialPageRoute(builder: (_) => WalletView());
        break;

      case Routes.signUpView:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
        break;
      case Routes.loginView:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
      case Routes.transactionView:
        return MaterialPageRoute(builder: (_) => TransactionView());
        break;
      case Routes.onboardView:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
        break;
      case Routes.profileSettingsView:
        return MaterialPageRoute(builder: (_) => ProfileSettings());
        break;
      case Routes.securityView:
        return MaterialPageRoute(builder: (_) => SecurityView());
        break;
      case Routes.cardAndPaymentView:
        return MaterialPageRoute(builder: (_) => CardAndPaymentsView());
        break;
      case Routes.accountSettingsView:
        return MaterialPageRoute(builder: (_) => AccountSettingsView());
        break;
      case Routes.homeView:
        return MaterialPageRoute(builder: (_) => HomeView());
        break;
      case Routes.profileView:
        return MaterialPageRoute(builder: (_) => ProfileView());
        break;
      case Routes.scanCodeView:
        return MaterialPageRoute(builder: (_) => ScanQRView());
        break;

      case Routes.supportView:
        return MaterialPageRoute(builder: (_) => SupportView());

        break;
      default:
        return MaterialPageRoute(
          builder: (_) => SafeArea(
            child: Scaffold(
              body: Center(
                child: Text("No Route defined for ${routeSettings.name}"),
              ),
            ),
          ),
        );
    }
  }
}