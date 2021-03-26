import 'package:CHATS/ChatsMain/ui/shared/ui_helper.dart';
import 'package:CHATS/Vendor/Utils/colors.dart';
import 'package:CHATS/Vendor/core/constants/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function function;
  final String title;
  const CustomButton({Key key, this.function, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.89,
      margin: UIHelper.sidePadding,
      decoration: BoxDecoration(
        color: Constants.purple,
        borderRadius: UIHelper.borderRadius,
      ),
      child: RaisedButton(
        color: Constants.purple,
        onPressed: function,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: "Gilroy-medium",
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
// ff8080
