import 'package:flutter/material.dart';
import 'Home_Screen_Tabs/OverView.dart';
import 'Home_Screen_Tabs/Daily.dart';
import 'Home_Screen_Tabs/Monthly.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.green,
            tabs: <Tab>[
              new Tab(text: 'Overview'),
              new Tab(text: 'Daily'),
              new Tab(text: 'Monthly'),
            ],
          ),
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
        body: new TabBarView(children: <Widget>[
          HSOverView(),
          HSDaily(),
          HSMonthly(),
        ]),
      ),
    );
  }
}
