import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/screens/home/views/drawer_view.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Exit Application ?"),
            content: Text(
                "Are you sure you want to exit this application ? click No to cancel, and Yes to continue."),
            actions: [
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          ),
        );
      },
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.black),
                onPressed: () {},
              ),
            ],
            elevation: 0,
            backgroundColor: Colors.white,
            leading: GestureDetector(
                onTap: () {
                  scaffoldKey.currentState.openDrawer();
                },
                child: Image.asset("assets/Group.png")),
            title: Text(
              "Profile",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: "Gilroy-medium",
              ),
            ),
          ),
          drawer: AppDrawer(),
          // Body
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: UIHelper.sidePadding,
            child: SingleChildScrollView(
              child: Column(
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
                              image: NetworkImage(
                                  locator<UserService>().data.profilePic),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${locator<UserService>().data.firstName} ${locator<UserService>().data.lastName}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  buildProfileComponent(
                      title: "Personal Information",
                      pressed: () {
                        Navigator.pushNamed(context, 'personal-info');
                      }),
                  Divider(),
                  buildProfileComponent(title: "Account", pressed: () {}),
                  Divider(),
                  buildProfileComponent(
                      title: "KYC status",
                      pressed: () {
                        Navigator.pushNamed(context, 'kycStatus');
                      }),
                  Divider(),
                  buildProfileComponent(title: "Security", pressed: () {}),
                  Divider(),
                  buildProfileComponent(title: "Settings", pressed: () {}),
                  buildProfileComponent(
                      title: "Help & Support", pressed: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileComponent(
      {@required String title, @required Function pressed}) {
    return ListTile(
      trailing: IconButton(
        icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
        onPressed: pressed,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontFamily: "Gilroy-Regular",
        ),
      ),
    );
  }
}
