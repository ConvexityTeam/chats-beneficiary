import 'package:CHATS/ui/shared/ui_helper.dart';
import 'package:CHATS/ui/viewModels/base_view_model.dart';
import 'package:CHATS/ui/viewModels/sign_upVM.dart';
import 'package:CHATS/ui/widgets/custom_carousel.dart';
import 'package:CHATS/ui/widgets/rectanguler_round.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BaseViewModel<SignUpVM>(
        providerReady: (provider) => null,
        builder: (context, provider, child) => Scaffold(
              body: Container(
                  padding: MediaQuery.of(context).viewPadding,
                  height: size.height,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: size.height / 50),
                          padding: EdgeInsets.all(size.height / 50),
                          child: Image.asset(
                            'assets/logo.png',
                            scale: 5,
                          ),
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
                                color: Colors.black,
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
                                  color: Colors.black,
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
