// import 'dart:convert';
import 'dart:io';

import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/models/user_details_model.dart';
// import 'package:CHATS/router.dart';
// import 'package:CHATS/screens/Home/view_models/base_view_model.dart';
// import 'package:CHATS/screens/Home/view_models/sign_upVM.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/string_extension.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/utils/validators.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS/widgets/error_widget_handler.dart';
import 'package:flutter/foundation.dart';
// import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
import 'package:snack/snack.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController _emailEditingController;
  late TextEditingController _phoneEditingController;
  late String? _dobPickerValue;
  late TextEditingController _countryEditingController;
  late TextEditingController _ninEditingController;
  late String? _genderPickerValue;
  late TextEditingController _usernameEditingController;
  final formKey = GlobalKey<FormState>();
  File? userImage;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController(text: '');
    lastNameController = TextEditingController(text: '');
    _emailEditingController = TextEditingController(text: '');
    _phoneEditingController = TextEditingController(text: '');
    _countryEditingController = TextEditingController(text: '');
    _ninEditingController = TextEditingController(text: '');
    _usernameEditingController = TextEditingController(text: '');

    _dobPickerValue = locator<UserService>().data!.dob != null
        ? '${dateFormat.format(DateTime.parse(locator<UserService>().data!.dob!))}'
        : '';
    _genderPickerValue =
        '${locator<UserService>().data!.gender != null ? locator<UserService>().data!.gender!.capitalize() : 'Male'}';
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    _emailEditingController.dispose();
    _phoneEditingController.dispose();
    _countryEditingController.dispose();
    _ninEditingController.dispose();
    _usernameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // UserDetails? user = locator<UserService>().userDetails;
    print("This build should be called twice");
    // Size size = MediaQuery.of(context).size;
    // final smallH = size.height / 36;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        centerTitle: false,
        elevation: 0,
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
        title: CustomText(
          text: 'Personal Information',
          fontFamily: 'Gilroy-medium',
          fontSize: 22,
          edgeInset: EdgeInsets.zero,
          textAlign: TextAlign.left,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
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

            return ListView(
              padding: EdgeInsets.only(right: 10, left: 10, top: 20),
              children: [
                Column(
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: getDPImage(
                              locator<UserService>().data?.profilePic),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              //* Launch image picker store image and call update service
                              PickedFile? file = await ImagePicker()
                                  .getImage(source: ImageSource.camera);
                              if (file != null) {
                                // String base64Image =
                                //     base64Encode(file.readAsBytesSync());
                                locator<UserService>().profilePic =
                                    File(file.path);
                                Map? service = await locator<UserService>()
                                    .updateProfileImage();
                                print(
                                    {"update profile image service", service});
                                var snackBar = SnackBar(
                                  content: Text(service?['message']),
                                  margin: EdgeInsets.all(10),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                );
                                snackBar.show(context);
                              } else {
                                // User canceled the picker
                              }
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(124, 141, 181, 1),
                                border:
                                    Border.all(width: 4.2, color: Colors.white),
                              ),
                              child: FittedBox(
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text:
                          '${locator<UserService>().data?.firstName ?? "Update"} ${locator<UserService>().data?.lastName ?? "KYC Status"}',
                      edgeInset: EdgeInsets.zero,
                      fontFamily: 'Gilroy-regular',
                      fontSize: 28,
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? Color.fromRGBO(34, 34, 34, 1)
                          : Colors.white,
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      text: 'ID: ${locator<UserService>().data?.id}',
                      edgeInset: EdgeInsets.zero,
                      fontFamily: 'Gilroy-regular',
                      fontSize: 20,
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? Color.fromRGBO(100, 106, 134, 1)
                          : Colors.white,
                    ),
                    buildInfoCard(locator<UserService>().data!),
                    SizedBox(height: 10),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 52,
                    //   child: CustomButton(
                    //     children: [
                    //       Expanded(
                    //         child: CustomText(
                    //           text: 'Update Profile',
                    //           fontSize: 19,
                    //           fontFamily: 'Gilroy-medium',
                    //           color: Colors.white,
                    //           textAlign: TextAlign.center,
                    //           edgeInset: EdgeInsets.zero,
                    //         ),
                    //       ),
                    //       // SizedBox(
                    //       //   height: 18,
                    //       //   width: 18,
                    //       //   child:
                    //       //       ? CircularProgressIndicator(
                    //       //           strokeWidth: 2,
                    //       //           color: Colors.white,
                    //       //         )
                    //       //       : Placeholder(color: Colors.transparent),
                    //       // )
                    //     ],
                    //     onTap: () async {
                    //       formKey.currentState!.save();
                    //       if (formKey.currentState!.validate()) {
                    //         // TODO: call the service and pass the values
                    //         UserDetails details = UserDetails(
                    //           id: locator<UserService>().userDetails?.id,
                    //           firstName: _nameEditingController.value.text
                    //               .split(" ")[0],
                    //           lastName: _nameEditingController.value.text
                    //               .split(" ")[1],
                    //           phone: _phoneEditingController.value.text,
                    //           email: _emailEditingController.value.text,
                    //           dob: _dobEditingController.value.text,
                    //           location: _countryEditingController.value.text,
                    //           nin: _ninEditingController.value.text,
                    //           address: "not_set",
                    //           maritalStatus: "single",
                    //         );
                    //         var didUpdatedSucces = await locator<UserService>()
                    //             .updateProfile(details);
                    //         print({"update pressed", didUpdatedSucces});
                    //       }
                    //     },
                    //   ),
                    // ),
                    SizedBox(height: 50),
                    // buildIdentityVerification(smallH),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Container _buildCard(
    IconData icon,
    String title,
    String body,
    double height,
    bool uploaded,
  ) {
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
          text: body,
          fontSize: 12,
          color: Color.fromRGBO(85, 85, 85, 1),
        ),
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
            blurRadius: 20,
          )
        ],
      ),
    );
  }

  ImageProvider<Object> getDPImage(image) {
    late dynamic myDP;
    if (image == null) {
      myDP = AssetImage("assets/images/profile_img_placeholder.jpeg");
    } else {
      myDP = NetworkImage(image);
    }

    return myDP;
  }

  Widget buildInfoCard(UserDetails data) {
    firstNameController.text = '${data.firstName ?? ''}';
    lastNameController.text = '${data.lastName ?? ''}';
    _emailEditingController.text = '${data.email ?? ''}';
    _phoneEditingController.text = '${data.phone ?? ''}';

    _countryEditingController.text = '${data.address ?? ''}';
    _ninEditingController.text = '${data.nin ?? ''}';
    _genderPickerValue =
        '${data.gender != null ? data.gender!.capitalize() : 'Male'}';
    _usernameEditingController.text = data.username ?? '';

    print({data.gender, "Gender"});

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 35),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: firstNameController,
                    // borderColor: Colors.transparent,
                    // enabled: false,
                    label: CustomText(
                      text: 'First Name',
                      edgeInset: EdgeInsets.only(left: 10),
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                    validateFn: (val) => Validators.validateName(val?.trim()),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    controller: lastNameController,
                    label: CustomText(
                      text: 'Last Name',
                      // fontSize: 16,
                      // fontFamily: 'Gilroy-Medium',
                      edgeInset: EdgeInsets.only(left: 10),
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                    validateFn: (val) => Validators.validateName(val?.trim()),
                    hintText: '',
                  ),
                ),
              ],
            ),
            CustomTextField(
              controller: _usernameEditingController,
              // borderColor: Colors.transparent,
              // enabled: false,
              prefixText: '@',
              label: CustomText(
                text: 'Username',
                edgeInset: EdgeInsets.only(left: 10),
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              validateFn: (value) {
                if (value!.isEmpty) {
                  return 'The field cannot be empty';
                }
              },
            ),
            CustomTextField(
              controller: _emailEditingController,
              // borderColor: Colors.transparent,
              // enabled: false,

              label: CustomText(
                text: 'Email Adress',
                edgeInset: EdgeInsets.only(left: 10),
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              validateFn: (value) {
                if (value!.isEmpty) {
                  return 'The field cannot be empty';
                }
              },
            ),
            CustomTextField(
              controller: _phoneEditingController,
              // borderColor: Colors.transparent,
              // enabled: false,
              label: CustomText(
                text: 'Phone Number',
                edgeInset: EdgeInsets.only(left: 10),
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              validateFn: (value) {
                if (value!.isEmpty) {
                  return 'The field cannot be empty';
                }
              },
            ),
            StatefulBuilder(builder: (_, setState) {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(1940, 3, 5),
                          maxTime: DateTime.now(),
                          currentTime: DateTime.tryParse(
                              _dobPickerValue != null ? _dobPickerValue! : ''),
                          onChanged: (date) {},
                          onConfirm: (date) {
                            print('change $date');
                            DateFormat dateFormat = DateFormat('dd-MM-yyyy');
                            var formattedDate = dateFormat.format(date);
                            print('formatted data $formattedDate');

                            setState(() {
                              _dobPickerValue = formattedDate;
                            });

                            if (kDebugMode)
                              print({
                                '<<<< STATE CHANGE >>>>',
                                _dobPickerValue,
                              });
                          },
                          // currentTime: DateTime.now(),
                          locale: LocaleType.en,
                        );
                      },
                      child: CustomText(
                        text: _dobPickerValue == null
                            ? 'Pick Birthday'
                            : _dobPickerValue,
                        fontFamily: 'Gilroy-medium',
                        color: Colors.black,
                        textAlign: TextAlign.left,
                        edgeInset: EdgeInsets.zero,
                      ),
                      style: ButtonStyle(
                        side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide()),
                        alignment: Alignment.centerLeft,
                        padding: MaterialStateProperty.resolveWith(
                          (states) => EdgeInsets.only(left: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        value: _genderPickerValue,
                        icon: const Icon(Icons.arrow_downward),
                        iconEnabledColor: Colors.black,
                        iconSize: 24,
                        elevation: 8,
                        isExpanded: true,
                        hint: CustomText(
                          text: 'Pick Gender',
                          fontFamily: 'Gilroy-medium',
                          color: Colors.black,
                          edgeInset: EdgeInsets.zero,
                        ),
                        style: const TextStyle(color: Colors.black),
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.green,
                        // ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _genderPickerValue = newValue!;
                          });

                          if (kDebugMode)
                            print({
                              '<<<< STATE CHANGE >>>>',
                              _genderPickerValue,
                            });
                        },
                        items: <String>[
                          'Male',
                          'Female',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 20),
            data.address == 'Not set'
                ? CustomTextField(
                    controller: _countryEditingController,
                    // borderColor: Colors.transparent,
                    enabled: false,
                    label: CustomText(
                      text: 'Address',
                      edgeInset: EdgeInsets.only(left: 10),
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                    validateFn: (value) {
                      if (value!.isEmpty) {
                        return 'The field cannot be empty';
                      }
                    },
                  )
                : SizedBox(),
            // CustomTextField(
            //   controller: _ninEditingController,
            //   // borderColor: Colors.transparent,
            //   enabled: false,
            //   label: CustomText(
            //     text: 'NIN',
            //     edgeInset: EdgeInsets.only(left: 10),
            //     color: ThemeBuilder.of(context)!.getCurrentTheme() ==
            //             Brightness.light
            //         ? Colors.black
            //         : Colors.white,
            //   ),
            //   validateFn: (value) {
            //     if (value!.isEmpty) {
            //       return 'The field cannot be empty';
            //     }
            //   },
            // ),
            CustomButton(
              height: 52,
              child: CustomText(
                text: 'Update Profile',
                textAlign: TextAlign.center,
                color: Colors.white,
                fontFamily: 'Gilroy-bold',
              ),
              onTap: () async {
                formKey.currentState!.save();
                if (formKey.currentState!.validate() &&
                    _genderPickerValue != null &&
                    _dobPickerValue != null) {
                  var userDetails = new UserDetails(
                    firstName: firstNameController.text.trim(),
                    lastName: lastNameController.text.trim(),
                    gender: _genderPickerValue?.toLowerCase(),
                    dob: _dobPickerValue?.trim(),
                    phone: _phoneEditingController.text.trim(),
                    email: _emailEditingController.text.trim(),
                    username: _usernameEditingController.text.trim(),

                    // address: locator<UserService>().data?.address ==
                    //         'Not set'
                    //     ? locationController.text
                    //     : locator<UserService>().data?.address,
                  );

                  if (kDebugMode)
                    print({
                      '<<<< STATE CHANGE DOB >>>>',
                      _dobPickerValue,
                      '<<<< STATE CHANGE GENDER >>>>',
                      _genderPickerValue,
                    });

                  var didUpdatedSuccess =
                      await locator<UserService>().updateProfile(userDetails);
                  print({"update pressed", didUpdatedSuccess});
                  final bar = SnackBar(
                    content: Text(didUpdatedSuccess['message']),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(10),
                  );
                  bar.show(context);
                  // Navigator.pushNamed(context, home);
                  return;
                }

                final bar = SnackBar(
                  content: Text('All fields must be filled correctly!'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10),
                );
                bar.show(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
