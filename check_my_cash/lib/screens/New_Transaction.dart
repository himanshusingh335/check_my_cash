import 'package:check_my_cash/screens/Home_Screen_Tabs/Daily.dart';
import 'package:flutter/material.dart';
import 'package:check_my_cash/backend/DataBaseServices.dart';
import 'package:check_my_cash/backend/transactions.dart';
import 'Home_Screen_Tabs/OverView.dart';

var databaseServices = new DatabaseServices();
TextEditingController _amount;
TextEditingController _reason;
enum TransactionType { debit, credit }
TransactionType transactionType = TransactionType.debit;

class NewTransactionScreen extends StatefulWidget {
  @override
  _NewTransactionScreenState createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  @override
  void initState() {
    super.initState();
    _amount = new TextEditingController();
    _reason = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'New Transaction',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  child: ListTile(
                    title: const Text('Debit'),
                    leading: Radio(
                      value: TransactionType.debit,
                      groupValue: transactionType,
                      onChanged: (TransactionType value) {
                        setState(() {
                          transactionType = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: ListTile(
                    title: const Text('Credit'),
                    leading: Radio(
                      value: TransactionType.credit,
                      groupValue: transactionType,
                      onChanged: (TransactionType value) {
                        setState(() {
                          transactionType = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              right: 10,
              left: 10,
            ),
            child: TextField(
              controller: _amount,
              decoration: InputDecoration(
                hintText: 'Enter Amount',
                labelText: 'Amount Spent',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              keyboardType: TextInputType.number,
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
              controller: _reason,
              decoration: InputDecoration(
                hintText: '  Enter reason',
                labelText: '  Reason',
                contentPadding: const EdgeInsets.symmetric(vertical: 30.0),
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
                var transaction = new Transactions.withoutid(
                    transactionAmnt: transactionType == TransactionType.debit
                        ? int.parse('-' + _amount.text)
                        : int.parse(_amount.text),
                    transactionDate: DateTime.now().day.toString() +
                        '/' +
                        DateTime.now().month.toString() +
                        '/' +
                        DateTime.now().year.toString(),
                    reason: _reason.text);
                databaseServices.addTransaction(transaction);
                balance = updateBalance.getOverViewValues();
                dailyBalance = updateBalance.getDailyValues(selectedDate);
                transactionList =
                    updateBalance.getTransactionsByDate(selectedDate);
                _amount.text = "";
                _reason.text = "";
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _amount.dispose();
    _reason.dispose();
    super.dispose();
  }
}
