// import 'package:CHATS/api/transactions.dart';
import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/screens/Home/Views/drawer_view.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
// import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/error_widget_handler.dart';
import 'package:CHATS/widgets/home/recent_transaction/recent_transaction_list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? chartSortValue = "Yearly";
  late String? dateRange = Jiffy(DateTime.now())
      .subtract(duration: Duration(days: 1))
      .format('do MMM yyy');

  // ImageProvider<Object> getDP(user) {
  //   if (user != null) {
  //     return NetworkImage(user.profilePic!);
  //   } else {
  //     return AssetImage('assets/Ellipse 4.png');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // BeneficiaryUser? user = locator<UserService>().data;
    print({"Current theme", ThemeBuilder.of(context)!.getCurrentTheme()});
    return FutureBuilder(
      future: locator<UserService>().setUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
              leading: GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  child: Image.asset('assets/Group.png',
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white)),
              title: CustomText(
                text: 'Home',
                fontFamily: 'Gilroy-medium',
                fontSize: 22,
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                edgeInset: EdgeInsets.only(top: 3),
                textAlign: TextAlign.left,
              ),
              actions: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/profile_img_placeholder.jpeg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
            drawer: AppDrawer(),
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        if (snapshot.hasError) {
          print({"Error state:", snapshot.error.toString()});
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
              leading: GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  child: Image.asset('assets/Group.png',
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white)),
              title: CustomText(
                text: 'Home',
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontFamily: 'Gilroy-medium',
                fontSize: 22,
                edgeInset: EdgeInsets.only(top: 3),
                textAlign: TextAlign.left,
              ),
              actions: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/profile_img_placeholder.jpeg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
            drawer: AppDrawer(),
            body: ErrorWidgetHandler(onTap: () {
              setState(() {});
            }),
          );
        }
        // if (snapshot.hasError) {
        //   return Scaffold(
        //     key: scaffoldKey,
        //     appBar: AppBar(
        //       elevation: 0,
        //       backgroundColor: Colors.white,
        //       leading: GestureDetector(
        //           onTap: () {
        //             scaffoldKey.currentState?.openDrawer();
        //           },
        //           child: Image.asset('assets/Group.png')),
        //       title: CustomText(
        //         text: 'Home',
        //         fontFamily: 'Gilroy-medium',
        //         fontSize: 22,
        //         edgeInset: EdgeInsets.only(top: 3),
        //         textAlign: TextAlign.left,
        //       ),
        //       actions: [
        //         Container(
        //           height: 45,
        //           width: 45,
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             image: DecorationImage(
        //               image: AssetImage('assets/Ellipse 4.png'),
        //               fit: BoxFit.contain,
        //             ),
        //           ),
        //         ),
        //         SizedBox(width: 15),
        //       ],
        //     ),
        //     drawer: AppDrawer(),
        //     body: Center(
        //       child: Text('An error occured while getting data'),
        //     ),
        //   );
        // }

        return WillPopScope(
          // ignore: missing_return
          onWillPop: () => onBackPressed(context),
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
              leading: GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  child: Image.asset('assets/Group.png',
                      color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white)),
              title: CustomText(
                text: 'Home',
                fontFamily: 'Gilroy-medium',
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontSize: 22,
                edgeInset: EdgeInsets.only(top: 3),
                textAlign: TextAlign.left,
              ),
              actions: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(locator<UserService>()
                              .data
                              ?.profilePic ??
                          'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
            drawer: AppDrawer(),
            body: RefreshIndicator(
              onRefresh: () async {
                await locator<UserService>().setUserData();
              },
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.white
                      : primaryColorDarkMode,
                  child: Column(
                    children: [
                      // SizedBox(height: 20),
                      Container(
                        height: 140,
                        width: double.infinity,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          children: [
                            buildAccountDetailsCard(
                                amount:
                                    '\#${locator<UserService>().data?.totalWalletBalance?.toStringAsFixed(2)}',
                                percentage: "0.0%",
                                title: "Total Balance"),
                            buildAccountDetailsCard(
                                amount:
                                    "\#${locator<UserService>().data?.totalWalletReceived?.toStringAsFixed(2)}",
                                percentage: "0.0%",
                                title: "Total Income"),
                            buildAccountDetailsCard(
                                amount:
                                    "\#${locator<UserService>().data?.totalWalletSpent?.toStringAsFixed(2)}",
                                percentage: "0.0%",
                                title: "Total Expenses")
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: StatefulBuilder(builder: (ctx, setState) {
                          return FutureBuilder(
                            // future: locator<UserService>().retrieveChatTransactions(
                            //     chartSortValue!.toLowerCase()),
                            future: null,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }

                              if (snapshot.hasError) {
                                return Text(
                                  'There was an error getting the chart data',
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-medium',
                                      fontSize: 14),
                                );
                              }

                              return Column(
                                // mainAxisSize: MainAxisSize.max,
                                children: [
                                  buildDateRow(setState),
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      '$chartSortValue Transactions Chart',
                                      style: TextStyle(
                                          fontFamily: 'Gilroy-medium'),
                                    ),
                                  ),
                                  Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width *
                                        0.98,
                                    padding: EdgeInsets.only(top: 10),
                                    // color: primaryColor,
                                    child: LineChart(
                                      sampleData1(context, chartSortValue),
                                      swapAnimationDuration:
                                          const Duration(milliseconds: 250),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Recent Transactions",
                                          style: TextStyle(
                                              color: ThemeBuilder.of(context)!
                                                          .getCurrentTheme() ==
                                                      Brightness.light
                                                  ? Color(0xff333333)
                                                  : Colors.white,
                                              fontSize: 16,
                                              fontFamily: "Gilroy-medium"),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, notification);
                                          },
                                          child: Text(
                                            "See all",
                                            style: TextStyle(
                                                color: ThemeBuilder.of(context)!
                                                            .getCurrentTheme() ==
                                                        Brightness.light
                                                    ? Color(0xff333333)
                                                    : Colors.white,
                                                fontSize: 14,
                                                fontFamily: "Gilroy-medium"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: RecentTransactionsList(
                                      sortFrequency: chartSortValue,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildAccountDetailsCard({
    @required String? title,
    @required String? amount,
    @required String? percentage,
  }) {
    return Card(
      elevation: 1,
      color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
          ? Colors.white
          : Colors.teal.withOpacity(.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(12),
        height: 115,
        width: 200,
        decoration: BoxDecoration(
            // color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
            //     ? Colors.white
            //     : Colors.teal,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5),
            Text(
              title!,
              style: TextStyle(
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Color(0xff333333)
                    : Colors.white,
                fontSize: 13,
                fontFamily: "Gilroy-Regular",
              ),
            ),
            SizedBox(height: 10),
            Text(
              amount!,
              style: TextStyle(
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontSize: 21,
                fontFamily: "Gilroy-medium",
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  percentage!,
                  style: TextStyle(
                    color: Color(0xff00c2a8),
                    fontSize: 13,
                    fontFamily: "Gilroy-Regular",
                  ),
                ),
                Icon(
                  Icons.arrow_upward,
                  size: 9,
                  color: Color(0xff00c2a8),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildDateRow(setState) {
    return Row(
      children: [
        SizedBox(width: 10),
        PopupMenuButton(
          itemBuilder: (_) => <PopupMenuItem<String>>[
            new PopupMenuItem<String>(child: new Text('Daily'), value: 'daily'),
            new PopupMenuItem<String>(
                child: new Text('Weekly'), value: 'weekly'),
            new PopupMenuItem<String>(
                child: new Text('Monthly'), value: 'monthly'),
            new PopupMenuItem<String>(
                child: new Text('Yearly'), value: 'yearly'),
          ],
          onSelected: (value) async {
            // Change chart view and configure the returned date
            print(value);
            setState(() {
              chartSortValue = value == 'daily'
                  ? 'Daily'
                  : value == 'weekly'
                      ? 'Weekly'
                      : value == 'monthly'
                          ? 'Monthly'
                          : 'Yearly';
              dateRange = Jiffy(DateTime.now())
                  .subtract(
                      duration: value == 'daily'
                          ? Duration(days: 1)
                          : value == 'weekly'
                              ? Duration(days: 7)
                              : value == 'monthly'
                                  ? Duration(days: 30)
                                  : Duration(days: 365))
                  .format('do MMM yyy');
            });
          },
          child: Container(
            height: 35,
            width: 85,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 140, 225, 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "$chartSortValue",
                    style: TextStyle(
                      fontFamily: "Gilroy-medium",
                      fontSize: 12,
                    ),
                  ),
                ),
                // Image.asset("assets/icons/arrow_down.png"),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white,
                )
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          '${Jiffy(DateTime.now()).format('do MMM yyy')}',
          style: TextStyle(
            fontFamily: "Gilroy-Regular",
            fontSize: 14,
          ),
        ),
        Text(' - '),
        Text(
          '$dateRange',
          style: TextStyle(
            fontFamily: "Gilroy-Regular",
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  LineChartData sampleData1(BuildContext context, String? sort) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {
          if (kDebugMode) print({"Line Touch Callback"});
        },
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => TextStyle(
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Color(0xff555555)
                  : Colors.white,
              fontSize: 12,
              fontFamily: "Gilroy-Regular"),
          // margin: 10,
          getTitles: (value) {
            return getBottomTitle(value, sort);
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
          getTextStyles: (value, _) => TextStyle(
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Color(0xff555555)
                    : Colors.white,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        // show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.transparent,
            // width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: sort?.toLowerCase() == 'daily'
          ? 13
          : sort?.toLowerCase() == 'weekly'
              ? 8
              : sort?.toLowerCase() == 'monthly'
                  ? 13
                  : 7,
      minY: 0,
      // maxY: 200,
      lineBarsData: linesBarData1(sort?.toLowerCase()),
    );
  }

  getBottomTitle(value, String? sort) {
    if (sort?.toLowerCase() == 'daily') {
      switch (value.toInt()) {
        case 1:
          return '12';
        case 2:
          return '01';
        case 3:
          return '02';
        case 4:
          return '03';
        case 5:
          return '04';
        case 6:
          return '05';
        case 7:
          return '06';
        case 8:
          return '07';
        case 9:
          return '08';
        case 10:
          return '09';
        case 11:
          return '10';
        case 12:
          return '11';
      }
      return '';
    } else if (sort?.toLowerCase() == 'weekly') {
      switch (value.toInt()) {
        case 1:
          return 'Mon';
        case 2:
          return 'Tue';
        case 3:
          return 'Wed';
        case 4:
          return 'Thu';
        case 5:
          return 'Fri';
        case 6:
          return 'Sat';
        case 7:
          return 'Sun';
      }
      return '';
    } else if (sort?.toLowerCase() == 'monthly') {
      switch (value.toInt()) {
        case 1:
          return 'Jan';
        case 2:
          return 'Feb';
        case 3:
          return 'Mar';
        case 4:
          return 'Apr';
        case 5:
          return 'May';
        case 6:
          return 'Jun';
        case 7:
          return 'July';
        case 8:
          return 'Aug';
        case 9:
          return 'Sep';
        case 10:
          return 'Oct';
        case 11:
          return 'Nov';
        case 12:
          return 'Dec';
      }
      return '';
    } else if (sort?.toLowerCase() == 'yearly') {
      switch (value.toInt()) {
        case 1:
          return Jiffy(DateTime.now())
              // .subtract(duration: Duration(days: 365))
              .format('yyy');
        case 2:
          return Jiffy(DateTime.now())
              .subtract(duration: Duration(days: 365))
              .format('yyy');
        case 3:
          return Jiffy(DateTime.now())
              .subtract(duration: Duration(days: (365 * 2)))
              .format('yyy');
        case 4:
          return Jiffy(DateTime.now())
              .subtract(duration: Duration(days: (365 * 3)))
              .format('yyy');
        case 5:
          return Jiffy(DateTime.now())
              .subtract(duration: Duration(days: (365 * 4)))
              .format('yyy');
        case 6:
          return Jiffy(DateTime.now())
              .subtract(duration: Duration(days: (365 * 5)))
              .format('yyy');
      }
      return '';
    } else {
      return '';
    }
  }

  List<LineChartBarData> linesBarData1(String? sort) {
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: locator<UserService>().chatHistory == null
          ? [FlSpot(0, 0)]
          : locator<UserService>().chatHistory?.transactions?.count == 0
              ? [FlSpot(0, 0)]
              : locator<UserService>().chatHistory?.transactions?.rows?.map(
                  (row) {
                    print({
                      "Data sort",
                      sort == 'daily'
                          ? Jiffy(row["createdAt"]).hour.toDouble()
                          : sort == 'weekly'
                              ? Jiffy(row["createdAt"]).day.toDouble()
                              : sort == 'monthly'
                                  ? Jiffy(row["createdAt"]).month.toDouble()
                                  : Jiffy(row["createdAt"]).year.toDouble(),
                      'Amount',
                      row["amount"].toDouble(),
                      'Length',
                      locator<UserService>()
                          .chatHistory
                          ?.transactions
                          ?.rows
                          ?.length
                    });
                    return FlSpot(
                      sort == 'daily'
                          ? Jiffy(row["createdAt"]).hour.toDouble()
                          : sort == 'weekly'
                              ? Jiffy(row["createdAt"]).day.toDouble()
                              : sort == 'monthly'
                                  ? Jiffy(row["createdAt"]).month.toDouble()
                                  : Jiffy(row["createdAt"]).year.toDouble(),
                      row["amount"].toDouble(),
                    );
                  },
                ).toList(),
      // [
      //   FlSpot(1, 0),
      //   FlSpot(3, 0),
      //   FlSpot(6, 0),
      //   FlSpot(10, 0),
      //   FlSpot(12, 0),
      //   FlSpot(13, 0),
      // ],
      isCurved: true,
      colors: [
        Constants.usedGreen,
      ],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [Constants.usedGreen.withOpacity(.2), Colors.transparent],
        gradientFrom: Offset(5, 4),
        gradientTo: Offset(5, 8),
      ),
    );

    return [
      // lineChartBarData1,
      lineChartBarData2,
      // lineChartBarData3,
    ];
  }
}
