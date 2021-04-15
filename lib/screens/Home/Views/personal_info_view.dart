import 'dart:convert';
import 'dart:io';

import 'package:CHATS/screens/home/view_models/base_view_model.dart';
import 'package:CHATS/screens/home/view_models/sign_upVM.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  File userImage;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final smallH = size.height / 36;
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView(
        padding: EdgeInsets.only(right: 10, left: 10),
        children: [
          BaseViewModel<SignUpVM>(
            providerReady: (model) => {},
            builder: (context, provider, child) => Column(
              children: [
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: userImage == null
                          ? AssetImage("assets/Ellipse 4.png")
                          : FileImage(userImage),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                buildIdentityVerification(smallH),
                CustomButton(
                    children: [
                      CustomText(color: Colors.white, text: 'Register')
                    ],
                    onTap: () {
                      provider.register(context);
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool pictureUploaded = false;
  bool idUploaded = false;
  Widget buildIdentityVerification(double height) {
    return BaseViewModel<SignUpVM>(
        providerReady: (model) => {},
        builder: (context, provider, child) => WillPopScope(
              // ignore: missing_return
              onWillPop: () {
                Navigator.pop(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Identity Verification',
                    fontFamily: 'Gilroy-bold',
                    fontSize: height,
                    edgeInset: EdgeInsets.only(bottom: height * 2, top: height),
                  ),
                  // Text(model.signUpErrorMessage, style: TextStyle(color: Colors.red)),
                  GestureDetector(
                      child: _buildCard(
                          Icons.upload_outlined,
                          'Upload Picture',
                          'Upload a clear picture showing your face. Avoid group picture',
                          height,
                          pictureUploaded),
                      onTap: () async {
                        var file = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        if (file != null) {
                          setState(() {
                            pictureUploaded = true;
                            userImage = file;
                          });
                          String base64Image =
                              base64Encode(file.readAsBytesSync());
                          provider.profilePicture = file;
                        } else {
                          // User canceled the picker
                        }
                      }),
                ],
              ),
            ));
  }

  Container _buildCard(
      IconData icon, String title, String body, double height, bool uploaded) {
    return Container(
      padding: EdgeInsets.only(top: 18, bottom: 18),
      child: ListTile(
        isThreeLine: true,
        leading: Icon(icon, color: Constants.purple, size: height * 2),
        title: CustomText(
          text: title,
          fontFamily: 'Gilroy-Medium',
          fontSize: 16,
        ),
        trailing: uploaded
            ? Container(
                child: Icon(Icons.check, color: Colors.white),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(style: BorderStyle.none),
                    color: Constants.purple),
              )
            : Text(''),
        subtitle: CustomText(
            text: body, fontSize: 12, color: Color.fromRGBO(85, 85, 85, 1)),
      ),
      margin: EdgeInsets.only(bottom: height),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border(
              bottom: BorderSide.none,
              top: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(174, 174, 192, 1),
                spreadRadius: 0.4,
                blurRadius: 20)
          ]),
    );
  }
}
