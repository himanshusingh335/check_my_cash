import 'package:flutter/material.dart';
import 'package:check_my_cash/backend/DataBaseServices.dart';
import 'package:check_my_cash/screens/New_Transaction.dart';
import 'package:provider/provider.dart';
import 'package:check_my_cash/screens/Home_Screen_Tabs/OverView.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Future dailyBalance;
String selectedDate;
Future<List> transactionList;

class HSDaily extends StatefulWidget {
  @override
  _HSDailyState createState() => _HSDailyState();
}

class _HSDailyState extends State<HSDaily> {
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now().day.toString() +
        '/' +
        DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString();
    dailyBalance = databaseServices.getDailyValues(selectedDate);
    transactionList = databaseServices.getTransactionsByDate(selectedDate);
  }

  void didChangeDependencies() {
    updateBalance = Provider.of<DatabaseServices>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        DatePicker(
          DateTime.utc(DateTime.now().year, DateTime.now().month),
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.green,
          selectedTextColor: Colors.white,
          daysCount: DateTime.now()
                  .difference(DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.january))
                  .inDays +
              1,
          onDateChange: (date) {
            // New date selected
            setState(() {
              selectedDate = date.day.toString() +
                  '/' +
                  date.month.toString() +
                  '/' +
                  date.year.toString();
              dailyBalance = databaseServices.getDailyValues(selectedDate);
              transactionList =
                  databaseServices.getTransactionsByDate(selectedDate);
            });
          },
        ),
        FutureBuilder(
          future: dailyBalance,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(1),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.pink,
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Center(
                              child: Text(
                                'BALANCE: Rs ' +
                                    snapshot.data[0]
                                        .toString()
                                        .replaceAll('(', '')
                                        .replaceAll(')', ''),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(1),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.green,
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Center(
                              child: Text(
                                'Credit Amount: Rs ' +
                                    snapshot.data[1]
                                        .toString()
                                        .replaceAll('(', '')
                                        .replaceAll(')', ''),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(1),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.red,
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Center(
                              child: Text(
                                'Debit Amount: Rs ' +
                                    snapshot.data[2]
                                        .toString()
                                        .replaceAll('(', '')
                                        .replaceAll(')', ''),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        ),
        FutureBuilder(
          future: transactionList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData)
              return Expanded(
                child: ListView.builder(
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
                          trailing: Text(snapshot.data[position].transactionDate
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
                              setState(() {
                                transactionList = databaseServices
                                    .getTransactionsByDate(selectedDate);
                                dailyBalance = databaseServices
                                    .getDailyValues(selectedDate);
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
                              setState(() {
                                transactionList = databaseServices
                                    .getTransactionsByDate(selectedDate);
                                dailyBalance = databaseServices
                                    .getDailyValues(selectedDate);
                              });
                            }),
                      ],
                    );
                  },
                ),
              );
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
