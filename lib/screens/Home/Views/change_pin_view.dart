import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:snack/snack.dart';

class ChangePINView extends StatefulWidget {
  const ChangePINView({Key? key}) : super(key: key);

  @override
  _ChangePINViewState createState() => _ChangePINViewState();
}

class _ChangePINViewState extends State<ChangePINView> {
  late TextEditingController _oldPINController;
  late TextEditingController _newPINController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _oldPINController = TextEditingController();
    _newPINController = TextEditingController();
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
          text: 'Change PIN',
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
        color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
            ? Colors.white
            : primaryColorDarkMode,
        width: double.infinity,
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _oldPINController,
                isPassword: hidePassword,
                keyboardType: TextInputType.number,
                label: CustomText(
                  text: 'Old PIN',
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
                  if (val.length != 4) return "Your PIN must be 4 digits";
                },
              ),
              CustomTextField(
                controller: _newPINController,
                isPassword: hidePassword,
                keyboardType: TextInputType.number,
                label: CustomText(
                  text: 'New PIN',
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
                  if (val.length != 4) return "Your PIN must be 4 digits";
                },
              ),
              SizedBox(
                height: 52,
                child: CustomButton(
                  margin: EdgeInsets.zero,
                  child: CustomText(
                    text: 'Change PIN',
                    fontFamily: 'Gilroy-medium',
                    edgeInset: EdgeInsets.zero,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () async {
                    print({
                      _oldPINController.value.text,
                      _newPINController.value.text,
                    });
                    formKey.currentState?.save();
                    //* check if the old pin matches the already added pin

                    if (formKey.currentState!.validate()) {
                      // if (_oldPINController.value.text !=
                      //     locator<UserService>().userDetails!.pin) {
                      //   // print(locator<UserService>().userDetails!.pin);
                      //   final bar = SnackBar(
                      //       content: Text('Your Old PIN is not correct'));
                      //   bar.show(context);
                      //   print('Old pin not correct error');

                      //   return;
                      // }
                      String? service = await locator<UserService>().updatePIN(
                          _oldPINController.text, _newPINController.text);
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
    );
  }

  @override
  void dispose() {
    _oldPINController.dispose();
    _newPINController.dispose();
    super.dispose();
  }

  bool hidePassword = true;
}
