import 'package:CHATS/api/complaints_api.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:snack/snack.dart';

class ComplaintView extends StatefulWidget {
  const ComplaintView({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  _ComplaintViewState createState() => _ComplaintViewState();
}

class _ComplaintViewState extends State<ComplaintView> {
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
      backgroundColor:
          ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        title: CustomText(
          text: 'Add complaint',
          fontFamily: 'Gilroy-medium',
          fontSize: 22,
          edgeInset: EdgeInsets.zero,
          textAlign: TextAlign.left,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            // scaffoldKey.currentState!.openDrawer();
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined,
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                        text: 'Submit',
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Gilroy-medium',
                        edgeInset: EdgeInsets.zero,
                      )
                    ],
                    onTap: () async {
                      formKey.currentState?.save();
                      if (formKey.currentState!.validate()) {
                        print('Sending complaint');
                        var message = await ComplaintAPI().createComplaint(
                          _textEditingController.text,
                          widget.id,
                        );
                        final snackBar = SnackBar(
                          content: Text(message),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        );
                        snackBar.show(context);
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
}
