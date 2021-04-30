import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentTransactionItem extends StatelessWidget {
  const RecentTransactionItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(240, 240, 240, 0.4),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              )),
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
        title: Text(
          "Dangote Nigeria",
          style: TextStyle(
            fontFamily: "Gilroy-medium",
          ),
        ),
        trailing: Text(
          "-\$${1},500.75",
          style: TextStyle(
            color: Color(0xffc20000),
            fontFamily: "Gilroy-medium",
          ),
        ),
        subtitle: Text(
          "25 Nov 2020",
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 13,
            fontFamily: "Gilroy-medium",
          ),
        ),
      ),
    );
  }
}
