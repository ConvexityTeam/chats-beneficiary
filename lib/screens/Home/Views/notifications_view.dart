import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/screens/Home/Views/drawer_view.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/error_widget_handler.dart';
import 'package:flutter/material.dart';
import 'package:snack/snack.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsView extends StatefulWidget {
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () => onBackPressed(context),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
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
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          title: CustomText(
            text: "Notification",
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
            fontSize: 22,
            fontFamily: 'Gilroy-medium',
            edgeInset: EdgeInsets.only(top: 3),
          ),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: locator<UserService>().retrieveTransactions('yearly'),
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

            if (locator<UserService>().history?.transactions?.count == 0) {
              return Center(
                child: CustomText(
                  text: 'You have no transactions at this time',
                  color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              );
            }

            if (locator<UserService>().history == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomText(
                    text:
                        'There was an issue fetching your transactions, check at a later time',
                    color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SizedBox(height: 25),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () =>
                          locator<UserService>().retrieveTransactions('yearly'),
                      child: ListView.separated(
                        itemBuilder: (context, int index) {
                          var reversedTransactionList = locator<UserService>()
                              .history!
                              .transactions!
                              .rows!
                              .reversed
                              .toList();
                          return buildNotificationCard(
                            reversedTransactionList[index],
                          );
                        },
                        separatorBuilder: (context, int index) => Divider(
                          height: 20,
                          thickness: 1,
                        ),
                        itemCount: locator<UserService>()
                            .history!
                            .transactions!
                            .rows!
                            .length,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildNotificationCard(Map? items) {
    int price = 240;
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(240, 240, 240, 0.4),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        height: 62,
        width: 62,
        child: Center(
          child: Text(
            "C",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: "Gilroy-medium",
            ),
          ),
        ),
      ),
      trailing: GestureDetector(
          onTap: () async {
            // DONE: Open explorer link to browser
            print({'should open to browser', items?["BlockchainXp_Link"]});
            Uri url = Uri.parse(items?["BlockchainXp_Link"]);
            if (await canLaunchUrl(url)) {
              await launchUrl(url,
                  mode: LaunchMode.inAppWebView,
                  webViewConfiguration: WebViewConfiguration());
            } else {
              SnackBar(content: Text('Cannot launch explorer link'))
                  .show(context);
            }
          },
          child: Icon(Icons.open_in_new_sharp)),
      title: RichText(
        text: TextSpan(
            style: TextStyle(
              fontSize: 11,
              fontFamily: "Gilroy-medium",
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            text: 'Ref: ${items?["reference"]}\n',
            children: [
              TextSpan(
                text: "${items?['narration']}",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Gilroy-bold",
                  color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              )
            ]),
      ),
      tileColor: Colors.white,
      subtitle: Text(
        "${DateTime.parse(items?['createdAt']).toString().substring(0, 11)}",
        style: TextStyle(
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Color(0xff333333)
              : Colors.white,
          fontSize: 13,
          fontFamily: "Gilroy-medium",
        ),
      ),
    );
  }
}
