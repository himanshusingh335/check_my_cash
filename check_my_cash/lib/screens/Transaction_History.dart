import 'package:check_my_cash/backend/transactions.dart';
import 'package:check_my_cash/screens/New_Spending.dart';
import 'package:flutter/material.dart';
import 'package:check_my_cash/backend/BudgetClass.dart';
import 'package:check_my_cash/backend/DataBaseServices.dart';

class TransactionHistoryScreen extends StatefulWidget {
  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  Future<List> f;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Transaction History',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder(
        future: f,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
              itemCount: snapshot.data,
              itemBuilder: (BuildContext context, int position) {
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    title: Text('hello'),
                    subtitle: Text('hello'),
                    onTap: () {},
                  ),
                );
              },
            );
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
