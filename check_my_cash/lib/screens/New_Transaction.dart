import 'package:flutter/material.dart';
import 'package:check_my_cash/backend/DataBaseServices.dart';
import 'package:check_my_cash/backend/transactions.dart';
import 'package:check_my_cash/screens/Home_Screen.dart';

var databaseServices = new DatabaseServices();
TextEditingController amount;
TextEditingController reason;
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
    amount = new TextEditingController();
    reason = new TextEditingController();
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
              controller: reason,
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
                        ? int.parse('-' + amount.text)
                        : int.parse(amount.text),
                    transactionDate: DateTime.now().day.toString() +
                        '/' +
                        DateTime.now().month.toString() +
                        '/' +
                        DateTime.now().year.toString(),
                    reason: reason.text);
                databaseServices.addTransaction(transaction);
                amount.text = "";
                reason.text = "";
                Navigator.pushNamed(context, '/history');
              }),
        ],
      ),
    );
  }
}
