import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/screens/Home/view_models/base_view_model.dart';
import 'package:CHATS/screens/Home/view_models/local_auth_vm.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:snack/snack.dart';

class SecurityView extends StatefulWidget {
  const SecurityView({Key? key}) : super(key: key);

  @override
  _SecurityViewState createState() => _SecurityViewState();
}

class _SecurityViewState extends State<SecurityView> {
  // bool? enableFP;
  // final keyStore = locator<SharedPref>();

  // @override
  // void initState() {
  //   super.initState();
  //   getFingerprintSettings();
  // }

  // getFingerprintSettings() async {
  //   bool? val = await keyStore.getFromDisk('isFingerprintEnabled');
  //   setState(() {
  //     if (val != null) {
  //       enableFP = val;
  //     } else {
  //       enableFP = false;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // print({enableFP, "The finger print saved boolean"});
    return BaseViewModel<LocalAuthVM>(
      providerReady: (provider) => provider.setUp(),
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
          title: CustomText(
            text: 'Security',
            fontFamily: 'Gilroy-medium',
            fontSize: 22,
            edgeInset: EdgeInsets.zero,
            textAlign: TextAlign.left,
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          centerTitle: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
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
              buildButton(
                text: 'Change Password',
                pressed: () {
                  Navigator.pushNamed(context, changePassword);
                },
              ),
              SizedBox(height: 20),
              buildButton(
                text: 'Create / Change Pin',
                pressed: () {
                  // check if the user has pin already

                  if (locator<UserService>().pin == null) {
                    Navigator.pushNamed(context, setPIN);
                  } else {
                    // if not then set pin
                    Navigator.pushNamed(context, changePIN);
                  }
                },
              ),
              SizedBox(height: 20),
              buildSwitchButton(
                context,
                text: 'Enable Fingerprint',
                pressed: (bool? value) async {
                  bool? service = await provider.toggle(value!, context);
                  if (service!) {
                    final snackBar = SnackBar(
                      content: Text('Authenticated Successfuly!'),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    );
                    snackBar.show(context);
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Authentication Disabled!'),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    );
                    snackBar.show(context);
                  }
                },
                provider: provider,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton({
    required String text,
    required Function pressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: '$text',
              fontFamily: 'Gilroy-medium',
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
              edgeInset: EdgeInsets.zero,
            ),
            Icon(Icons.arrow_forward_ios_outlined,
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white),
          ],
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(
                width: 1.4,
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Color.fromRGBO(153, 153, 153, 1)
                    : Colors.white),
          ),
          overlayColor: MaterialStateProperty.all(Colors.grey[200]),
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15)),
        ),
        onPressed: () => pressed(),
      ),
    );
  }

  Widget buildSwitchButton(BuildContext context,
      {required String text,
      required Function pressed,
      LocalAuthVM? provider}) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: '$text',
              fontFamily: 'Gilroy-medium',
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
              edgeInset: EdgeInsets.zero,
            ),
            Switch.adaptive(
              value: provider!.isEnabled,
              activeColor: Constants.usedGreen,
              onChanged: (value) {
                pressed(value);
              },
            )
          ],
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(
                width: 1.4,
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Color.fromRGBO(153, 153, 153, 1)
                    : Colors.white),
          ),
          overlayColor: MaterialStateProperty.all(Colors.grey[200]),
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15)),
        ),
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Tap on the switch directly'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          );
          snackBar.show(context);
        },
      ),
    );
  }
}
