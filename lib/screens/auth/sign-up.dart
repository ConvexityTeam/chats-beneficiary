import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/screens/home/view_models/base_view_model.dart';
import 'package:CHATS/screens/home/view_models/sign_upVM.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/otp_pin.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String _genderDropdownValue = 'Male';
  String _selectedDate = '';

  ///a void function to verify if the Data provided is true
  void verify(String pin) {
    print(EmailAuth.validate(
        receiverMail: emailController.value.text, userOTP: pin));
  }

  ///a void funtion to send the OTP to the user
  void sendOtp() async {
    EmailAuth.sessionName = "Company Name";
    bool result =
        await EmailAuth.sendOtp(receiverMail: emailController.value.text);
    if (result) {
      // setState(() {
      //   submitValid = true;
      // });
    }
  }

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
          CustomText(
            text: 'Personal Information',
            fontFamily: 'Gilroy-bold',
            fontSize: smallH * 1.5,
            edgeInset: EdgeInsets.only(bottom: smallH * 2),
          ),
          CustomTextField(
            controller: firstNameController,
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            label: CustomText(
              text: 'First Name',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
            ),
            hintText: 'Juliana',
          ),
          CustomTextField(
            controller: lastNameController,
            label: CustomText(
              text: 'Last Name',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
            ),
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            hintText: 'Orji',
          ),
          CustomTextField(
            controller: emailController,
            label: CustomText(
              text: 'Email',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
            ),
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            hintText: 'Julianamonday@gmail.com',
          ),
          CustomTextField(
            controller: phoneController,
            label: CustomText(
              text: 'Phone Number',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
            ),
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            hintText: '09065233507',
          ),
          CustomTextField(
            controller: passwordController,
            label: CustomText(
              text: 'Password',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
            ),
            validateFn: (val) {
              if (val.isEmpty) return 'Cannot be empty';
            },
            hintText: 'Vend3cret',
          ),
          DropdownButton<String>(
            value: _genderDropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.green),
            underline: Container(
              height: 2,
              color: Colors.green,
            ),
            onChanged: (String newValue) {
              setState(() {
                _genderDropdownValue = newValue;
              });
            },
            items: <String>[
              'Male',
              'Female',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          FlatButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1940, 3, 5),
                    maxTime: DateTime.now(),
                    onChanged: (date) {}, onConfirm: (date) {
                  print('change $date');

                  setState(() {
                    DateFormat dateFormat = DateFormat('MMMM-d-yyyy');
                    var formattedDate = dateFormat.format(date);
                    _selectedDate = formattedDate;
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Text(
                _selectedDate.isEmpty ? 'Pick Birthday' : _selectedDate,
                style: TextStyle(color: Colors.blue),
              )),
          CustomButton(
              children: [
                CustomText(
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
                  sendOtp();
                }
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: "Already have an account?"),
              GestureDetector(
                child: CustomText(
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
            CustomText(
              text: 'OTP Verification',
              fontFamily: 'Gilroy-bold',
              fontSize: height * 1.5,
              edgeInset: EdgeInsets.only(bottom: height * 1.3),
            ),
            CustomText(
              text: 'Enter the OTP sent to your email',
              fontWeight: FontWeight.w300,
              edgeInset: EdgeInsets.only(bottom: height * 1.3),
            ),
          ],
        ),
        Container(
            padding: EdgeInsets.only(top: height * 5, bottom: height * 5),
            child: OTPPin(
              showFieldAsBox: false,
              onSubmit: verify,
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
        CustomButton(
            margin: EdgeInsets.only(top: height * 3),
            children: [
              Expanded(
                  child: CustomText(
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
              model.user = BeneficiaryUser(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  password: passwordController.text,
                  gender: _genderDropdownValue.toLowerCase(),
                  dob: _selectedDate);
              Navigator.pushNamed(context, personalInfo);
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
    }
  }

  Container _buildCard(
      IconData icon, String title, String body, double height, bool uploaded) {
    return Container(
      padding: EdgeInsets.only(top: 18, bottom: 18),
      child: ListTile(
        isThreeLine: true,
        leading: Icon(icon, color: Constants.purple, size: height * 2),
        title: CustomText(
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
        subtitle: CustomText(
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
  TextEditingController otpController = new TextEditingController(text: '');
  final myKey = GlobalKey<FormState>();
  int _formStage = 1;
}
