import 'package:CHATS/ChatsMain/ui/screen/router.dart' as Router;
import "package:flutter/material.dart";

class NonVendorApp extends StatelessWidget {
  // this widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CHATS',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      onGenerateRoute: Router.Router.generateRoute,
      initialRoute: 'onboard',
    );
  }
}
