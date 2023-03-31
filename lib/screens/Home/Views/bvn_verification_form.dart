import 'package:CHATS/screens/Home/view_models/base_view_model.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';

class BVNVerificationScreen extends StatelessWidget {
  final myKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController =
        new TextEditingController(text: '');
    final size = MediaQuery.of(context).size;
    final smallH = size.height / 36;
    final smallW = size.height / 46;
    return BaseViewModel(
      providerReady: (provider) => {},
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          backgroundColor:
              ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white),
          ),
        ),
        body: Container(
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
          padding: EdgeInsets.only(
              top: smallH * 2, right: smallW, left: smallW, bottom: smallH * 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: myKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'BVN Validation',
                        fontFamily: 'Gilroy-bold',
                        fontSize: smallH * 1.5,
                        edgeInset: EdgeInsets.only(bottom: smallH * 2),
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      CustomTextField(
                        controller: firstNameController,
                        onSaved: (val) {},
                        // validateFn: (val) {
                        //   if (val.isEmpty) return 'Cannot be empty';
                        // },
                        label: CustomText(
                            text: 'BVN-11 Digits',
                            fontSize: 16,
                            fontFamily: 'Gilroy-Medium',
                            color:
                                ThemeBuilder.of(context)!.getCurrentTheme() ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white),
                        hintText: '1209065233507',
                      ),
                      CustomButton(
                          bgColor: Constants.usedGreen,
                          children: [
                            CustomText(
                              text: 'Submit',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              edgeInset: EdgeInsets.all(0.0),
                            )
                          ],
                          onTap: () {
                            // myKey.currentState.save();
                            // if (myKey.currentState.validate()) {}
                            Navigator.pop(context);
                          }),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
