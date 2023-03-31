import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorWidgetHandler extends StatelessWidget {
  const ErrorWidgetHandler({Key? key, this.onTap, this.message})
      : super(key: key);

  final Function? onTap;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomText(
              textAlign: TextAlign.center,
              text: message != null
                  ? '$message. Tap refresh'
                  : 'An error occurred while loading, check your network then tap refresh',
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          CustomButton(
            height: 52,
            margin: EdgeInsets.all(20),
            children: [
              CustomText(
                text: 'Refresh',
                color: Colors.white,
                fontFamily: 'Gilroy-bold',
              )
            ],
            onTap: () => onTap!(),
          ),
        ],
      ),
    );
  }
}
