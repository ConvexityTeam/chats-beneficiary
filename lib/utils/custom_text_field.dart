import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.controller,
    required this.label,
    this.hintText,
    this.helpText,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.isPassword,
    this.enabled,
    this.readOnly,
    this.borderColor,
    this.keyboardType,
    this.focusColor,
    this.validateFn,
    this.maxLines,
    this.padding,
    this.margin,
    this.onSaved,
    this.inputBorder,
    this.onTap,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? helpText;
  final Icon? prefixIcon;
  final String? prefixText;
  final Widget? suffixIcon;
  bool? isPassword = false;
  final bool? enabled;
  final bool? readOnly;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final Color? focusColor;
  final String? Function(String? text)? validateFn;
  int? maxLines = 1;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final void Function(String? value)? onSaved;
  final InputBorder? inputBorder;
  final CustomText? label;
  void Function()? onTap;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      // padding: padding??EdgeInsets.only(left:8.0),
      margin: margin ?? EdgeInsets.only(bottom: screenSize.height / 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label!,
          SizedBox(height: 10),
          TextFormField(
            onTap: onTap,
            onChanged: onChanged,
            // maxLines: maxLines ?? null,
            controller: controller,
            readOnly: readOnly ?? false,
            obscureText: isPassword ?? false,
            style: TextStyle(
              fontSize: screenSize.height / 48,
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validateFn,
            onSaved: onSaved,
            cursorColor: Constants.purple,
            enabled: enabled ?? true,
            // maxLength: maxLength??,
            decoration: InputDecoration(
              enabled: true,
              hintText: hintText,
              contentPadding: EdgeInsets.only(left: 12.0),
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black.withOpacity(.4)
                    : Colors.white.withOpacity(.4),
              ),
              prefixIcon: prefixIcon,
              prefixText: prefixText,
              prefixStyle: TextStyle(
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontSize: screenSize.height / 54,
              ),
              suffixIcon: suffixIcon,
              focusColor: focusColor ?? Colors.blue,
              border: inputBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: .5,
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? Constants.borderColor
                          : Constants.kCaro,
                    ),
                  ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? Colors.black,
                ),
              ),
              focusedBorder: inputBorder ??
                  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          BorderSide(width: 1, color: Constants.purple)),
              fillColor: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
              filled: true,
            ),
          ),
        ],
      ),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   shape: BoxShape.rectangle,
      //   borderRadius: BorderRadius.circular(8.0),
      //   // border: Border.all(color: borderColor??CustomColors.subColor.withGreen(150),width: 1.0)
      // ),
    );
  }
}
