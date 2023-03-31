import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/screens/Home/Views/drawer_view.dart';
import 'package:CHATS/screens/Home/Views/index.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS/widgets/error_widget_handler.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:snack/snack.dart';

class CampaignsView extends StatefulWidget {
  const CampaignsView({Key? key}) : super(key: key);

  @override
  _CampaignsViewState createState() => _CampaignsViewState();
}

class _CampaignsViewState extends State<CampaignsView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Color.fromRGBO(250, 250, 250, 1)
              : primaryColorDarkMode,
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        title: CustomText(
          text:
              'My Campaigns (${locator<UserService>().data!.campaigns != null ? locator<UserService>().data!.campaigns!.length : 0})',
          fontFamily: 'Gilroy-medium',
          fontSize: 22,
          edgeInset: EdgeInsets.zero,
          textAlign: TextAlign.left,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child: Image.asset(
            "assets/Group.png",
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.pushNamed(context, allCampaigns);
        //       },
        //       icon: Icon(Icons.list_alt_outlined,
        //           color: ThemeBuilder.of(context)!.getCurrentTheme() ==
        //                   Brightness.light
        //               ? Colors.black
        //               : Colors.white))
        // ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: locator<UserService>().data!.campaigns != null
              ? null
              : locator<UserService>().setUserData(),
          builder: (context, snapshot) {
            // print(snapshot.data);
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

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  buildTotalHeader(
                    locator<UserService>().data!.campaigns != null
                        ? locator<UserService>().data!.campaigns!.length
                        : 0,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: locator<UserService>().data!.campaigns == null ||
                              locator<UserService>().data!.campaigns!.isEmpty
                          ? CustomText(
                              text:
                                  'You have not joined any campaigns yet, tap the button above to view campaigns',
                              textAlign: TextAlign.center,
                              fontSize: 19,
                              color:
                                  ThemeBuilder.of(context)!.getCurrentTheme() ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                              fontFamily: 'Gilroy-medium',
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: locator<UserService>()
                                  .data!
                                  .campaigns!
                                  .map(
                                    (item) => item.type == 'campaign'
                                        ? buildOptCard(
                                            item.title,
                                            item.description,
                                            DateTime.parse(item.createdAt!)
                                                .toLocal()
                                                .toString(),
                                            item.budget?.toStringAsFixed(2),
                                            item.status,
                                            item.id,
                                          )
                                        : buildTaskOptCard(
                                            item.title,
                                            item.description,
                                            DateTime.parse(item.createdAt!)
                                                .toLocal()
                                                .toString(),
                                            item.budget?.toStringAsFixed(2),
                                            item.status,
                                            3,
                                            item.id),
                                  )
                                  .toList(),
                            ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget buildTotalHeader(int total) {
    return Row(
      children: [
        Expanded(
            child: CustomButton(
          height: 52,
          children: [
            CustomText(
              text: 'View Campaigns',
              color: Colors.white,
              fontFamily: 'Gilroy-bold',
            ),
          ],
          onTap: () {
            Navigator.pushNamed(context, allCampaigns);
          },
        )),
        SizedBox(width: 20),
        PopupMenuButton(
            itemBuilder: (_) => <PopupMenuItem<String>>[
                  new PopupMenuItem<String>(
                      child: new Text('Sort By Organisation'),
                      value: 'sort_org'),
                  // new PopupMenuItem<String>(
                  //     child: new Text('View Transaction Barcode'),
                  //     value: 'view_barcode'),
                ],
            onSelected: (value) async {
              // List only campaigns from the users associatedOrganisations
              print(value);
            },
            child: Container(
              width: 52,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.2),
                    offset: Offset(0, 5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: FittedBox(
                child: Icon(Icons.filter_alt_outlined, color: Colors.black),
              ),
            )),
      ],
    );
  }

  Widget _buildOptCard(String? title, String? amount, bool? opted) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            offset: Offset(0, 5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            edgeInset: EdgeInsets.zero,
            fontFamily: 'Gilroy-medium',
            fontSize: 24,
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Amount',
                edgeInset: EdgeInsets.zero,
                fontFamily: 'Gilroy-light',
                fontSize: 20,
                color: Colors.black.withOpacity(.4),
              ),
              CustomText(
                text: amount,
                edgeInset: EdgeInsets.zero,
                fontFamily: 'Gilroy-light',
                fontSize: 20,
                color: Colors.black.withOpacity(.4),
              ),
            ],
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  height: 52,
                  bgColor: Colors.white,
                  borderColor: Constants.usedGreen,
                  useOverlay: true,
                  children: [
                    CustomText(
                      text: 'Opt out',
                      edgeInset: EdgeInsets.zero,
                      fontFamily: 'Gilroy-medium',
                      color: Constants.usedGreen,
                    )
                  ],
                  onTap: () {},
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: CustomButton(
                  height: 52,
                  bgColor: Colors.white,
                  borderColor: Colors.red.shade400,
                  useOverlay: true,
                  children: [
                    CustomText(
                      text: 'Complaint',
                      edgeInset: EdgeInsets.zero,
                      fontFamily: 'Gilroy-medium',
                      color: Colors.red.shade400,
                    )
                  ],
                  onTap: () {
                    Navigator.pushNamed(context, complaint);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOptCard(
    String? title,
    String? description,
    String? dateCreated,
    String? amount,
    String? status,
    int? campaignId,
  ) {
    Container tag(value, width) => Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: CustomText(
            fontStyle: FontStyle.normal,
            text: value,
            fontFamily: 'Gilroy-light',
            fontSize: width * .04545,
            edgeInset: EdgeInsets.zero,
            color: value == 'ongoing'
                ? Color.fromRGBO(13, 21, 234, 1)
                : value == 'pending'
                    ? Color.fromRGBO(112, 72, 49, 1)
                    : value == 'completed'
                        ? Color.fromRGBO(51, 113, 56, 1)
                        : value == 'rejected'
                            ? Color.fromRGBO(228, 44, 102, 1)
                            : value == 'disbursed'
                                ? Color.fromRGBO(100, 106, 134, 1)
                                : Colors.white,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: value == 'ongoing'
                ? Color.fromRGBO(182, 207, 255, 1)
                : value == 'pending'
                    ? Color.fromRGBO(255, 234, 182, 1)
                    : value == 'completed'
                        ? Color.fromRGBO(209, 247, 196, 1)
                        : value == 'rejected'
                            ? Color.fromRGBO(255, 205, 199, 1)
                            : value == 'disbursed'
                                ? Color.fromRGBO(241, 241, 241, 1)
                                : Colors.blueGrey,
          ),
        );

    Row rowInfo(String? key, String? value, width) => Row(
          mainAxisAlignment: key != 'Status'
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            CustomText(
              text: '$key:',
              edgeInset: EdgeInsets.zero,
              fontFamily: 'Gilroy-light',
              fontSize: width * .04545,
              color: Colors.black.withOpacity(.4),
            ),
            key != 'Status' ? SizedBox(width: 0) : SizedBox(width: 20),
            key != 'Status'
                ? CustomText(
                    text: value!.length >= 20
                        ? value.substring(0, 19) + '...'
                        : value,
                    edgeInset: EdgeInsets.zero,
                    fontFamily: 'Gilroy-light',
                    fontSize: width * .04545,
                    color: Colors.black.withOpacity(.4),
                  )
                : tag(value, width),
          ],
        );

    double width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            offset: Offset(5, 5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            edgeInset: EdgeInsets.zero,
            fontFamily: 'Gilroy-bold',
            fontSize: width * .04545,
          ),
          // SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Image.asset(
          //       'assets/tasks.png',
          //       width: 20,
          //     ),
          //     SizedBox(width: 20),
          //     CustomText(
          //       text: '$taskNumber Tasks',
          //       fontSize: 18,
          //       fontFamily: 'Gilroy-light',
          //       edgeInset: EdgeInsets.zero,
          //     )
          //   ],
          // ),
          SizedBox(height: 25),
          rowInfo('Description', description, width),
          SizedBox(height: 25),
          rowInfo('Amount', amount, width),
          SizedBox(height: 25),
          rowInfo('Created', Jiffy(dateCreated).format('d MMM yyy'), width),
          SizedBox(height: 25),
          rowInfo('Status', status, width),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  height: 52,
                  bgColor: Colors.white,
                  borderColor: Constants.usedGreen,
                  loadColor: Constants.usedGreen,
                  useOverlay: true,
                  child: CustomText(
                    text: 'Opt out',
                    edgeInset: EdgeInsets.zero,
                    fontFamily: 'Gilroy-medium',
                    color: Constants.usedGreen,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () async {
                    //* DONE: Add opt out functionality
                    String? message =
                        await locator<UserService>().leaveCampaign(campaignId!);
                    final snackBar = SnackBar(
                      content: Text(message!),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    );
                    snackBar.show(context);
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: CustomButton(
                  height: 52,
                  bgColor: Colors.white,
                  borderColor: Colors.red.shade400,
                  useOverlay: true,
                  children: [
                    CustomText(
                      text: 'Complaint',
                      edgeInset: EdgeInsets.zero,
                      fontFamily: 'Gilroy-medium',
                      color: Colors.red.shade400,
                    )
                  ],
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                          return ComplaintView(
                            id: campaignId,
                          );
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                                    begin: Offset(
                                      1.0,
                                      0.0,
                                    ),
                                    end: Offset.zero)
                                .animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Task card with number of task present
  Widget buildTaskOptCard(
      String? title,
      String? description,
      String? dateCreated,
      String? amount,
      String? status,
      int? taskNumber,
      int? campaignId) {
    Container tag(value, width) => Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: CustomText(
            fontStyle: FontStyle.normal,
            text: value,
            fontFamily: 'Gilroy-light',
            fontSize: width * .04545,
            edgeInset: EdgeInsets.zero,
            color: value == 'ongoing'
                ? Color.fromRGBO(13, 21, 234, 1)
                : value == 'pending'
                    ? Color.fromRGBO(112, 72, 49, 1)
                    : value == 'completed'
                        ? Color.fromRGBO(51, 113, 56, 1)
                        : value == 'rejected'
                            ? Color.fromRGBO(228, 44, 102, 1)
                            : value == 'disbursed'
                                ? Color.fromRGBO(100, 106, 134, 1)
                                : Colors.white,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: value == 'ongoing'
                ? Color.fromRGBO(182, 207, 255, 1)
                : value == 'pending'
                    ? Color.fromRGBO(255, 234, 182, 1)
                    : value == 'completed'
                        ? Color.fromRGBO(209, 247, 196, 1)
                        : value == 'rejected'
                            ? Color.fromRGBO(255, 205, 199, 1)
                            : value == 'disbursed'
                                ? Color.fromRGBO(241, 241, 241, 1)
                                : Colors.blueGrey,
          ),
        );

    Row rowInfo(String? key, String? value, width) => Row(
          mainAxisAlignment: key != 'Status'
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            CustomText(
              text: '$key:',
              edgeInset: EdgeInsets.zero,
              fontFamily: 'Gilroy-light',
              fontSize: width * .04545,
              color: Colors.black.withOpacity(.4),
            ),
            key != 'Status' ? SizedBox(width: 0) : SizedBox(width: 20),
            key != 'Status'
                ? CustomText(
                    text: value!.length >= 20
                        ? value.substring(0, 19) + '...'
                        : value,
                    edgeInset: EdgeInsets.zero,
                    fontFamily: 'Gilroy-light',
                    fontSize: width * .04545,
                    color: Colors.black.withOpacity(.4),
                  )
                : tag(value, width),
          ],
        );

    double width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            offset: Offset(5, 5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            edgeInset: EdgeInsets.zero,
            fontFamily: 'Gilroy-bold',
            fontSize: width * .04545,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/tasks.png',
                width: 20,
              ),
              SizedBox(width: 20),
              CustomText(
                text: 'Tasks',
                fontSize: 18,
                fontFamily: 'Gilroy-light',
                edgeInset: EdgeInsets.zero,
              )
            ],
          ),
          SizedBox(height: 25),
          rowInfo('Description', description, width),
          SizedBox(height: 25),
          rowInfo('Amount', amount, width),
          SizedBox(height: 25),
          rowInfo('Created', dateCreated!.substring(0, 10), width),
          SizedBox(height: 25),
          rowInfo('Status', status, width),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  height: 52,
                  bgColor: Colors.white,
                  borderColor: Constants.usedGreen,
                  useOverlay: true,
                  children: [
                    CustomText(
                      text: 'Opt out',
                      edgeInset: EdgeInsets.zero,
                      fontFamily: 'Gilroy-medium',
                      color: Constants.usedGreen,
                    )
                  ],
                  onTap: () async {
                    //* DONE: Add opt out functionality
                    String? message =
                        await locator<UserService>().leaveCampaign(campaignId!);
                    final snackBar = SnackBar(
                      content: Text(message!),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    );
                    snackBar.show(context);
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: CustomButton(
                  height: 52,
                  bgColor: Colors.white,
                  borderColor: Colors.red.shade400,
                  useOverlay: true,
                  children: [
                    CustomText(
                      text: 'Complaint',
                      edgeInset: EdgeInsets.zero,
                      fontFamily: 'Gilroy-medium',
                      color: Colors.red.shade400,
                    )
                  ],
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                          return ComplaintView(
                            id: campaignId,
                          );
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                                    begin: Offset(
                                      1.0,
                                      0.0,
                                    ),
                                    end: Offset.zero)
                                .animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
