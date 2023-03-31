import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RecentTransactionsList extends StatefulWidget {
  RecentTransactionsList({
    Key? key,
    this.sortFrequency,
  }) : super(key: key);

  final String? sortFrequency;

  @override
  State<RecentTransactionsList> createState() => _RecentTransactionsListState();
}

class _RecentTransactionsListState extends State<RecentTransactionsList> {
  @override
  Widget build(BuildContext context) {
    kDebugMode ? print({"sort data", widget.sortFrequency}) : null;
    return FutureBuilder(
      future: locator<UserService>()
          .retrieveChatTransactions(widget.sortFrequency!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.hasError) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long),
              CustomText(
                text: 'There was an issue fetching transaction history',
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontSize: 19,
                edgeInset: EdgeInsets.all(20),
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                fontFamily: 'Gilroy-medium',
              ),
            ],
          );
        }

        if (locator<UserService>().chatHistory?.transactions?.count == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long),
              CustomText(
                text: 'You\'ve not made any transaction(s) yet',
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontSize: 19,
                edgeInset: EdgeInsets.all(20),
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                fontFamily: 'Gilroy-medium',
              ),
            ],
          );
        }
        if (locator<UserService>().chatHistory == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long),
              CustomText(
                text:
                    'There was an issue fetching your transactions, check at a later time',
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontSize: 19,
                edgeInset: EdgeInsets.all(20),
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                fontFamily: 'Gilroy-medium',
              ),
            ],
          );
        }

        return ListView.separated(
          shrinkWrap: false,
          itemBuilder: (context, int index) => buildDetails(
            context,
            new List.from(locator<UserService>()
                .chatHistory!
                .transactions!
                .rows!
                .reversed)[index],
          ),
          separatorBuilder: (context, int index) => Divider(
            height: 10,
            thickness: 1,
          ),
          itemCount: locator<UserService>()
                      .chatHistory!
                      .transactions!
                      .rows!
                      .reversed
                      .length >
                  6
              ? 6
              : locator<UserService>()
                  .chatHistory!
                  .transactions!
                  .rows!
                  .reversed
                  .length,
        );
      },
    );
  }

  Widget buildDetails(BuildContext context, Map? item) {
    return ListTile(
      isThreeLine: true,
      leading: Container(
        decoration: BoxDecoration(
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Color.fromARGB(81, 57, 57, 57)
                    : Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            )),
        padding: EdgeInsets.all(20),
        child: Text(
          "C",
          style: TextStyle(
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.white
                    : Colors.black,
            fontSize: 18,
          ),
        ),
      ),
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
            text: 'Ref: ${item?["reference"]}\n',
            children: [
              TextSpan(
                text: "${item?['narration']}",
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
      trailing: Text(
        "\#${item?['amount']}",
        style: TextStyle(
          color: item?['transaction_type'] != 'credit'
              ? Color(0xffc20000)
              : Colors.greenAccent.shade400,
          fontFamily: "Gilroy-medium",
        ),
      ),
      subtitle: Text(
        "${DateTime.parse(item?['createdAt']).toString().substring(0, 11)}",
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
