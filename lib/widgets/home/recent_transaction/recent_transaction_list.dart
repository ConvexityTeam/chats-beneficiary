import 'package:CHATS/api/transactions.dart';
import 'package:CHATS/widgets/home/recent_transaction/recent_transaction_item.dart';
import 'package:flutter/material.dart';

class RecentTransactionsList extends StatelessWidget {
  const RecentTransactionsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: TransactionAPI().recentTransactions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        print({'recent transactions', snapshot.data});

        if (snapshot.hasError) {
          return Container(
            child: Text(
                "Sorry it looks like we weren't able to retrieve your transactions"),
          );
        }

        if (snapshot.data.isEmpty) {
          return Container(
            margin: EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Icon(Icons.receipt_long),
                Text("You don't have any transactions yet."),
              ],
            ),
          );
        }

        print({'recent transactions', snapshot.data});
        return Column(
            children: snapshot.data
                .map((transcation) => RecentTransactionItem())
                .toList());
      },
    );
  }
}
