import 'package:CHATS/ChatsMain/locator.dart';
import 'package:CHATS/Vendor/locator.dart';
import 'package:CHATS/domain/general_locator.dart';
import 'package:CHATS/screens/splash/major_splash_screen.dart';
import "package:flutter/material.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  newSetUpLocator();
  setUpLocator();
  setUpVendorLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // this widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CHATS',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MajorSplashScreen(),
    );
  }
}
