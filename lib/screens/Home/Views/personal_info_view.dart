import 'dart:convert';

import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
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
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Ellipse 4.png"),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
          ),
          buildIdentityVerification(smallH)
        ],
      ),
    );
  }

  bool pictureUploaded = false;
  bool idUploaded = false;
  Widget buildIdentityVerification(double height) {
    return Column(
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
              var file =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              if (file != null) {
                setState(() {
                  // pictureUploaded = true;
                });
                String base64Image = base64Encode(file.readAsBytesSync());
                // model.profilePicture = base64Image;
              } else {
                // User canceled the picker
              }
            }),
        GestureDetector(
            child: _buildCard(
                Icons.upload_outlined,
                'Upload Valid ID',
                'National ID, Drivers’ License, Intl. Passport',
                height,
                idUploaded),
            onTap: () async {
              var file =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              if (file != null) {
                setState(() {
                  // idUploaded = true;
                });
                String base64Image = base64Encode(file.readAsBytesSync());
                // model.validId = base64Image;
              } else {
                // User canceled the picker
              }
            }),

        GestureDetector(
            child: _buildCard(Icons.lock, 'Verify NIN/BVN', ' ', height, false),
            onTap: () async {
              // FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);
            }),
        CustomButton(
          margin: EdgeInsets.only(top: height * 3),
          children: [
            Expanded(
                child: CustomText(
              text: 'Verify',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              edgeInset: EdgeInsets.all(0.0),
            )),
            SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ))
            // valueColor: AlwaysStoppedAnimation<Color>(
            //     !model.savingUser ? Constants.purple : Colors.black)))
          ],
          onTap: () {
            // model.register(userModel, context);
          },
        )
      ],
    );
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
