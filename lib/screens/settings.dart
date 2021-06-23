import 'package:flutter/material.dart';
import 'package:check_my_cash/backend/DataBaseServices.dart';
import 'package:check_my_cash/screens/New_Transaction.dart';
import 'Home_Screen_Tabs/Daily.dart';
import 'package:check_my_cash/screens/Home_Screen_Tabs/OverView.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Row(
        children: <Widget>[
          Text(
            'Delete all Data:    ',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          RaisedButton(
              color: Colors.red,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
              ),
              elevation: 5,
              child: Text("DELETE ALL"),
              onPressed: () {
                updateBalance.deleteAllTransactions();
                balance = updateBalance.getOverViewValues();
                dailyBalance = updateBalance.getDailyValues(selectedDate);
                transactionList =
                    updateBalance.getTransactionsByDate(selectedDate);
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
