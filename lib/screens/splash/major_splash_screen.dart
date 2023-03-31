// import 'package:CHATS/general_base_view_model.dart';
import 'package:CHATS/screens/Home/view_models/base_view_model.dart';
import 'package:CHATS/screens/Home/view_models/splash_screenVM.dart';
// import 'package:CHATS/domain/local_storage.dart';
// import 'package:CHATS/screens/Home/views/home_view.dart';
import 'package:flutter/material.dart';

class MajorSplashScreen extends StatefulWidget {
  @override
  _MajorSplashScreenState createState() => _MajorSplashScreenState();
}

class _MajorSplashScreenState extends State<MajorSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 6));
  }

// provider.startUp,
  @override
  Widget build(BuildContext context) {
    return BaseViewModel<SplashScreenViewModel>(
      providerReady: (provider) => provider.startUp(context),
      builder: (context, provider, child) => Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Image.asset(
              'assets/chatGif.gif',
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
