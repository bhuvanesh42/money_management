import 'package:flutter/material.dart';
import 'package:money_management/wdigets/chart_bar.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import '';

class Chart extends StatelessWidget {
  final List<Transaction> recenttransaction;

  Chart(this.recenttransaction);

  List<Map<String, Object>> get grupedTracnsactionValue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalsum = 0.0;
      for (var i = 0; i < recenttransaction.length; i++) {
        if (recenttransaction[i].date.day == weekday.day &&
            recenttransaction[i].date.month == weekday.month &&
            recenttransaction[i].date.year == weekday.year) {
          totalsum += recenttransaction[i].amount;
        }
      }
      print(DateFormat.E().format(weekday).substring(0, 1));
      print(totalsum);

      return {'day': DateFormat.E().format(weekday), 'amount': totalsum};
    }).reversed.toList();
  }

  double get maxspend {
    return grupedTracnsactionValue.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(grupedTracnsactionValue);
    return Card(
      elevation: 15,
      margin: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: grupedTracnsactionValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(data['day'], data['amount'],
                  maxspend == 0.0 ? 0.0 : (data['amount'] as double) / maxspend),
            );
          }).toList(),
        ),
      ),
    );
  }
}
