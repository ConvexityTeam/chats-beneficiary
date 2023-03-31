import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/validators.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:snack/snack.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _otpController;
  late TextEditingController _newPassController;
  late TextEditingController _confirmNewPassController;
  late PageController _pageController;
  late String? ref;
  final formKey = GlobalKey<FormState>();
  final newPassFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _otpController = TextEditingController();
    _newPassController = TextEditingController();
    _confirmNewPassController = TextEditingController();
    _pageController = PageController();
    ref = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        title: CustomText(
          text: 'Reset Password',
          fontFamily: 'Gilroy-medium',
          fontSize: 22,
          edgeInset: EdgeInsets.zero,
          textAlign: TextAlign.left,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
            ? Colors.white
            : primaryColorDarkMode,
        child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Optional if phone is set',
                      label: CustomText(
                        text: 'Enter registered email',
                        edgeInset: EdgeInsets.zero,
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      validateFn: (val) => _phoneController.text.isEmpty
                          ? Validators.validateEmail(val?.trim())
                          : null,
                    ),
                    CustomTextField(
                      controller: _phoneController,
                      hintText: 'optional if email is set',
                      label: CustomText(
                        text: 'Enter registered phone number',
                        edgeInset: EdgeInsets.zero,
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      validateFn: (val) {
                        if (_emailController.text.isEmpty)
                          Validators.validatePhone(val?.trim());

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 52,
                      child: CustomButton(
                        margin: EdgeInsets.zero,
                        child: CustomText(
                          text: 'Send Reset Request',
                          fontFamily: 'Gilroy-medium',
                          edgeInset: EdgeInsets.zero,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                        onTap: () async {
                          print({
                            _emailController.value.text,
                            _phoneController.value.text,
                          });

                          formKey.currentState!.save();
                          if (formKey.currentState!.validate()) {
                            Map? service = await locator<UserService>()
                                .resetUserPasswordReq(
                              _emailController.value.text,
                              _phoneController.value.text,
                            );

                            if (service!['status'] == "success") {
                              setState(() {
                                ref = service['data']['ref'];
                              });
                              final bar = SnackBar(
                                content: Text(service['message']),
                                duration: Duration(seconds: 4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                              );
                              bar.show(context);
                              print(service);
                              // Navigate user to the next page
                              _pageController.nextPage(
                                  duration: Duration(microseconds: 300),
                                  curve: Curves.linear);
                            } else {
                              final bar = SnackBar(
                                content: Text(service['message'] ??
                                    'An error occured with the request please check network connectivity and try again'),
                                duration: Duration(seconds: 4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                              );
                              bar.show(context);
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              Form(
                key: newPassFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _otpController,
                      hintText: 'Enter OTP sent to email or phone',
                      label: CustomText(
                        text: 'Enter OTP',
                        edgeInset: EdgeInsets.zero,
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      validateFn: (val) {
                        if (val!.isEmpty) return "This field cannot be empty";
                      },
                    ),
                    CustomTextField(
                      controller: _newPassController,
                      hintText: 'New password',
                      label: CustomText(
                        text: 'Enter a new password',
                        edgeInset: EdgeInsets.zero,
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      validateFn: (val) {
                        if (val!.isEmpty) return "This field cannot be empty";
                      },
                    ),
                    CustomTextField(
                      controller: _confirmNewPassController,
                      hintText: 'Re-Enter your new password to confirm',
                      label: CustomText(
                        text: 'Confirm your new password',
                        edgeInset: EdgeInsets.zero,
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      validateFn: (val) {
                        if (val!.isEmpty) return "This field cannot be empty";
                      },
                    ),
                    SizedBox(
                      height: 52,
                      child: CustomButton(
                        margin: EdgeInsets.zero,
                        child: CustomText(
                          text: 'Reset Password',
                          fontFamily: 'Gilroy-medium',
                          edgeInset: EdgeInsets.zero,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          print({
                            _otpController.value.text,
                            _newPassController.value.text,
                            _confirmNewPassController,
                          });

                          newPassFormKey.currentState!.save();
                          if (newPassFormKey.currentState!.validate()) {
                            Map? service = await locator<UserService>()
                                .resetUserPasswordSetnew(
                              ref,
                              _otpController.value.text,
                              _newPassController.value.text,
                              _confirmNewPassController.value.text,
                            );

                            if (service!['status'] == "success") {
                              final bar = SnackBar(
                                content: Text(service['message']),
                                duration: Duration(seconds: 4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                              );
                              bar.show(context);
                              print(service);
                              // Navigate user to the login page
                              Navigator.pushReplacementNamed(context, login);
                            } else {
                              final bar = SnackBar(
                                content: Text(service['message'] ??
                                    'An error occured with the request please check network connectivity and try again'),
                                duration: Duration(seconds: 4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                              );
                              bar.show(context);
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
