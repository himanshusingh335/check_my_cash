import 'package:check_my_cash/backend/transactions.dart';
import 'package:flutter/material.dart';
import 'package:check_my_cash/backend/DataBaseServices.dart';

class NewSpendingScreen extends StatefulWidget {
  @override
  _NewSpendingScreenState createState() => _NewSpendingScreenState();
}

TextEditingController amount = new TextEditingController();
TextEditingController date = new TextEditingController();
TextEditingController reason = new TextEditingController();
TextEditingController id = new TextEditingController();

class _NewSpendingScreenState extends State<NewSpendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'New Spending',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              right: 10,
              left: 10,
            ),
            child: TextField(
              controller: amount,
              decoration: InputDecoration(
                hintText: 'Enter Amount',
                labelText: 'Amount Spent',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              right: 10,
              left: 10,
            ),
            child: TextField(
              controller: date,
              decoration: InputDecoration(
                hintText: 'Enter Date of transaction',
                labelText: 'Date',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              right: 10,
              left: 10,
            ),
            child: TextField(
              controller: id,
              decoration: InputDecoration(
                hintText: 'Enter id',
                labelText: 'id',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              right: 10,
              left: 10,
            ),
            child: TextField(
              controller: reason,
              decoration: InputDecoration(
                hintText: 'Enter reason',
                labelText: 'Reason',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          RaisedButton(
              color: Colors.green,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
              ),
              elevation: 5,
              child: Text("ADD"),
              onPressed: () {
                var t = new Transactions(
                    id: id,
                    transactionAmnt: int.parse(amount.text),
                    transactionDate: date.toString(),
                    reason: reason.toString());

                var K = new DatabaseServices();
                K.initializeDb();
                K.addTransaction(t);
              }),
        ],
      ),
    );
  }
}
