import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/wdigets/new_transaction.dart';
import 'package:money_management/wdigets/splash_screen.dart';
import 'package:money_management/wdigets/transaction_list.dart';

import './wdigets/chart.dart';
import 'models/transactions.dart';

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter app',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(color: Colors.black),
                subtitle: TextStyle(color: Colors.white),
              )),
      home: SplashScreen(),
    );
  }
}

class Myhomepage extends StatefulWidget {
  @override
  _MyhomepageState createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();
  bool _switchval = false;

  final List<Transaction> _usertransaction = [
    /*Transaction(
      id: 't1',
      title: 'mobile',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'car',
      amount: 1000,
      date: DateTime.now(),
    )*/
  ];

  List<Transaction> get _recentransaction {
    return _usertransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addtransaction(String txtitle, double txamount, DateTime chosenDate) {
    final newtx = Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        date: chosenDate);
    setState(() {
      _usertransaction.add(newtx);
    });
  }

  void showbottompage(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Newtransaction(_addtransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void deletetransaction(String id) {
    setState(() {
      _usertransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appbar = AppBar(
      title: Text(
        'Money Management',
        style: TextStyle(
            fontFamily: 'Boogaloo',
            fontSize: 25,
            color: Theme.of(context).textTheme.subtitle.color),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.loupe,
            color: Theme.of(context).textTheme.subtitle.color,
          ),
          onPressed: () => showbottompage(context),
        )
      ],
    );
    final txcontainer = Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.6,
        child: TransactionList(_usertransaction, deletetransaction));
    return LayoutBuilder(builder: (ctx, contraints) {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: appbar,
        body: Column(
          children: <Widget>[
            if (islandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('swtich to chat and list',
                      style: TextStyle(
                          fontFamily: 'Boogaloo',
                          fontSize: 25,
                          color: Theme.of(context).textTheme.subtitle.color)),
                  Switch.adaptive(
                      value: _switchval,
                      onChanged: (va) {
                        setState(() {
                          _switchval = va;
                        });
                      }),
                ],
              ),
            if (!islandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(_recentransaction)),
            if (!islandscape) txcontainer,
            if (islandscape)
              _switchval
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.6,
                      child: Chart(_recentransaction))
                  : txcontainer,
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Platform.isIOS
            ? Container()
            : FloatingActionButton(
                child: Icon(Icons.add,
                    color: Theme.of(context).textTheme.subtitle.color),
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () => showbottompage(context),
              ),
      );
    });
  }
}
