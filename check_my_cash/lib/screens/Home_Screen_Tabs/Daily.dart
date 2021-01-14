import 'package:flutter/material.dart';
import 'package:check_my_cash/backend/DataBaseServices.dart';
import 'package:check_my_cash/screens/New_Transaction.dart';
import 'package:provider/provider.dart';
import 'package:check_my_cash/screens/Home_Screen_Tabs/OverView.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

Future _dailyBalance;
String _selectedDate;

class HSDaily extends StatefulWidget {
  @override
  _HSDailyState createState() => _HSDailyState();
}

class _HSDailyState extends State<HSDaily> {
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().day.toString() +
        '/' +
        DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString();
    _dailyBalance = databaseServices.getDailyValues(_selectedDate);
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
          DateTime.utc(DateTime.now().year),
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.black,
          selectedTextColor: Colors.white,
          daysCount: DateTime.now()
                  .difference(DateTime(
                      DateTime.now().year, DateTime.january, DateTime.january))
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
              _dailyBalance = databaseServices.getDailyValues(_selectedDate);
            });
          },
        ),
        Expanded(
          child: FutureBuilder(
            future: _dailyBalance,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return ListView(
                  children: <Widget>[
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: Text(
                          'Balance Amount: Rs ' +
                              snapshot.data[0]
                                  .toString()
                                  .replaceAll('(', '')
                                  .replaceAll(')', ''),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: Text(
                          'Credit Amount: Rs ' +
                              snapshot.data[1]
                                  .toString()
                                  .replaceAll('(', '')
                                  .replaceAll(')', ''),
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: Text(
                          'Debit Amount: Rs ' +
                              snapshot.data[2]
                                  .toString()
                                  .replaceAll('(', '')
                                  .replaceAll(')', ''),
                          style: TextStyle(
                            color: Colors.red,
                          ),
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
        ),
      ],
    );
  }
}
