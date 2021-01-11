import 'package:CHATS/locator.dart';
import 'package:CHATS/ui/screen/router.dart' as router;
import "package:flutter/material.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
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
      onGenerateRoute: router.Router.generateRoute,
      initialRoute: 'splash',
    );
  }
}
