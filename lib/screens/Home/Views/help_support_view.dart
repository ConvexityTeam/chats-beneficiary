import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';

class HelpSupportView extends StatefulWidget {
  const HelpSupportView({Key? key}) : super(key: key);

  @override
  _HelpSupportViewState createState() => _HelpSupportViewState();
}

class _HelpSupportViewState extends State<HelpSupportView> {
  late TextEditingController _textEditingController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
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
          text: 'Support',
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              CustomText(
                  text:
                      'Creating a support ticket by writing your issues below and tapping submit',
                  fontSize: 18,
                  fontFamily: 'Gilroy-medium',
                  textAlign: TextAlign.center,
                  color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Form(
                  key: formKey,
                  child: TextField(
                    controller: _textEditingController,
                    maxLines: 10,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                ThemeBuilder.of(context)!.getCurrentTheme() ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                ThemeBuilder.of(context)!.getCurrentTheme() ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: CustomButton(
                  margin: EdgeInsets.zero,
                  children: [
                    CustomText(
                      text: 'Submit Ticket',
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Gilroy-medium',
                      edgeInset: EdgeInsets.zero,
                    )
                  ],
                  onTap: () {
                    // formKey.currentState?.save();
                    // if (formKey.currentState!.validate()) {
                    //   print('Sending complaint');
                    //   var message = ComplaintAPI()
                    //       .createComplaint(_textEditingController.value.text);
                    //   final snackBar = SnackBar(
                    //     content: Text(message),
                    //     behavior: SnackBarBehavior.floating,
                    //     margin: EdgeInsets.all(20),
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(30)),
                    //   );
                    //   snackBar.show(context);
                    // }
                    print('submit tcket');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(
      {required String text, required Function pressed, IconData? icon}) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(width: 10),
            CustomText(
              text: '$text',
              fontFamily: 'Gilroy-medium',
              color: Colors.black,
              edgeInset: EdgeInsets.zero,
            ),
          ],
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(width: 1.4, color: Color.fromRGBO(153, 153, 153, 1)),
          ),
          overlayColor: MaterialStateProperty.all(Colors.grey[200]),
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15)),
        ),
        onPressed: () => pressed(),
      ),
    );
  }
}
