import 'dart:convert';
import 'dart:io';

import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/models/user_details_model.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS/widgets/error_widget_handler.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snack/snack.dart';

class KYCstatus extends StatefulWidget {
  @override
  _KYCstatusState createState() => _KYCstatusState();
}

class _KYCstatusState extends State<KYCstatus> {
  late TextEditingController _docNumberController;
  String _idDocType = '';
  // String _genderDropdownValue = 'Male';
  // String _selectedDate = '';
  String? _ip;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _docNumberController =
        TextEditingController(text: locator<UserService>().data?.nin);
    // _selectedDate = locator<UserService>().data?.dob == null
    //     ? ''
    //     : '${DateTime.parse(locator<UserService>().data!.dob!).toString().substring(0, 11)}';
    _getDeviceIP();
  }

  @override
  void dispose() {
    _docNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // final smallH = size.height / 36;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        title: CustomText(
          text: 'ID Verification',
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
      body: FutureBuilder(
        future: locator<UserService>().data != null
            ? null
            : locator<UserService>().setUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return ErrorWidgetHandler(onTap: () {
              setState(() {});
            });
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(right: 20, left: 20, top: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   height: 110,
                    //   width: 110,
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       image: AssetImage("assets/Ellipse 4.png"),
                    //       fit: BoxFit.cover,
                    //     ),
                    //     shape: BoxShape.circle,
                    //   ),
                    // ),
                    // buildIdentityVerification(smallH)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildVerifiedWidget(
                            locator<UserService>().data!.isNinVerified!),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      label: CustomText(
                        text: 'Virtual NIN (vNiN)',
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      controller: _docNumberController,
                      hintText: '',
                      validateFn: (val) {
                        if (val == null)
                          return "vNIN is required";
                        else if (val.isEmpty) return "vNIN Cannot be empty";
                        // else if (val.length != 11)
                        //   return "NIN must be exactly 11 digits";
                      },
                      margin: EdgeInsets.only(bottom: 10),
                    ),
                    CustomText(
                      text:
                          'Two ways to generate your virtual NIN for KYC\n- USSD: *346*3*customer NIN*696739#\n- NIMC official mobile app',
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w800,
                      edgeInset: EdgeInsets.only(left: 10),
                      color: Constants.usedGreen,
                      fontSize: 18,
                    ),
                    SizedBox(height: 15),
                    // CustomTextField(
                    //   controller: firstNameController,
                    //   validateFn: (val) => Validators.validateName(val?.trim()),
                    //   label: CustomText(
                    //     text: 'First Name',
                    //     fontSize: 16,
                    //     fontFamily: 'Gilroy-Medium',
                    //     color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                    //             Brightness.light
                    //         ? Colors.black
                    //         : Colors.white,
                    //   ),
                    //   hintText: '',
                    // ),

                    locator<UserService>().data?.address == 'Not set'
                        ? CustomTextField(
                            controller: locationController,
                            label: CustomText(
                              text: 'Address',
                              fontSize: 16,
                              fontFamily: 'Gilroy-Medium',
                              color:
                                  ThemeBuilder.of(context)!.getCurrentTheme() ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                            ),
                            validateFn: (val) {
                              if (val!.isEmpty) return 'Cannot be empty';
                            },
                            hintText: '',
                          )
                        : SizedBox(),

                    SizedBox(
                      height: 52,
                      child: CustomButton(
                        margin: EdgeInsets.zero,
                        child: CustomText(
                          text: 'Verify Profile',
                          color: Colors.white,
                          edgeInset: EdgeInsets.zero,
                          fontFamily: 'Gilroy-bold',
                          textAlign: TextAlign.center,
                        ),
                        onTap: () async {
                          if (locator<UserService>().data?.firstName == null ||
                              locator<UserService>().data?.lastName == null) {
                            return SnackBar(
                              content: Text(
                                  'Update your personal information first, in the personal information section'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(10),
                            ).show(context);
                          }
                          if (formKey.currentState!.validate()) {
                            var userDetails = new UserDetails(
                              firstName: locator<UserService>()
                                  .data
                                  ?.firstName
                                  ?.trim(),
                              lastName:
                                  locator<UserService>().data?.lastName?.trim(),
                              // gender: _genderDropdownValue.toLowerCase(),
                              // dob: _selectedDate,
                              nin: _docNumberController.text.trim(),
                              ip: _ip,
                              // phone: locator<UserService>().data?.phone,
                              // address: locator<UserService>().data?.address ==
                              //         'Not set'
                              //     ? locationController.text
                              //     : locator<UserService>().data?.address,
                            );

                            var updateResult = await locator<UserService>()
                                .updateProfile(userDetails);
                            print({"update pressed", updateResult});

                            if ((updateResult['message'].runtimeType
                                is Object)) {
                              final keys = updateResult['message'].keys;
                              for (final key in keys) {
                                SnackBar(
                                  content:
                                      Text(updateResult['message'][key][0]),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(10),
                                ).show(context);
                              }
                              return;
                            } else {
                              final bar = SnackBar(
                                content: Text(updateResult['status'] != 'error'
                                    ? updateResult['message']
                                    : ''),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                              );
                              bar.show(context);
                              // Navigator.pushNamed(context, home);
                              return;
                            }
                          }

                          final bar = SnackBar(
                            content:
                                Text('All fields must be filled correctly!'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(10),
                          );
                          bar.show(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String?> _getDeviceIP() async {
    String? hostAddress;
    try {
      //*Setup and get IP
      final permStatus = await Permission.location.request();
      if (permStatus == PermissionStatus.granted) {
// final info = NetworkInfo();
        // hostAddress = await info.getWifiIP();
        if (hostAddress == null) {
          var ipList =
              await NetworkInterface.list(type: InternetAddressType.IPv4);
          hostAddress = ipList.first.addresses.first.address;
          print({hostAddress, "***IP ADDRESS***"});
          setState(() {
            _ip = hostAddress;
          });
        }

        return hostAddress;
      } else {
        await Permission.location.request();
      }
    } catch (err) {
      print({err, "an error occurred"});
    }
  }

  Widget buildVerifiedWidget(bool isVerified) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isVerified
            ? Color.fromRGBO(23, 206, 137, 0.1)
            : Color.fromRGBO(228, 44, 102, 0.1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(
              isVerified ? Icons.check : Icons.close_rounded,
              size: 18,
              color: Colors.white,
            ),
            radius: 12,
            backgroundColor: isVerified
                ? Color.fromRGBO(0, 168, 105, 1)
                : Color.fromRGBO(228, 44, 102, 1),
          ),
          SizedBox(width: 10),
          CustomText(
            text: isVerified ? 'Verified' : 'Unverified',
            fontFamily: 'Gilroy-medium',
            color: isVerified
                ? Color.fromRGBO(0, 168, 105, 1)
                : Color.fromRGBO(228, 44, 102, 1),
            edgeInset: EdgeInsets.zero,
          )
        ],
      ),
    );
  }

  bool pictureUploaded = false;
  bool idUploaded = false;
  Widget buildIdentityVerification(double height) {
    // instantiate image picker
    final _picker = ImagePicker();
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
                Image.asset("assets/upload_icon.png"),
                'Upload Picture',
                'Upload a clear picture showing your face. Avoid group picture',
                height,
                pictureUploaded),
            onTap: () async {
              PickedFile? file =
                  await _picker.getImage(source: ImageSource.gallery);
              if (file != null) {
                setState(() {
                  pictureUploaded = true;
                });
                String base64Image = base64Encode(await file.readAsBytes());
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
              var file = await _picker.getImage(source: ImageSource.gallery);
              if (file != null) {
                setState(() {
                  // idUploaded = true;
                });
                String base64Image = base64Encode(await file.readAsBytes());
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
        CustomButton(
          margin: EdgeInsets.only(top: height * 2, bottom: 10),
          bgColor: Constants.usedGreen,
          children: [
            Expanded(
                child: CustomText(
              text: 'Verify',
              color: Colors.white,
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
            // Update user profile
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
              // spreadRadius: 0.4,
              blurRadius: 10,
            )
          ]),
    );
  }

  TextEditingController locationController =
      new TextEditingController(text: '');
}

/*







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
