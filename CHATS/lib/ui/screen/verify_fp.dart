import 'package:CHATS/ui/shared/BTN.dart';
import 'package:CHATS/ui/shared/TEXT.dart';
import 'package:CHATS/ui/shared/ui_helper.dart';
import 'package:CHATS/ui/viewModels/base_view_model.dart';
import 'package:CHATS/ui/viewModels/sign_upVM.dart';
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
                      TEXT(
                        text: 'Verify Fingerprint',
                        color: Constants.purple,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TEXT(
                        text: 'Place your Thumb on the',
                        color: Constants.purple,
                      ),
                      TEXT(
                        text: 'Fingerprint sensor',
                        color: Constants.purple,
                      )
                    ],
                  ),
                  BTN(
                      margin: EdgeInsets.only(),
                      children: [
                        TEXT(
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
