import 'package:CHATS/screens/home/view_models/base_view_model.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/text.dart';
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
        body: Container(
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
                        ),
                        hintText: '1209065233507',
                      ),
                      CustomButton(
                          children: [
                            CustomText(
                              text: 'Submit',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
