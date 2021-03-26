import 'package:CHATS/ChatsMain/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  CustomButton({@required this.onPressed, @required this.title});
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return Container(
      height: orientation == Orientation.portrait ? 51 : 51,
      width: orientation == Orientation.portrait ? width * 0.85 : width * 0.70,
      decoration: BoxDecoration(color: primaryColor),
      child: RaisedButton(
        onPressed: onPressed,
        color: Constants.purple,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
