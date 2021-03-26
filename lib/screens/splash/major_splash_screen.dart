import 'package:main.dart';
import 'package:CHATS/screens/home/views/descision_page.dart';
import 'package:CHATS/general_splash_screenVM.dart';
import 'package:CHATS/general_base_view_model.dart';
import 'package:CHATS/domain/local_storage.dart';
import 'package:CHATS/models/user_type.dart';
import 'package:flutter/material.dart';

class MajorSplashScreen extends StatefulWidget {
  @override
  _MajorSplashScreenState createState() => _MajorSplashScreenState();
}

class _MajorSplashScreenState extends State<MajorSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 6), _checkUserStatus);
  }

  _checkUserStatus() async {
    LocalStorage localStorage = new LocalStorage();
    String user = await localStorage.checkUserType();
    if (user == userType[UserType.Non]) {
      // !handle here
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => DescisionPage()));
    } else if (user == userType[UserType.Non_Vendor]) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => NonVendorApp()));
    } else if (user == userType[UserType.Vendor]) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => VendorApp()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => DescisionPage()));
    }
  }

//provider.startUp,
  @override
  Widget build(BuildContext context) {
    return GBaseViewModel<GSplashScreenViewModel>(
      providerReady: (provider) => {},
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
