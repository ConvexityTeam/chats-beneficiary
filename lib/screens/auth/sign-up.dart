import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/models/beneficiary_user_model.dart';
import 'package:CHATS/router.dart';
// import 'package:CHATS/screens/Home/view_models/sign_upVM.dart';
import 'package:CHATS/screens/Home/view_models/base_view_model.dart';
import 'package:CHATS/screens/Home/view_models/sign_upVM.dart';
import 'package:CHATS/services/streams.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/otp_pin.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/utils/validators.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS/widgets/policy_dialog.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:snack/snack.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late Map localeInfo;
  late String localeDialCode;
  SignUpPasswordController _signUpPassService = SignUpPasswordController(
      initialValues: {"strength": 0.0, "password": ''});

  @override
  void initState() {
    super.initState();
    // passwordController = new TextEditingController(text: '');
    localeInfo = {
      'country_name': 'Nigeria',
      'country_code': 'NG',
    };
    localeDialCode = '+234';

    // Show the user a prominent location disclosure pop up

    shouldServiceEnabled();

    // getLocaleData();
  }

  @override
  void dispose() {
    _signUpPassService.dispose();
    super.dispose();
  }

  // Check if the service is enabled before showing dialog
  Future shouldServiceEnabled() async {
    bool _isEnabled = await new Location().serviceEnabled();

    // if (!_isEnabled) {
    bool isAllowed = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: MediaQuery.of(context).size.width * .75,
            height: MediaQuery.of(context).size.height * .54,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    'CHATS Beneficiary app collects location data to enable precise tracking of beneficiary location, to display available location based campaigns for beneficiary to opt into.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontFamily: 'Gilroy-medium',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 54,
                        onTap: () => Navigator.pop(context, false),
                        child: CustomText(
                          text: 'Deny',
                          fontFamily: 'Gilroy-medium',
                          textAlign: TextAlign.center,
                          color: Constants.usedGreen,
                        ),
                        borderColor: Constants.usedGreen,
                        bgColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        height: 54,
                        onTap: () => Navigator.pop(context, true),
                        child: CustomText(
                          text: 'Allow',
                          fontFamily: 'Gilroy-bold',
                          textAlign: TextAlign.center,
                          color: Colors.white,
                        ),
                        bgColor: Constants.usedGreen,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );

    if (!isAllowed) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: MediaQuery.of(context).size.width * .75,
              height: MediaQuery.of(context).size.height * .54,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: Text(
                      'To re-enable location access to this app, go to your settings, Under list of apps, select CHATS and enable location services for the CHATS app.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontFamily: 'Gilroy-medium',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomButton(
                    height: 54,
                    onTap: () => Navigator.pop(context, true),
                    child: CustomText(
                      text: 'Ok',
                      fontFamily: 'Gilroy-bold',
                      textAlign: TextAlign.center,
                      color: Colors.white,
                    ),
                    bgColor: Constants.usedGreen,
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      getLocaleData();
    }
    // }
  }

  ///a void function to verify if the Data provided is true
  Null Function(String) verify(SignUpVM model) {
    return (String pin) {
      bool validation = EmailAuth.validate(
          receiverMail: emailController.value.text, userOTP: pin);
      if (validation) {
        model.otpVerified = true;
      } else {
        model.otpVerified = false;
      }
    };
  }

  ///a void funtion to send the OTP to the user
  void sendOtp() async {
    EmailAuth.sessionName = "CHATS";
    bool result =
        await EmailAuth.sendOtp(receiverMail: emailController.value.text);
    if (result) {
      // setState(() {
      //   submitValid = true;
      // });
      print({"Email Auth resutl", result});
    }
  }

  getLocaleData() async {
    try {
      // throw new Error(); this line simulates an error to call the catch block of this try- catch statement
      var result = await locator<UserService>().getDeviceCountryNameAndCode();
      List countryData = await locator<UserService>().getCountryCodesList();
      Map codeData = countryData
          .singleWhere((data) => data['code'] == result['country_code']);

      setState(() {
        localeInfo = result;
        localeDialCode = codeData['dial_code'];
      });
    } catch (err) {
      print({"Error: ", err.toString()});
      try {
        // IF this is fired then use fall back implementation
        var fallBackData =
            await locator<UserService>().fallBackDeviceCountryNameAndCode();
        List countryData = await locator<UserService>().getCountryCodesList();
        Map codeData = countryData.singleWhere(
            (data) => data['code'] == fallBackData['country_code']);

        setState(() {
          localeInfo = fallBackData;
          localeDialCode = codeData['dial_code'];
        });
      } catch (err) {
        print({"NEsted try-catch error:", err});

        var snackBar = SnackBar(
          content: Text(
            'There was an error with getting your location, please make sure your location settings are allowed for this app before proceeding. Restarting the app might solve the issue',
          ),
          duration: Duration(seconds: 5),
        );
        snackBar.show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallH = size.height / 36;
    final smallW = size.height / 46;

    // ignore: non_constant_identifier_names

    print({
      "Country data",
      localeInfo,
      "Location: ${localeInfo['location']}",
      "State: ${localeInfo['state']}"
    });

    return BaseViewModel<SignUpVM>(
      providerReady: (model) async {
        // await shouldServiceEnabled();
        // bool isEnabled = await Location().serviceEnabled();
        // if (kDebugMode)
        //   print({
        //     'Pop up should come up please',
        //     isEnabled,
        //   });
      },
      builder: (context, provider, child) => WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          if (_formStage != 1) {
            setState(() {
              --_formStage;
            });
          } else
            Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          backgroundColor:
              ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                  ? Color.fromRGBO(250, 250, 250, 1)
                  : primaryColorDarkMode,
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
                            color: Constants.purple,
                          ),
                        ),
                        // Expanded(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Divider(
                        //       color: _formStage >= 2
                        //           ? Constants.purple
                        //           : Color.fromRGBO(196, 196, 196, 1),
                        //       height: 2,
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   child: Icon(Icons.check, color: Colors.white),
                        //   decoration: BoxDecoration(
                        //     border: _formStage >= 2
                        //         ? Border.all(style: BorderStyle.none)
                        //         : Border.all(width: 2, color: Constants.purple),
                        //     color: _formStage >= 2
                        //         ? Constants.purple
                        //         : Colors.white,
                        //     shape: BoxShape.circle,
                        //   ),
                        // ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: _formStage >= 3
                                  ? Constants.purple
                                  : Color.fromRGBO(196, 196, 196, 1),
                              height: 2,
                            ),
                          ),
                        ),
                        Container(
                          child: Icon(Icons.check, color: Colors.white),
                          decoration: BoxDecoration(
                            border: _formStage >= 3
                                ? Border.all(style: BorderStyle.none)
                                : Border.all(width: 2, color: Constants.purple),
                            color: _formStage >= 3
                                ? Constants.purple
                                : Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildStage(smallH, smallW, provider, context)!
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget personInformation(
      double smallH, double smallW, SignUpVM model, BuildContext context) {
    return Form(
      key: myKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: 'Personal Information',
            fontFamily: 'Gilroy-bold',
            fontSize: smallW * 1.6,
            edgeInset: EdgeInsets.only(bottom: smallH * 2),
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          CustomTextField(
            controller: emailController,
            label: CustomText(
              text: 'Email',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            validateFn: (val) => Validators.validateEmail(val?.trim()),
            hintText: '',
          ),
          CustomTextField(
            controller: phoneController,
            label: CustomText(
              text: 'Phone Number',
              fontSize: 16,
              fontFamily: 'Gilroy-Medium',
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            validateFn: (val) => Validators.validatePhone(val?.trim()),
            hintText: '',
            prefixText: localeDialCode,
          ),
          StreamBuilder<Map<String, dynamic>>(
            stream: _signUpPassService.stream$,
            builder: (contet, snap) {
              return Column(
                children: [
                  CustomTextField(
                    // controller: passwordController,
                    onChanged: _signUpPassService.onPasswordChange,
                    label: CustomText(
                      text: 'Password',
                      fontSize: 16,
                      fontFamily: 'Gilroy-Medium',
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                    validateFn: (val) => Validators.validatePassword(val),
                    hintText: '',
                  ),
                  FlutterPasswordStrength(
                    password: snap.data?['password'],
                    strengthCallback: _signUpPassService.onStrengthChange,
                  ),
                ],
              );
            },
          ),

          // CustomTextField(
          //   controller: locationController,
          //   label: CustomText(
          //     text: 'Locaion',
          //     fontSize: 16,
          //     fontFamily: 'Gilroy-Medium',
          //     color: ThemeBuilder.of(context)!.getCurrentTheme() ==
          //             Brightness.light
          //         ? Colors.black
          //         : Colors.white,
          //   ),
          //   validateFn: (val) {
          //     if (val!.isEmpty) return 'Cannot be empty';
          //   },
          //   hintText: 'Please enter your location',
          // ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: CustomButton(
              margin: EdgeInsets.zero,
              children: [
                CustomText(
                  text: 'Next',
                  fontSize: 16,
                  fontFamily: 'Gilroy-bold',
                  color: Colors.white,
                  edgeInset: EdgeInsets.zero,
                )
              ],
              onTap: () async {
                if (localeInfo["location"] == null) {
                  await getLocaleData();
                }
                print({
                  localeInfo['location'],
                  localeInfo['location']['longitude'],
                });
                myKey.currentState!.save();
                if (myKey.currentState!.validate() &&
                    _signUpPassService.initialValues['strength'] >= 0.75) {
                  model.user = BeneficiaryUser(
                    // firstName: firstNameController.text.trim(),
                    // lastName: lastNameController.text.trim(),
                    email: emailController.text.trim(),
                    phone:
                        '$localeDialCode${phoneController.text.substring(0, 3)}${phoneController.text.substring(3, 6)}${phoneController.text.substring(6, 10)}',
                    password: _signUpPassService.initialValues['password'],
                    address: localeInfo['address'] ?? 'Not set',
                    country: localeInfo['country_name'],
                    location: jsonEncode({
                      'coordinates': [
                        localeInfo['location']['longitude'],
                        localeInfo['location']['latitude']
                      ],
                      'country': localeInfo['country_name'],
                      'state': localeInfo['state']
                    }),
                    state: localeInfo['state'],
                    // gender: _genderDropdownValue.toLowerCase(),
                    // dob: _selectedDate,
                  );

                  setState(() {
                    _formStage = 3;
                  });
                  // sendOtp();
                } else if (_signUpPassService.initialValues['strength'] <
                    0.75) {
                  return SnackBar(
                    content: Text('Password is not strong enough'),
                  ).show(context);
                }
              },
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Already have an account? ",
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              GestureDetector(
                child: CustomText(
                  text: 'Log in',
                  color: Constants.usedGreen,
                  fontFamily: 'Gilroy-medium',
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, login);
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "By creating an account, you are agreeing to our\n",
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                    text: "Terms & Conditions ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // OPen dialog with terms and conditions
                        showDialog(
                            context: context,
                            builder: (context) {
                              return PolicyDialog(mdFileName: 'toc.md');
                            });
                      }),
                TextSpan(text: 'and ', style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: "Privacy Policy!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Open dialog with privacy policy
                        showDialog(
                            context: context,
                            builder: (context) {
                              return PolicyDialog(
                                  mdFileName: 'privacy_policy.md');
                            });
                      })
              ],
            ),
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
            onSubmit: verify(model),
            fields: 6,
          ),
        ),
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
                    text: "Resend Email",
                    color: Constants.purple,
                    fontSize: height / 1.5),
                onTap: () {
                  sendOtp();
                },
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _formStage = 1;
            });
          },
          child: CustomText(
            text: "Wrong email?",
            fontSize: height / 1.5,
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: CustomButton(
            margin: EdgeInsets.zero,
            children: [
              Expanded(
                  child: CustomText(
                text: 'Verify',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                edgeInset: EdgeInsets.zero,
              )),
              SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      !model.savingUser ? Constants.purple : Colors.black),
                ),
              )
            ],
            onTap: () {
              if (model.otpVerified) {
                model.user = BeneficiaryUser(
                  // firstName: firstNameController.text,
                  // lastName: lastNameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  password: _signUpPassService.initialValues['password'],
                  // gender: _genderDropdownValue.toLowerCase(),
                  // dob: _selectedDate,
                );
                setState(() {
                  _formStage = 3;
                });
              } else {
                model.errorMessage = 'Error OTP not verified';
              }
            },
            mainAxisAlignment: model.savingUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
          ),
        )
      ],
    );
  }

  bool pictureUploaded = false;
  bool idUploaded = false;
  File? userImage;

  Widget buildIdentityVerification(
      double height, SignUpVM model, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          text: '',
          fontFamily: 'Gilroy-bold',
          fontSize: height,
          edgeInset: EdgeInsets.only(bottom: height * 2, top: height),
        ),
        // Text(model.signUpErrorMessage, style: TextStyle(color: Colors.red)),
        GestureDetector(
          child: _buildCard(
              Icons.camera_alt_rounded,
              'Take a Picture',
              'Take a clear selfie showing your face. Avoid group picture',
              height,
              pictureUploaded),
          onTap: () async {
            PickedFile? file = await ImagePicker().getImage(
              source: kDebugMode ? ImageSource.gallery : ImageSource.camera,
              preferredCameraDevice: CameraDevice.front,
              maxHeight: 720,
              maxWidth: 720,
            );
            if (file != null) {
              setState(() {
                pictureUploaded = true;
                userImage = File(file.path);
              });
              // String base64Image =
              //     base64Encode(file.readAsBytesSync());
              model.profilePicture = userImage!;
            } else {
              // User canceled the picker
              final bar = SnackBar(
                content: Text('The image capture process has been terminated'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
              );
              bar.show(context);
            }
          },
        ),
        model.loading
            ? CircularProgressIndicator.adaptive()
            : SizedBox(
                width: double.infinity,
                height: 52,
                child: CustomButton(
                  margin: EdgeInsets.zero,
                  children: [
                    CustomText(
                      color: Colors.white,
                      text: 'Register',
                      edgeInset: EdgeInsets.zero,
                      fontFamily: 'Gilroy-bold',
                    )
                  ],
                  onTap: () async {
                    try {
                      if (pictureUploaded == false) {
                        final bar = SnackBar(
                          content: Text(
                              'Please kindly take a selfie picture, for your profile'),
                          duration: Duration(seconds: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(10),
                        );
                        bar.show(context);
                        return;
                      }

                      model.toggleLoader();
                      await model.register(context);
                      model.toggleLoader();
                      final bar = SnackBar(
                        content: Text(model.registerErrorMessage),
                        duration: Duration(seconds: 8),
                        action: SnackBarAction(
                            label: 'DISMISS',
                            onPressed: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                            }),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                      );
                      if (model.registerErrorMessage.isNotEmpty) {
                        bar.show(context);
                        setState(() {
                          _formStage = 1;
                        });
                      } else
                        return;
                      // Navigator.pushNamed(context, login);
                    } catch (err) {
                      model.toggleLoader();
                      print({"Error while registering", err});
                      final bar = SnackBar(
                        content: Text(err.toString()),
                        duration: Duration(seconds: 4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                      );
                      bar.show(context);
                      Navigator.pushNamed(context, login);
                    }
                  },
                ),
              ),
      ],
    );
  }

  // bool pictureUploaded = false;
  // bool idUploaded = false;

  Widget? buildStage(
      double height, double width, SignUpVM model, BuildContext context) {
    switch (_formStage) {
      case 1:
        return personInformation(height, width, model, context);
      // break;
      case 2:
        return buildOtp(height, model);
      // break;
      case 3:
        return buildIdentityVerification(height, model, context);
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
            : const Text(''),
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
        ],
      ),
    );
  }

  TextEditingController emailController = new TextEditingController(text: '');
  TextEditingController phoneController = new TextEditingController(text: '');

  TextEditingController locationController =
      new TextEditingController(text: '');
  TextEditingController otpController = new TextEditingController(text: '');
  final myKey = GlobalKey<FormState>();
  int _formStage = 1;
}
