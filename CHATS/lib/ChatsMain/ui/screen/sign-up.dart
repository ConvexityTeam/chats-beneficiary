// import 'dart:io';

// import 'package:CHATS/core/utils/otp_pin.dart';

// import 'package:file_picker/file_picker.dart';

// import 'package:CHATS/Chats%20Main/core/models/bene_user.dart';

import 'package:CHATS/ChatsMain/core/models/beneficiary_user_model.dart';
import 'package:CHATS/ChatsMain/core/utils/otp_pin.dart';
import 'package:CHATS/ChatsMain/ui/shared/BTN.dart';
import 'package:CHATS/ChatsMain/ui/shared/TEXT.dart';
import 'package:CHATS/ChatsMain/ui/shared/TF.dart';
import 'package:CHATS/ChatsMain/ui/shared/ui_helper.dart';
import 'package:CHATS/ChatsMain/ui/viewModels/base_view_model.dart';
import 'package:CHATS/ChatsMain/ui/viewModels/sign_upVM.dart';
import 'package:flutter/material.dart';
// import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallH = size.height / 36;
    final smallW = size.height / 46;
    return BaseViewModel<SignUpVM>(
      providerReady: (model) {},
      builder: (context, provider, child) => WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          if (_formStage != 1) {
            setState(() {
              --_formStage;
            });
          } else
            Navigator.pop(context);
        },
        child: Scaffold(
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: smallH * 2,
                  right: smallW,
                  left: smallW,
                  bottom: smallH * 3),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      child: Image.asset(
                        'assets/logo.png',
                        width: smallW * 10,
                      ),
                      margin: EdgeInsets.only(bottom: smallH * 1.2),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: smallH * 1.2),
                    padding:
                        EdgeInsets.only(right: smallW * 4, left: smallW * 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Icon(Icons.check, color: Colors.white),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(style: BorderStyle.none),
                              color: Constants.purple),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: _formStage >= 2
                                  ? Constants.purple
                                  : Color.fromRGBO(196, 196, 196, 1),
                              height: 2,
                            ),
                          ),
                        ),
                        Container(
                          child: Icon(Icons.check, color: Colors.white),
                          decoration: BoxDecoration(
                            border: _formStage >= 2
                                ? Border.all(style: BorderStyle.none)
                                : Border.all(width: 2, color: Constants.purple),
                            color: _formStage >= 2
                                ? Constants.purple
                                : Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildStage(smallH, provider)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget personInformation(double smallH) {
    return Form(
      key: myKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TEXT(
            text: 'Personal Information',
            fontFamily: 'Gilroy-bold',
            fontSize: smallH * 1.5,
            edgeInset: EdgeInsets.only(bottom: smallH * 2),
          ),
          TF(
            controller: firstNameController,
            onSaved: (val) {
              userModel.first_name = val;
            },
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            label: TEXT(
              text: 'First Name',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
            ),
            hintText: 'Juliana',
          ),
          TF(
            controller: lastNameController,
            onSaved: (val) {
              userModel.last_name = val;
            },
            label: TEXT(
              text: 'Last Name',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
            ),
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            hintText: 'Orji',
          ),
          TF(
            controller: emailController,
            onSaved: (val) {
              userModel.email = val;
            },
            label: TEXT(
              text: 'Email',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
            ),
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            hintText: 'Julianamonday@gmail.com',
          ),
          TF(
            controller: phoneController,
            onSaved: (val) {
              userModel.phone = val;
            },
            label: TEXT(
              text: 'Phone Number',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
            ),
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            hintText: '09065233507',
          ),
          BTN(
              children: [
                TEXT(
                  text: 'Next',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  edgeInset: EdgeInsets.all(0.0),
                )
              ],
              onTap: () {
                myKey.currentState.save();
                if (myKey.currentState.validate()) {
                  setState(() {
                    _formStage = 2;
                  });
                }
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TEXT(text: "Already have an account?"),
              GestureDetector(
                child: TEXT(
                  text: 'Log in',
                  color: Constants.purple,
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'login');
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildOtp(double height, SignUpVM model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            TEXT(
              text: 'OTP Verification',
              fontFamily: 'Gilroy-bold',
              fontSize: height * 1.5,
              edgeInset: EdgeInsets.only(bottom: height * 1.3),
            ),
            TEXT(
              text: 'Enter the OTP sent to ********353',
              fontWeight: FontWeight.w300,
              edgeInset: EdgeInsets.only(bottom: height * 1.3),
            ),
          ],
        ),
        Container(
            padding: EdgeInsets.only(top: height * 5, bottom: height * 5),
            child: OTPPin(
              showFieldAsBox: false,
              fields: 6,
            )),
        Padding(
          padding: EdgeInsets.only(bottom: height / 1.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TEXT(
                text: "Didn't receive the OTP?  ",
                fontSize: height / 1.5,
              ),
              GestureDetector(
                  child: TEXT(
                      text: "Resend SMS",
                      color: Constants.purple,
                      fontSize: height / 1.5),
                  onTap: () {}),
            ],
          ),
        ),
        TEXT(text: "Wrong phone number?", fontSize: height / 1.5),
        BTN(
            margin: EdgeInsets.only(top: height * 3),
            children: [
              Expanded(
                  child: TEXT(
                text: 'Verify',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                edgeInset: EdgeInsets.all(0.0),
              )),
              SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          !model.savingUser ? Constants.purple : Colors.black)))
            ],
            onTap: () {
              model.register(userModel, context);
            },
            mainAxisAlignment: model.savingUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.center)
      ],
    );
  }

  bool pictureUploaded = false;
  bool idUploaded = false;

  Widget buildStage(double height, SignUpVM model) {
    switch (_formStage) {
      case 1:
        return personInformation(height);
        break;
      case 2:
        return buildOtp(height, model);
        break;
      default:
        return personInformation(height);
    }
  }

  Container _buildCard(
      IconData icon, String title, String body, double height, bool uploaded) {
    return Container(
      padding: EdgeInsets.only(top: 18, bottom: 18),
      child: ListTile(
        isThreeLine: true,
        leading: Icon(icon, color: Constants.purple, size: height * 2),
        title: TEXT(
          text: title,
          fontFamily: 'Gilroy-Medium',
          fontSize: 16,
        ),
        trailing: uploaded
            ? Container(
                child: Icon(Icons.check, color: Colors.white),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(style: BorderStyle.none),
                    color: Constants.purple),
              )
            : Text(''),
        subtitle: TEXT(
            text: body, fontSize: 12, color: Color.fromRGBO(85, 85, 85, 1)),
      ),
      margin: EdgeInsets.only(bottom: height),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border(
              bottom: BorderSide.none,
              top: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(174, 174, 192, 1),
                spreadRadius: 0.4,
                blurRadius: 20)
          ]),
    );
  }

  TextEditingController firstNameController =
      new TextEditingController(text: '');
  TextEditingController lastNameController =
      new TextEditingController(text: '');
  TextEditingController emailController = new TextEditingController(text: '');
  TextEditingController phoneController = new TextEditingController(text: '');
  TextEditingController passwordController =
      new TextEditingController(text: '');

  BeneficiaryUserModel userModel = new BeneficiaryUserModel();

  final myKey = GlobalKey<FormState>();
  int _formStage = 1;
}