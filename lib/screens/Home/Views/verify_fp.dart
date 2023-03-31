import 'package:CHATS/screens/Home/view_models/base_view_model.dart';
import 'package:CHATS/screens/Home/view_models/sign_upVM.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';

class VerifyFPView extends StatefulWidget {
  @override
  _VerifyFPViewState createState() => _VerifyFPViewState();
}

class _VerifyFPViewState extends State<VerifyFPView> {
  @override
  Widget build(BuildContext context) {
    return BaseViewModel<SignUpVM>(
        providerReady: (model) {},
        builder: (context, provider, child) => Scaffold(
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_left,
                          color: Constants.purple,
                        ),
                        onPressed: () {},
                      ),
                      CustomText(
                        text: 'Verify Fingerprint',
                        color: Constants.purple,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Place your Thumb on the',
                        color: Constants.purple,
                      ),
                      CustomText(
                        text: 'Fingerprint sensor',
                        color: Constants.purple,
                      )
                    ],
                  ),
                  CustomButton(
                      margin: EdgeInsets.only(),
                      children: [
                        CustomText(
                          text: 'Verify',
                          color: Colors.white,
                          edgeInset: EdgeInsets.all(0.0),
                        )
                      ],
                      onTap: () {
                        setState(() {});
                      }),
                ],
              ),
            ));
  }
}
