import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:snack/snack.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late TextEditingController _oldPassController;
  late TextEditingController _newPassController;
  late TextEditingController _confirmPassController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _oldPassController = TextEditingController();
    _newPassController = TextEditingController();
    _confirmPassController = TextEditingController();
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
          text: 'Change Password',
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
          icon: Icon(Icons.arrow_back_ios,
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
            ? Colors.white
            : primaryColorDarkMode,
        width: double.infinity,
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  controller: _oldPassController,
                  isPassword: hidePassword,
                  label: CustomText(
                    text: 'Old Password',
                    edgeInset: EdgeInsets.zero,
                    color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  suffixIcon: GestureDetector(
                    child: Image.asset(
                      hidePassword
                          ? 'assets/icons/hide.png'
                          : 'assets/icons/show.png',
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
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
                  validateFn: (val) {
                    if (val!.isEmpty) return "This field cannot be empty";
                  },
                ),
                CustomTextField(
                  controller: _newPassController,
                  isPassword: hidePassword,
                  label: CustomText(
                    text: 'New Password',
                    edgeInset: EdgeInsets.zero,
                    color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  suffixIcon: GestureDetector(
                    child: Image.asset(
                        hidePassword
                            ? 'assets/icons/hide.png'
                            : 'assets/icons/show.png',
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white),
                    onTap: () {
                      // Navigator.pushNamed(context, 'onboard');
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                  validateFn: (val) {
                    if (val!.isEmpty) return "This field cannot be empty";
                  },
                ),
                CustomTextField(
                  controller: _confirmPassController,
                  isPassword: hidePassword,
                  label: CustomText(
                      text: 'Comfirm Password',
                      edgeInset: EdgeInsets.zero,
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white),
                  suffixIcon: GestureDetector(
                    child: Image.asset(
                      hidePassword
                          ? 'assets/icons/hide.png'
                          : 'assets/icons/show.png',
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
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
                  validateFn: (val) {
                    if (val!.isEmpty) return "This field cannot be empty";
                  },
                ),
                SizedBox(
                  height: 52,
                  child: CustomButton(
                    margin: EdgeInsets.zero,
                    child: CustomText(
                      text: 'Change Password',
                      fontFamily: 'Gilroy-medium',
                      edgeInset: EdgeInsets.zero,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () async {
                      print({
                        _oldPassController.value.text,
                        _newPassController.value.text,
                        _confirmPassController,
                      });

                      formKey.currentState!.save();
                      if (formKey.currentState!.validate()) {
                        if (_confirmPassController.value.text !=
                            _newPassController.value.text) {
                          // print(locator<UserService>().userDetails!.pin);
                          final bar = SnackBar(
                              content:
                                  Text('Your confirm password does not match'));
                          bar.show(context);
                          print('confirm password match error');

                          return;
                        }
                        String? service =
                            await locator<UserService>().updatePassword(
                          _oldPassController.value.text,
                          _newPassController.value.text,
                          _confirmPassController.value.text,
                        );

                        final bar = SnackBar(content: Text('$service'));
                        bar.show(context);
                        print(service);
                        Navigator.pop(context);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _oldPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  bool hidePassword = true;
}
