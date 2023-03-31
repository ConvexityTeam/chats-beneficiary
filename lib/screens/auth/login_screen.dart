import 'package:CHATS/router.dart';
import 'package:CHATS/screens/Home/view_models/base_view_model.dart';
import 'package:CHATS/screens/Home/view_models/sign_upVM.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/utils/validators.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS/widgets/policy_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snack/snack.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final myKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallH = size.height / 36;
    final smallW = size.height / 46;
    return BaseViewModel<SignUpVM>(
      providerReady: (provider) {},
      builder: (context, provider, child) => WillPopScope(
        onWillPop: () => onBackPressed(context),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                            Brightness.light
                        ? Constants.usedGreen
                        : Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.4,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: smallW + 12,
                            left: smallW + 12,
                          ),
                          child: Image(
                            image: AssetImage(ThemeBuilder.of(context)!
                                        .getCurrentTheme() ==
                                    Brightness.light
                                ? 'assets/images/chats_login_transparent.png'
                                : 'assets/images/chats_login_transparent_green.png'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: size.height * 0.6,
                          // width: double.infinity,
                          padding: EdgeInsets.only(
                            // top: size.height / 8,
                            top: smallH * 2,
                            right: smallW,
                            left: smallW,
                            // bottom: smallW,
                          ),
                          child: Form(
                            key: myKey,
                            child: SingleChildScrollView(
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: CustomText(
                                      edgeInset: EdgeInsets.all(0),
                                      text: provider.errorMessage,
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                  CustomTextField(
                                    controller: emailController,
                                    label: CustomText(
                                      // TODO: re-enable phone number after backend fix -  / Phone Number
                                      text: 'Email',
                                      fontFamily: 'Gilroy-medium',
                                      color: ThemeBuilder.of(context)!
                                                  .getCurrentTheme() ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    validateFn: (val) =>
                                        Validators.validateEmail(val?.trim()),
                                  ),
                                  CustomTextField(
                                    controller: passController,
                                    isPassword: hidePassword,
                                    label: CustomText(
                                      text: 'Password',
                                      fontFamily: 'Gilroy-Medium',
                                      color: ThemeBuilder.of(context)!
                                                  .getCurrentTheme() ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    suffixIcon: GestureDetector(
                                      child: Image.asset(
                                        hidePassword
                                            ? 'assets/icons/hide.png'
                                            : 'assets/icons/show.png',
                                        color: ThemeBuilder.of(context)!
                                                    .getCurrentTheme() ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      onTap: () {
                                        // Navigator.pushNamed(context, 'onboard');
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                    ),
                                    validateFn: (val) =>
                                        Validators.validatePassword(val),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: GestureDetector(
                                      child: CustomText(
                                        text: 'Forgot Password?',
                                        color: ThemeBuilder.of(context)!
                                                    .getCurrentTheme() ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        textAlign: TextAlign.right,
                                        fontFamily: 'Gilroy-medium',
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, resetPassword);
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                          // margin: EdgeInsets.zero,
                                          height: 52,
                                          bgColor: Constants.usedGreen,
                                          padding: EdgeInsets.only(right: 10),
                                          child: CustomText(
                                            text: 'Log in',
                                            color: Colors.white,
                                            textAlign: TextAlign.center,
                                            fontFamily: 'Gilroy-bold',
                                            fontSize: 16,
                                            edgeInset: EdgeInsets.zero,
                                          ),
                                          onTap: () async {
                                            if (myKey.currentState!
                                                .validate()) {
                                              await provider.login(
                                                emailController.text.trim(),
                                                passController.text,
                                                context,
                                              );

                                              final bar = SnackBar(
                                                content:
                                                    Text(provider.errorMessage),
                                                duration: Duration(seconds: 4),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(10),
                                              );
                                              if (provider
                                                  .errorMessage.isNotEmpty)
                                                bar.show(context);
                                            }
                                          },
                                          mainAxisAlignment: provider.isBusy
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.center,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      CustomButton(
                                        height: 52,
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        borderColor: Constants.usedGreen,
                                        bgColor: Colors.grey.withOpacity(.3),
                                        children: [
                                          Icon(Icons.fingerprint_outlined,
                                              color: Constants.usedGreen)
                                        ],
                                        onTap: () async {
                                          bool? isAuthenticated = await provider
                                              .shouldAuthenticate(context);
                                          if (isAuthenticated != null &&
                                              !isAuthenticated) {
                                            final snackBar = SnackBar(
                                              content: Text(
                                                  'Authentication error occurred or you need to setup authentication after login'),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.all(20),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            );
                                            snackBar.show(context);
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                  // SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: "Don't have an account? ",
                                        color: ThemeBuilder.of(context)!
                                                    .getCurrentTheme() ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      GestureDetector(
                                        child: CustomText(
                                          text: 'Sign up',
                                          color: Constants.usedGreen,
                                          fontFamily: 'Gilroy-medium',
                                        ),
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            signUp,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  // SizedBox(height: 12),
                                  Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text:
                                            "By logging in, you are agreeing to our\n",
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
                                                        return PolicyDialog(
                                                            mdFileName:
                                                                'toc.md');
                                                      });
                                                }),
                                          TextSpan(
                                              text: 'and ',
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: "Privacy Policy!",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Open dialog with privacy policy
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return PolicyDialog(
                                                            mdFileName:
                                                                'privacy_policy.md');
                                                      });
                                                }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20)
                                ],
                              ),
                            ),
                          ),
                          // padding: EdgeInsets.only(top: smallH * 2),
                          decoration: BoxDecoration(
                            color:
                                ThemeBuilder.of(context)!.getCurrentTheme() ==
                                        Brightness.light
                                    ? Colors.white
                                    : primaryColorDarkMode,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool hidePassword = true;

  TextEditingController emailController = new TextEditingController(text: '');

  TextEditingController passController = new TextEditingController(text: '');
}
