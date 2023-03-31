import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:snack/snack.dart';

class SetPINView extends StatefulWidget {
  const SetPINView({Key? key}) : super(key: key);

  @override
  _SetPINViewState createState() => _SetPINViewState();
}

class _SetPINViewState extends State<SetPINView> {
  late TextEditingController _setPINController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _setPINController = TextEditingController();
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
          text: 'Set PIN',
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
        child: Column(
          children: [
            Form(
              key: formKey,
              child: CustomTextField(
                controller: _setPINController,
                isPassword: hidePassword,
                keyboardType: TextInputType.number,
                label: CustomText(
                  text: 'Set PIN',
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
                  if (val!.isEmpty) return "Field can't be empty";
                  if (val.length != 4)
                    return "Your pin must be 4 digit numbers";
                },
              ),
            ),
            SizedBox(
              height: 52,
              child: CustomButton(
                margin: EdgeInsets.zero,
                children: [
                  CustomText(
                    text: 'Set Transaction PIN',
                    fontFamily: 'Gilroy-medium',
                    edgeInset: EdgeInsets.zero,
                    color: Colors.white,
                  )
                ],
                onTap: () async {
                  print(_setPINController.value.text);
                  formKey.currentState!.save();
                  if (formKey.currentState!.validate()) {
                    String? response = await locator<UserService>()
                        .setUserPIN(_setPINController.value.text);
                    final bar = SnackBar(content: Text('$response'));
                    bar.show(context);
                    print(response);
                    Navigator.pop(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _setPINController.dispose();
    super.dispose();
  }

  bool hidePassword = true;
}
