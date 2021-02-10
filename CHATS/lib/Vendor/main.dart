import 'package:CHATS/Vendor/app_route.dart';
import 'package:CHATS/Vendor/ui/screen/on_board.dart';
import 'package:flutter/material.dart';

class VendorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue,
      ),
      onGenerateRoute: RoutePath.routePath,
      home: OnboardingScreen(),
    );
  }
}
