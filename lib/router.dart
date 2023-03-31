import 'package:CHATS/screens/Home/Views/index.dart';
import 'package:CHATS/screens/Home/Views/transfer_view.dart';
import 'package:CHATS/screens/auth/login_screen.dart';
import 'package:CHATS/screens/auth/sign-up.dart';
// import 'package:CHATS/screens/Home/Views/index.dart';
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
// const String scanCode = "scanCode";
const String scanNFCOrQR = "scanNFCOrQR";
const String wallet = "wallet";
const String notification = "notification";
const String paymentConfirmation = "paymentConfirmation";
const String kycStatus = 'kycStatus';
const String bvnVerification = 'bvnVerification';
const String personalInfo = 'personal-info';
const String account = 'account';
const String transactionPin = 'transaction_pin';
const String security = 'security';
const String mySetting = 'settings';
const String helpSupport = 'help_support';
const String changePassword = 'change_password';
const String setPIN = 'create_pin';
const String changePIN = 'change_pin';
const String campaigns = 'campaigns';
const String allCampaigns = 'all_campaigns';
const String tasks = 'tasks';
const String complaint = 'complaint';
const String resetPassword = 'reset_password';
const String cardAndPayments = 'card_and_payments';
const String profileSettings = 'profile_settings';
const String accountSettings = 'account_settings';
const String transferView = 'transfer_view';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case paymentConfirmation:
        return MaterialPageRoute(
            builder: (_) =>
                PaymentConfirmationView(qrReference: args as String));
      // break;
      case scanNFCOrQR:
        return MaterialPageRoute(builder: (_) => ScanNFCOrQRView());
      // break;
      // case scanCode:
      //   return MaterialPageRoute(builder: (_) => ScanQRView());
      //   break;
      case bvnVerification:
        return MaterialPageRoute(builder: (_) => BVNVerificationScreen());
      // break;
      case notification:
        return MaterialPageRoute(builder: (_) => NotificationsView());
      // break;
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      // break;
      case wallet:
        return MaterialPageRoute(builder: (_) => WalletView());
      // break;
      case transferView:
        return MaterialPageRoute(
          builder: (_) => TransferView(
            campaignId: args != null ? args as int : null,
          ),
        );

      case home:
        return MaterialPageRoute(builder: (_) => HomeView());
      // break;
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      // break;

      case onboard:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      // break;

      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      // break;

      case signUp:
        return MaterialPageRoute(builder: (_) => SignUpView());
      // break;

      case personalInfo:
        return MaterialPageRoute(builder: (_) => PersonalInfo());
      // break;

      case kycStatus:
        return MaterialPageRoute(builder: (_) => KYCstatus());
      // break;

      case account:
        return MaterialPageRoute(builder: (_) => Account());
      // break;

      // case cardAndPayments:
      //   return MaterialPageRoute(builder: (_) => CardAndPaymentsView());
      // // break;

      // case profileSettings:
      //   return MaterialPageRoute(builder: (_) => ProfileSettings());
      // break;

      case accountSettings:
        return MaterialPageRoute(builder: (_) => Account());
      // break;

      case transactionPin:
        return MaterialPageRoute(
            builder: (_) => TransactionPinView(reference: args as String));
      // break;

      case security:
        return MaterialPageRoute(builder: (_) => SecurityView());
      // break;

      case mySetting:
        return MaterialPageRoute(builder: (_) => SettingsView());
      // break;

      case helpSupport:
        return MaterialPageRoute(builder: (_) => HelpSupportView());
      // break;

      case changePassword:
        return MaterialPageRoute(builder: (_) => ChangePasswordView());

      case setPIN:
        return MaterialPageRoute(builder: (_) => SetPINView());

      case changePIN:
        return MaterialPageRoute(builder: (_) => ChangePINView());

      case campaigns:
        return MaterialPageRoute(builder: (_) => CampaignsView());

      case allCampaigns:
        return MaterialPageRoute(builder: (_) => AllCampaignsView());

      case tasks:
        return MaterialPageRoute(builder: (_) => TasksView());

      case complaint:
        return MaterialPageRoute(builder: (_) => ComplaintView());

      case resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPasswordView());

      default:
        print(settings.name);
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route define for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
