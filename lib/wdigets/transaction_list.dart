import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deletetx;

  TransactionList(this.transaction, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      margin: EdgeInsets.all(10),
      child: transaction.isEmpty
          ? LayoutBuilder(builder: (context, contraints) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: contraints.maxHeight * 0.2,
                  ),
                  Container(
                      height: contraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/empty_data_set.png')),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                            child: Text('\$${transaction[index].amount}',
                            style: TextStyle(color: Theme.of(context).textTheme.subtitle.color,
                            fontFamily: 'Boogaloo',
                            fontSize: 20),)),
                      ),
                    ),
                    title: Text(
                      transaction[index].title,
                        style: TextStyle(fontFamily: 'Boogaloo',fontSize: 15,color: Theme.of(context).textTheme.title.color),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(transaction[index].date),style: TextStyle(fontFamily: 'Boogaloo',fontSize: 15,color: Theme.of(context).textTheme.title.color),
                    ),
                    trailing: MediaQuery.of(context).size.width > 360
                        ? FlatButton.icon(
                        icon: Icon(Icons.delete,
                        color: Colors.red),
                        onPressed: () => deletetx(transaction[index].id),
                        label: Text('Delete',style: TextStyle(fontFamily: 'Boogaloo',fontSize: 15,color: Theme.of(context).textTheme.title.color),),
                    textColor: Colors.red,)
                        : IconButton(
                            icon: Icon(Icons.delete,
                            color: Colors.red,),
                            onPressed: () => deletetx(transaction[index].id)),
                  ),
                );

                /*Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: 100,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  style: BorderStyle.solid,
                                  width: 3)),
                          child: FittedBox(
                            child: Text(
                              '\$: ${transaction[index].amount}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transaction[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          Text(
                            DateFormat.yMMMMd().format(transaction[index].date),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  elevation: 10,
                );*/
              },
              itemCount: transaction.length,
            ),
    );
  }
}
