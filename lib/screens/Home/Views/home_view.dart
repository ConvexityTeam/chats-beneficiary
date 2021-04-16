import 'package:CHATS/api/transactions.dart';
import 'package:CHATS/screens/home/Views/drawer_view.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/widgets/home/recent_transaction/recent_transaction_list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {}
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
            elevation: 0,
            backgroundColor: Colors.white,
            leading: GestureDetector(
                onTap: () {
                  scaffoldKey.currentState.openDrawer();
                },
                child: Image.asset("assets/Group.png")),
            title: Text(
              "Home",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: "Gilroy-medium",
              ),
            ),
            actions: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/Ellipse 17.jpg"),
                      fit: BoxFit.contain,
                    )),
              ),
              SizedBox(width: 15),
            ],
          ),
          drawer: AppDrawer(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    height: 145,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      children: [
                        buildAccountDetailsCard(
                            amount: "\$${25},000",
                            percentage: "2.5%",
                            title: "Total Balance"),
                        buildAccountDetailsCard(
                            amount: "\$${25},000",
                            percentage: "2.5%",
                            title: "Monthly Income"),
                        buildAccountDetailsCard(
                            amount: "\$${25},000",
                            percentage: "2.5%",
                            title: "Monthly Expenses")
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  buildDateRow(),
                  SizedBox(height: 10),
                  buildRow(),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Total Balance",
                        style:
                            TextStyle(color: Color(0xff333333), fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.98,
                    // color: primaryColor,
                    child: LineChart(
                      sampleData1(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(width: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Recent Transactions",
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 16,
                            fontFamily: "Gilroy-medium"),
                      ),
                      Spacer(),
                      Text(
                        "See all",
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            fontFamily: "Gilroy-medium"),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  RecentTransactionsList()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow() {
    return Row(
      children: [
        SizedBox(width: 10),
        Text(
          "\$${12},500.",
          style: TextStyle(
            color: Colors.black,
            fontSize: 21,
            fontFamily: "Gilroy-Regular",
          ),
        ),
        SizedBox(width: 5),
        // Text(
        //   "2.5%",
        //   style: TextStyle(
        //       color: Color(0xff00c2a8),
        //       fontSize: 13,
        //       fontFamily: "Gilroy-Regular"),
        // ),
        // SizedBox(width: 2),
        // Icon(
        //   Icons.arrow_upward,
        //   size: 9,
        //   color: Color(0xff00c2a8),
        // ),
      ],
    );
  }

  Widget buildAccountDetailsCard(
      {@required String title,
      @required String amount,
      @required String percentage}) {
    return Card(
      elevation: 1,
      color: Colors.white,
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
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: 13,
                fontFamily: "Gilroy-Regular",
              ),
            ),
            SizedBox(height: 10),
            Text(
              amount,
              style: TextStyle(
                color: Colors.black,
                fontSize: 21,
                fontFamily: "Gilroy-medium",
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  percentage,
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

  Widget buildDateRow() {
    return Row(
      children: [
        SizedBox(width: 10),
        Container(
          height: 50,
          width: 90,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 140, 225, 0.1),
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              Text(
                "Daily",
                style: TextStyle(
                  fontFamily: "Gilroy-medium",
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 3),
              Image.asset("assets/icons/arrow_down.png"),
            ],
          ),
        ),
        SizedBox(width: 10),
        Text(
          "7th Dec",
          style: TextStyle(
            fontFamily: "Gilroy-Regular",
            fontSize: 14,
          ),
        )
      ],
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff555555),
              fontSize: 12,
              fontFamily: "Gilroy-Regular"),
          // margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'Mon';
              case 3:
                return 'Tues';
              case 5:
                return 'Wed';
              case 7:
                return 'Thurs';
              case 9:
                return 'Fri';
              case 11:
                return 'Sat';
              case 13:
                return 'Sun';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff555555),
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
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 1),
      ],
      isCurved: true,
      colors: [
        primaryColor,
      ],
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );

    return [
      // lineChartBarData1,
      lineChartBarData2,
      // lineChartBarData3,
    ];
  }
}
