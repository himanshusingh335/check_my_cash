import 'package:flutter/material.dart';
import 'Home_Screen_Tabs/OverView.dart';
import 'Home_Screen_Tabs/Daily.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/new').then((value) {
              setState(() {});
            });
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
        ]),
      ),
    );
  }
}
