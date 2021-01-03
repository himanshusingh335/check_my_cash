import 'package:flutter/material.dart';

class NewSpendingScreen extends StatefulWidget {
  @override
  _NewSpendingScreenState createState() => _NewSpendingScreenState();
}

class _NewSpendingScreenState extends State<NewSpendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'New Spending',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Text('This is the New spending screen'),
    );
  }
}
