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

        if (snapshot.hasError) {
          return Container(
            child: Text(
                "Sorry if looks like we weren't able to retrieve your transactions"),
          );
        }

        if (snapshot.data.isEmpty) {
          return Container(
            child: Text("You don't have any transactions yet."),
          );
        }

        return Column(
            children: snapshot.data
                .map((transcation) => RecentTransactionItem())
                .toList());
      },
    );
  }
}
