// @dart=2.9
import 'dart:io';

import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/router.dart';
// import 'package:CHATS/screens/Home/views/home_view.dart';
import 'package:CHATS/screens/splash/major_splash_screen.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";

void main() {
  if (kDebugMode) HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // newSetUpLocator();
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // this widget is the root of your application
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultBrightness: Brightness.light,
      builder: (context, _brightness) {
        return MaterialApp(
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.3);
            return MediaQuery(
              child: child,
              data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
            );
          },
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.generateRoute,
          title: 'CHATS',
          theme: ThemeData(
            // scaffoldBackgroundColor: Colors.white,
            brightness: _brightness,
          ),
          // initialRoute: onboard,
          home: MajorSplashScreen(),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
