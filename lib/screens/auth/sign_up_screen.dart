import 'package:CHATS/screens/home/view_models/base_view_model.dart';
import 'package:CHATS/screens/home/view_models/sign_upVM.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/otp_pin.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/home/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
          body: ListView(
            padding: EdgeInsets.only(
                top: smallH * 2,
                right: smallW,
                left: smallW,
                bottom: smallH * 3),
            children: [
              Center(
                child: Container(
                  child: Image.asset('assets/logo.png', width: smallW * 7),
                  margin: EdgeInsets.only(bottom: smallH * 1.2),
                ),
              ),
              buildStage(smallH, provider)
            ],
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
          CustomText(
            text: 'Vendor Information',
            fontFamily: 'Gilroy-bold',
            fontSize: smallH * 1.5,
            edgeInset: EdgeInsets.only(bottom: smallH),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Logged In ',
                fontFamily: 'Gilroy-bold',
                fontSize: 20,
              ),
              GestureDetector(
                child: CustomText(
                  text: 'Change Account?',
                  fontFamily: 'Gilroy-bold',
                  color: Constants.newPurple,
                  fontSize: 20,
                ),
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: smallH,
          ),
          CustomTextField(
            controller: firstNameController,
            onSaved: (val) {
              // userModel.first_name = val;
            },
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            label: CustomText(
              text: 'Business Name',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
            ),
            hintText: 'CHAT',
          ),
          CustomTextField(
            controller: lastNameController,
            onSaved: (val) {
              // userModel.last_name = val;
            },
            label: CustomText(
              text: 'Email',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
            ),
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            hintText: 'example@example.com',
          ),
          CustomTextField(
            controller: emailController,
            onSaved: (val) {
              // userModel.email = val;
            },
            label: CustomText(
              text: 'Phone Number',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
            ),
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            hintText: '081000XXXXX',
          ),
          CustomTextField(
            controller: phoneController,
            onSaved: (val) {
              // userModel.phone = val;
            },
            label: CustomText(
                text: 'BVN', fontSize: 16, fontFamily: 'Gilroy-Medium'),
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            hintText: '123XXXXXX',
          ),
          // CustomButton(
          //     margin: EdgeInsets.only(right: 0, left: 0, top: smallH),
          //     children: [
          //       CustomText(
          //           text: 'Submit',
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //           edgeInset: EdgeInsets.all(0.0))
          //     ],
          //     onTap: () {
          //       myKey.currentState.save();
          //       if (myKey.currentState.validate()) {
          //         setState(() {
          //           _formStage = 2;
          //         });
          //       }
          //     })
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
            CustomText(
              text: 'OTP Verification',
              fontFamily: 'Gilroy-bold',
              fontSize: height * 1.5,
              edgeInset: EdgeInsets.only(bottom: height * 1.3),
            ),
            CustomText(
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
              CustomText(
                text: "Didn't receive the OTP?  ",
                fontSize: height / 1.5,
              ),
              GestureDetector(
                  child: CustomText(
                      text: "Resend SMS",
                      color: Constants.purple,
                      fontSize: height / 1.5),
                  onTap: () {}),
            ],
          ),
        ),
        CustomText(text: "Wrong phone number?", fontSize: height / 1.5),
        // CustomButton(
        //     margin: EdgeInsets.only(top: height * 3),
        //     children: [
        //       Expanded(
        //           child: CustomText(
        //         text: 'Verify',
        //         color: Colors.black,
        //         fontWeight: FontWeight.bold,
        //         textAlign: TextAlign.center,
        //         edgeInset: EdgeInsets.all(0.0),
        //       )),
        //       SizedBox(
        //           height: 18,
        //           width: 18,
        //           child: CircularProgressIndicator(
        //               strokeWidth: 2,
        //               valueColor: AlwaysStoppedAnimation<Color>(
        //                   !model.savingUser ? Constants.purple : Colors.black)))
        //     ],
        //     onTap: () {
        //       model.register(userModel, context);
        //     },
        //     mainAxisAlignment: model.savingUser
        //         ? MainAxisAlignment.end
        //         : MainAxisAlignment.center)
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

  TextEditingController firstNameController =
      new TextEditingController(text: '');
  TextEditingController lastNameController =
      new TextEditingController(text: '');
  TextEditingController emailController = new TextEditingController(text: '');
  TextEditingController phoneController = new TextEditingController(text: '');
  TextEditingController passwordController =
      new TextEditingController(text: '');

  // VendorUserModel userModel = new VendorUserModel();

  final myKey = GlobalKey<FormState>();
  int _formStage = 1;
}
