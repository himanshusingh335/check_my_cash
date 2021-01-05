import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Text('This is the Home page'),
    );
  }
}
