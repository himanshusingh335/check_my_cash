import 'package:check_my_cash/screens/New_Transaction.dart';
import 'package:flutter/material.dart';

Future<List> balance;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    balance = databaseServices.calculateBalance();
    super.initState();
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
          if (snapshot.hasData)
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(
                  'Balance Amount: Rs ' +
                      snapshot.data[0].values
                          .toString()
                          .replaceAll('(', '')
                          .replaceAll(')', ''),
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
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
