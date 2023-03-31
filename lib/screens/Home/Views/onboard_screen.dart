import 'package:CHATS/router.dart';
import 'package:CHATS/screens/Home/view_models/base_view_model.dart';
import 'package:CHATS/screens/Home/view_models/sign_upVM.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_carousel.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    print('Onboard our');
    final size = MediaQuery.of(context).size;
    final smallH = size.height / 36;
    final smallW = size.height / 46;
    return BaseViewModel<SignUpVM>(
      providerReady: (provider) => {},
      builder: (context, provider, child) => Scaffold(
        body: Container(
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
          height: size.height,
          child: Column(
            children: [
              SizedBox(
                height: size.height / 10,
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CustomButton(
                      height: 52,
                      children: [
                        CustomText(
                          text: 'Sign Up',
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Gilroy-medium',
                        ),
                      ],
                      onTap: () {
                        print('Enter signup from onboard');
                        Navigator.pushNamed(context, signUp);
                      },
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      height: 52,
                      bgColor: Colors.white,
                      borderColor: Constants.usedGreen,
                      children: [
                        CustomText(
                          text: 'Log In',
                          color: Constants.usedGreen,
                          fontSize: 16,
                          fontFamily: 'Gilroy-medium',
                        ),
                      ],
                      onTap: () {
                        print('Enter signup from onboard');
                        Navigator.pushNamed(context, login);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
