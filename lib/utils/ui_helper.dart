import 'package:flutter/material.dart';
// import 'package:path/path.dart';

class Constants {
  static String appName = "CHATS";

  //padding for app
  static const KpaddingS = 8.0;
  static const KpaddingM = 16.0;
  static const KpaddingL = 60.0;

  //text Style
  static const kboldTextStyle = TextStyle(
    fontSize: 18.0,
    fontFamily: 'Gilroy-bold',
  );

  static const kRegularTextStyle = TextStyle(
    fontSize: 16.0,
    fontFamily: 'Gilroy-Regular',
  );
  // spacing for app
  static const KspacingS = SizedBox(
    height: 5.0,
  );

  static const KspacingM = SizedBox(
    height: 10.0,
  );
  static const KspacingL = SizedBox(
    height: 15.0,
  );
  // color

  static const kcolor2 = Color(0xFF000000);
  static const kCaro = Color(0xFFc4c4c4);
  static const kyello = Color(0xFFFDDD82);
  static const borderColor = Color.fromRGBO(51, 51, 51, 1);
  static const kpurple2 = Color(0xFF4A2555);
  static const kgreen2 = Color(0xFF03F394);
  static const purple = Color(0xFF03F394);
  static const hintColor = Color.fromRGBO(153, 153, 153, 1);
  static const newPurple = Color(0xFF00EF96);
  static const usedPurple = Color.fromRGBO(73, 41, 84, 1);
  static const usedGreen = Color.fromRGBO(23, 206, 137, 1);
}

// handle back button pressed on android devices
Future<bool> onBackPressed(context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text("Exit Application ?"),
      content: Text(
          "Are you sure you want to exit this application ? click No to cancel, and Yes to continue."),
      actions: [
        ElevatedButton(
          child: Text("Yes"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        TextButton(
          child: Text("No"),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    ),
  );
}

class UIHelper {
  // static const EdgeInsets sidePadding = EdgeInsets.all(5);
  static const EdgeInsets sidePadding = EdgeInsets.all(5);
  static const BorderRadiusGeometry borderRadius = BorderRadius.all(
    Radius.circular(5),
  );

  Widget circledBox(
      {@required double? height,
      @required double? width,
      @required Widget? child,
      @required Color? color}) {
    return Container(
      height: height,
      width: width,
      child: child,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
