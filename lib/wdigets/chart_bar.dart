import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lable;
  final double spendingamount;
  final double spendingpctamount;

  ChartBar(this.lable, this.spendingamount, this.spendingpctamount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          SizedBox(height: constraints.maxHeight * 0.10),
          Container(
              height: constraints.maxHeight * 0.10,
              child: FittedBox(
                  child: Text(
                '\$${spendingamount.toStringAsFixed(0)}',
                style: TextStyle(
                    fontFamily: 'Boogaloo',
                    fontSize: 25,
                    color: Theme.of(context).textTheme.title.color),
              ))),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
              height: constraints.maxHeight * 0.5,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromRGBO(210, 210, 210, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  FractionallySizedBox(
                      heightFactor: spendingpctamount,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                      ))
                ],
              )),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.10,
            child: FittedBox(
              child: Text(
                lable,
                style: TextStyle(
                    fontFamily: 'Boogaloo',
                    fontSize: 25,
                    color: Theme.of(context).textTheme.title.color),
              ),
            ),
          )
        ],
      );
    });
  }
}
