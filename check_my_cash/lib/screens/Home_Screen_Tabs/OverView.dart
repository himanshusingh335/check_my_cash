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

  void didChangeDependencies() {
    updateBalance = Provider.of<DatabaseServices>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: balance,
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
    );
  }
}
