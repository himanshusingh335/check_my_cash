import 'package:check_my_cash/backend/DataBaseServices.dart';
import 'package:check_my_cash/screens/New_Transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future balance;
var updateBalance;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    balance = databaseServices.getHomePageValues();
  }

  void didChangeDependencies() {
    updateBalance = Provider.of<DatabaseServices>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Check My Cash',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              child: Text(
                "Check My Cash",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Transaction History'),
              onTap: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Developer info'),
              onTap: () {
                //launchURL();
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
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
      ),
    );
  }
}
