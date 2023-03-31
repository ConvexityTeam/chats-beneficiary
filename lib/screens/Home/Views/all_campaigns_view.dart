import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/screens/Home/Views/drawer_view.dart';
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

class AllCampaignsView extends StatefulWidget {
  const AllCampaignsView({Key? key}) : super(key: key);

  @override
  _AllCampaignsViewState createState() => _AllCampaignsViewState();
}

class _AllCampaignsViewState extends State<AllCampaignsView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Create key for each memeber in the list
  // final GlobalKey<_CustomButtonState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        title: CustomText(
            text: 'All Campaigns',
            fontFamily: 'Gilroy-medium',
            fontSize: 22,
            edgeInset: EdgeInsets.zero,
            textAlign: TextAlign.left,
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white),
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            // scaffoldKey.currentState!.openDrawer();
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white),
        ),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: locator<UserService>().getPublicCampaigns(),
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
                buildTotalHeader(locator<UserService>().campaigns!.length),
                SizedBox(height: 20),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () =>
                        locator<UserService>().getPublicCampaigns(),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: locator<UserService>()
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
                                      item.id,
                                    ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTotalHeader(int total) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(18),
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
            child: CustomText(
              text: 'Total: $total Campaign(s)',
              edgeInset: EdgeInsets.zero,
              fontFamily: 'Gilroy-light',
              textAlign: TextAlign.center,
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // SizedBox(width: 20),
        // Container(
        //   width: 60,
        //   padding: EdgeInsets.all(12),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(5),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.withOpacity(.2),
        //         offset: Offset(0, 5),
        //         blurRadius: 10,
        //         spreadRadius: 2,
        //       ),
        //     ],
        //   ),
        //   child: FittedBox(
        //     child: Icon(Icons.list_alt_outlined, color: Colors.black),
        //   ),
        // )
      ],
    );
  }

  Widget buildOptCard(
    String? title,
    String? description,
    String? dateCreated,
    String? amount,
    String? status,
    int? campaignId,
    // _key,
    // Function? viewTaskDetails,
  ) {
    print({
      'Iterable test',
      !locator<UserService>()
          .data!
          .campaigns!
          .every((element) => element.id == campaignId)
    });
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
                  // key: _key,
                  height: 52,
                  borderColor: Colors.white,
                  bgColor: Constants.usedGreen,
                  mainAxisAlignment: MainAxisAlignment.center,
                  disabled: locator<UserService>()
                      .data!
                      .campaigns!
                      .any((element) => element.id == campaignId),
                  useOverlay: true,
                  // disabled: ,
                  child: CustomText(
                    text: locator<UserService>()
                            .data!
                            .campaigns!
                            .any((element) => element.id == campaignId)
                        ? 'Onboarded'
                        : 'Opt In',
                    edgeInset: EdgeInsets.zero,
                    fontFamily: 'Gilroy-medium',
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () async {
                    if (locator<UserService>().data?.firstName != null &&
                        locator<UserService>().data?.lastName != null) {
                      String? message = await locator<UserService>()
                          .joinCampaign(campaignId!);
                      print({"Campaign return msg", message});

                      final snackBar = SnackBar(
                        content: Text(message!),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      );
                      snackBar.show(context);
                      Navigator.pushNamed(context, campaigns);
                    } else {
                      final snackBar = SnackBar(
                        content: Text(
                            'Please update your profile before joining a campaign'),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      );
                      return snackBar.show(context);
                    }
                  },
                ),
              ),
              // SizedBox(width: 15),
              // Expanded(
              //   child: CustomButton(
              //     height: 52,
              //     bgColor: Colors.white,
              //     borderColor: Colors.red.shade400,
              //     useOverlay: true,
              //     children: [
              //       CustomText(
              //         text: 'Complaint',
              //         edgeInset: EdgeInsets.zero,
              //         fontFamily: 'Gilroy-medium',
              //         color: Colors.red.shade400,
              //       )
              //     ],
              //     onTap: () {
              //       Navigator.pushNamed(context, complaint);
              //     },
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTaskOptCard(
    String? title,
    String? description,
    String? dateCreated,
    String? amount,
    String? status,
    int? taskNumber,
    int? campaignId,
    // Function? viewTaskDetails,
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
                  borderColor: Colors.white,
                  bgColor: Constants.usedGreen,
                  disabled: locator<UserService>()
                      .data!
                      .campaigns!
                      .any((element) => element.id == campaignId),
                  useOverlay: true,
                  child: CustomText(
                    text: locator<UserService>()
                            .data!
                            .campaigns!
                            .any((element) => element.id == campaignId)
                        ? 'Onboarded'
                        : 'Opt In',
                    edgeInset: EdgeInsets.zero,
                    fontFamily: 'Gilroy-medium',
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () async {
                    if (locator<UserService>().data?.firstName != null &&
                        locator<UserService>().data?.lastName != null) {
                      String? message = await locator<UserService>()
                          .joinCampaign(campaignId!);
                      final snackBar = SnackBar(
                        content: Text(message!),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      );
                      snackBar.show(context);
                      Navigator.pushNamed(context, campaigns);
                    } else {
                      final snackBar = SnackBar(
                        content: Text(
                          'Please update your profile before joining a campaign',
                        ),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      );
                      return snackBar.show(context);
                    }
                  },
                ),
              ),
              // SizedBox(width: 15),
              // Expanded(
              //   child: CustomButton(
              //     height: 52,
              //     bgColor: Colors.white,
              //     borderColor: Colors.red.shade400,
              //     useOverlay: true,
              //     children: [
              //       CustomText(
              //         text: 'Complaint',
              //         edgeInset: EdgeInsets.zero,
              //         fontFamily: 'Gilroy-medium',
              //         color: Colors.red.shade400,
              //       )
              //     ],
              //     onTap: () {
              //       Navigator.pushNamed(context, complaint);
              //     },
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
