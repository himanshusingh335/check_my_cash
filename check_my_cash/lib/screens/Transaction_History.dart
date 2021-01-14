import 'Home_Screen_Tabs/OverView.dart';
import 'package:check_my_cash/screens/New_Transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

Future<List> _transactionList;
String _selectedDate;

class TransactionHistoryScreen extends StatefulWidget {
  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().day.toString() +
        '/' +
        DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString();
    _transactionList = databaseServices.getTransactionsByDate(_selectedDate);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DatePicker(
            DateTime.utc(DateTime.now().year),
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.black,
            selectedTextColor: Colors.white,
            daysCount: DateTime.now()
                    .difference(DateTime(DateTime.now().year, DateTime.january,
                        DateTime.january))
                    .inDays +
                1,
            onDateChange: (date) {
              // New date selected
              setState(() {
                _selectedDate = date.day.toString() +
                    '/' +
                    date.month.toString() +
                    '/' +
                    date.year.toString();
                _transactionList =
                    databaseServices.getTransactionsByDate(_selectedDate);
              });
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: _transactionList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData)
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int position) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Card(
                          color: Colors.white,
                          elevation: 2.0,
                          child: ListTile(
                            title: Text(
                              'Rs ' +
                                  snapshot.data[position].transactionAmnt
                                      .toString(),
                              style: TextStyle(
                                color: snapshot.data[position].transactionAmnt
                                        .toString()
                                        .contains('-')
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                            subtitle:
                                Text(snapshot.data[position].reason.toString()),
                            trailing: Text(snapshot
                                .data[position].transactionDate
                                .toString()),
                          ),
                        ),
                        actions: <Widget>[
                          IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                databaseServices.deleteTransaction(int.parse(
                                    snapshot.data[position].id.toString()));
                                balance = updateBalance.getHomePageValues();
                                setState(() {
                                  _transactionList = databaseServices
                                      .getTransactionsByDate(_selectedDate);
                                });
                              }),
                        ],
                        secondaryActions: <Widget>[
                          IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                databaseServices.deleteTransaction(int.parse(
                                    snapshot.data[position].id.toString()));
                                balance = updateBalance.getHomePageValues();
                                setState(() {
                                  _transactionList = databaseServices
                                      .getTransactionsByDate(_selectedDate);
                                });
                              }),
                        ],
                      );
                    },
                  );
                else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } // By default, show a loading spinner.
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
