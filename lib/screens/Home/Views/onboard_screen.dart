import 'package:CHATS/screens/home/view_models/base_view_model.dart';
import 'package:CHATS/screens/home/view_models/sign_upVM.dart';
import 'package:CHATS/utils/custom_carousel.dart';
import 'package:CHATS/utils/rectanguler_round.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallH = size.height / 36;
    final smallW = size.height / 46;
    return BaseViewModel<SignUpVM>(
        providerReady: (provider) => provider.startUp(context),
        builder: (context, provider, child) => Scaffold(
              body: Container(
                  height: size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 20,
                      ),
                      Center(
                        child: Container(
                          child: Image.asset(
                            'assets/logo.png',
                            width: smallW * 10,
                          ),
                          margin: EdgeInsets.only(bottom: smallH * 1.2),
                        ),
                      ),
                      Expanded(
                        child: SliderImages(
                          imageList: provider.imageList,
                          scrollText: provider.scrollText,
                        ),
                      ),
                      // SizedBox(height: 20),
                      RoundRectangularButton(
                          radius: 10.0,
                          color: Constants.kgreen2,
                          onPressed: () =>
                              Navigator.pushNamed(context, 'signUp'),
                          text: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gilroy-Regular'),
                          )),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: RoundRectangularButton(
                            radius: 10.0,
                            color: Color(0xFFE5E5E5),
                            onPressed: () =>
                                Navigator.pushNamed(context, 'login'),
                            text: Text(
                              'Log In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Gilroy-Regular'),
                            )),
                      ),
                      SizedBox(height: 20),
                    ],
                  )),
            ));
  }
}
