import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/screens/Home/views/drawer_view.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () => onBackPressed(context),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.more_vert, color: Colors.black),
          //     onPressed: () {},
          //   ),
          // ],
          elevation: 0,
          centerTitle: false,
          backgroundColor:
              ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
          leading: GestureDetector(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: Image.asset(
              "assets/Group.png",
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          title: CustomText(
            text: 'Profile',
            fontFamily: 'Gilroy-medium',
            fontSize: 22,
            edgeInset: EdgeInsets.only(top: 3),
            textAlign: TextAlign.left,
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
        ),
        drawer: AppDrawer(),
        // Body
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: UIHelper.sidePadding,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
          child: RefreshIndicator(
            onRefresh: () async {
              await locator<UserService>().setUserData();
              setState(() {});
            },
            edgeOffset: 10,
            child: ListView(
              children: [
                SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(locator<UserService>()
                                    .data
                                    ?.profilePic ??
                                'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50'),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${locator<UserService>().data!.firstName ?? 'Update'} ${locator<UserService>().data!.lastName ?? 'KYC Status'}",
                        style: TextStyle(
                          fontSize: 16,
                          color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                buildProfileComponent(context, title: "Personal Information",
                    pressed: () {
                  Navigator.pushNamed(context, personalInfo);
                }),
                Divider(),
                buildProfileComponent(context, title: "Account", pressed: () {
                  Navigator.pushNamed(context, account);
                }),
                Divider(),
                buildProfileComponent(
                  context,
                  title: "KYC Status",
                  pressed: () {
                    Navigator.pushNamed(context, 'kycStatus');
                  },
                  ninVerified: locator<UserService>().data!.isNinVerified,
                ),
                Divider(),
                buildProfileComponent(
                  context,
                  title: "Security",
                  pressed: () {
                    Navigator.pushNamed(context, security);
                  },
                ),
                Divider(),
                buildProfileComponent(context, title: "Settings", pressed: () {
                  Navigator.pushNamed(context, mySetting);
                }),
                Divider(),
                buildProfileComponent(context, title: "Help & Support",
                    pressed: () {
                  Navigator.pushNamed(context, helpSupport);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileComponent(BuildContext context,
      {required String? title,
      required Function? pressed,
      bool? ninVerified = false}) {
    return InkWell(
      onTap: () => pressed!(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title!,
              style: TextStyle(
                fontSize: 15,
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontFamily: "Gilroy-Regular",
              ),
            ),
            title == "KYC Status"
                ? Row(
                    children: [
                      buildVerifiedWidget(ninVerified!),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_ios,
                          color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white),
                    ],
                  )
                : Icon(Icons.arrow_forward_ios,
                    color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white),
          ],
        ),
      ),
    );
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
}
