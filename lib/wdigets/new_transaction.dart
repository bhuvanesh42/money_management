import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Newtransaction extends StatefulWidget {
  final Function addtx;

  Newtransaction(this.addtx);

  @override
  _NewtransactionState createState() => _NewtransactionState();
}

class _NewtransactionState extends State<Newtransaction> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();
  DateTime selectedDate;

  void Submitdata() {
    final entertitle = titlecontroller.text;
    final enteramount = double.parse(amountcontroller.text);

    if (enteramount <= 0 || entertitle.isEmpty || selectedDate == null) {
      return;
    }

    widget.addtx(entertitle, enteramount, selectedDate);
    Navigator.of(context).pop();
  }

  void Datapicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now(),  builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Colors.blue,
          accentColor: Colors.blue,
          colorScheme: ColorScheme.light(primary: Colors.blue),

          buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary
          ),
        ),
        child: child,
      );
    },)
        .then((pickeddate) {
      if (pickeddate == null) {
        return;
      }
      setState(() {
        selectedDate = pickeddate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 10,
          margin: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),style: TextStyle(fontFamily: 'Boogaloo'),
                    controller: titlecontroller,
                    onSubmitted: (_) => Submitdata(),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),style: TextStyle(fontFamily: 'Boogaloo'),
                    controller: amountcontroller,
                    onSubmitted: (_) => Submitdata(),
                    keyboardType: TextInputType.number,
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            selectedDate == null
                                ? ' No date choosen'
                                : 'Picked Date : ${DateFormat.yMMMMd().format(selectedDate)}',
                            style: TextStyle(
                                fontFamily: 'Boogaloo',
                                fontSize: 15,
                                color: Theme.of(context).textTheme.title.color),
                          ),
                          FlatButton(
                            child: Text(
                              'Choose date',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Boogaloo',
                                fontSize: 20
                              ),
                            ),
                            onPressed: Datapicker,
                          )
                        ],
                      )),
                  RaisedButton(
                    child: Text(
                      'Add data',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle.color,
                      fontSize: 20,
                      fontFamily: 'Boogaloo'),
                    ),
                    onPressed: Submitdata,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
