import 'package:flutter/material.dart';
import 'package:check_my_cash/backend/DataBaseServices.dart';
import 'package:check_my_cash/screens/New_Transaction.dart';
import 'package:provider/provider.dart';

Future balance;
var updateBalance;

class HSOverView extends StatefulWidget {
  @override
  _HSOverViewState createState() => _HSOverViewState();
}

class _HSOverViewState extends State<HSOverView> {
  @override
  void initState() {
    super.initState();
    balance = databaseServices.getOverViewValues();
  }

  @override
  Widget build(BuildContext context) {
    updateBalance = Provider.of<DatabaseServices>(context);
    return FutureBuilder(
      future: balance,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return ListView(
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
                child: Text(
                  'Total:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                padding: EdgeInsets.all(1),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.lightGreen[400],
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
                  color: Colors.red[400],
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
              Container(
                child: Text(
                  'This Month:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                padding: EdgeInsets.all(1),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.green[300],
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Center(
                          child: Text(
                            'Credit Amount: Rs ' +
                                snapshot.data[3]
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
                  color: Colors.red[300],
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Center(
                          child: Text(
                            'Debit Amount: Rs ' +
                                snapshot.data[4]
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
                child: Text(
                  'Last Month:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                padding: EdgeInsets.all(1),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.green[100],
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Center(
                          child: Text(
                            'Credit Amount: Rs ' +
                                snapshot.data[5]
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
                  color: Colors.red[100],
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Center(
                          child: Text(
                            'Debit Amount: Rs ' +
                                snapshot.data[6]
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
    );
  }
}
