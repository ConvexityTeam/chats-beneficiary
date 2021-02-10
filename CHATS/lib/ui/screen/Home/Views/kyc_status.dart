import 'dart:convert';

import 'package:CHATS/ChatsMain/ui/shared/BTN.dart';
import 'package:CHATS/ChatsMain/ui/shared/TEXT.dart';
import 'package:CHATS/ChatsMain/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class KYCstatus extends StatefulWidget {
  @override
  _KYCstatusState createState() => _KYCstatusState();
}

class _KYCstatusState extends State<KYCstatus> {
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
        TEXT(
          text: 'Identity Verification',
          fontFamily: 'Gilroy-bold',
          fontSize: height,
          edgeInset: EdgeInsets.only(bottom: height * 2, top: height),
        ),
        // Text(model.signUpErrorMessage, style: TextStyle(color: Colors.red)),
        GestureDetector(
            child: _buildCard(
                Image.asset("assets/upload_icon.png"),
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
                Image.asset("assets/upload_icon.png"),
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
            child: _buildCard(
                Icon(
                  FontAwesomeIcons.microscope,
                  color: Constants.kpurple2,
                ),
                'Verify NIN/BVN',
                ' ',
                height,
                false),
            onTap: () async {
              // FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);

              Navigator.pushNamed(context, 'bvnVerification');
            }),
        BTN(
          margin: EdgeInsets.only(top: height * 2, bottom: 10),
          children: [
            Expanded(
                child: TEXT(
              text: 'Verify',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              edgeInset: EdgeInsets.all(0.0),
            )),
            // SizedBox(
            //   height: 18,
            //   width: 18,
            //   child: CircularProgressIndicator(
            //       strokeWidth: 2,
            //       valueColor:
            //           AlwaysStoppedAnimation<Color>(
            //               !model.savingUser
            //                   ? Constants.purple
            //                   : Colors.black)))
          ],
          onTap: () {
            // model.register(userModel, context);
          },
        )
      ],
    );
  }

  Container _buildCard(
      Widget icon, String title, String body, double height, bool uploaded) {
    return Container(
      padding: EdgeInsets.only(top: 18, bottom: 18),
      child: ListTile(
        isThreeLine: true,
        // leading: Icon(icon, color: Constants.purple, size: height * 2),
        leading: icon,
        title: TEXT(
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
        subtitle: TEXT(
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
              // spreadRadius: 0.4,
              blurRadius: 10,
            )
          ]),
    );
  }
}

/*






=======
          onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Select Picture'),
                        FlatButton(
                          onPressed: () async {
                            var file = await ImagePicker.pickImage(
                                source: ImageSource.camera);

                            if (file != null) {
                              setState(() {
                                pictureUploaded = true;
                              });
                              String base64Image =
                                  base64Encode(file.readAsBytesSync());
                              model.profilePicture = base64Image;
                            } else {
                              // User canceled the picker
                            }

                            Navigator.pop(context);
                          },
                          child: Text('Choose from camera',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        FlatButton(
                          onPressed: () async {
                            var file = await ImagePicker.pickImage(
                                source: ImageSource.gallery);

                            if (file != null) {
                              setState(() {
                                pictureUploaded = true;
                              });
                              String base64Image =
                                  base64Encode(file.readAsBytesSync());
                              model.profilePicture = base64Image;
                            } else {
                              // User canceled the picker
                            }

                            Navigator.pop(context);
                          },
                          child: Text('Choose from gallery',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('CANCEL',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          alignment: Alignment.bottomRight,
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
        GestureDetector(
          child: _buildCard(
              Icons.upload_outlined,
              'Upload Valid ID',
              'National ID, Drivers’ License, Intl. Passport',
              height,
              idUploaded),
          onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Select Picture'),
                        FlatButton(
                          onPressed: () async {
                            var file = await ImagePicker.pickImage(
                                source: ImageSource.camera);

                            if (file != null) {
                              setState(() {
                                idUploaded = true;
                              });
                              String base64Image =
                                  base64Encode(file.readAsBytesSync());
                              model.profilePicture = base64Image;
                            } else {
                              // User canceled the picker
                            }

                            Navigator.pop(context);
                          },
                          child: Text('Choose from camera',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        FlatButton(
                          onPressed: () async {
                            var file = await ImagePicker.pickImage(
                                source: ImageSource.gallery);

                            if (Icons.filter_2_sharp != null) {
                              setState(() {
                                idUploaded = true;
                              });
                              String base64Image =
                                  base64Encode(file.readAsBytesSync());
                              model.profilePicture = base64Image;
                            } else {
                              // User canceled the picker
                            }

                            Navigator.pop(context);
                          },
                          child: Text('Choose from gallery',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('CANCEL',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          alignment: Alignment.bottomRight,
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
        GestureDetector(
            child: _buildCard(
                Icons.upload_outlined, 'Verify NIN/BVN', ' ', height, false),
            onTap: () async {
              Navigator.pushNamed(context, 'bvnVerification');
              // FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);
            })







 */
