import 'package:flutter/material.dart';

class EditBudgetScreen extends StatefulWidget {
  @override
  _EditBudgetScreenState createState() => _EditBudgetScreenState();
}

class _EditBudgetScreenState extends State<EditBudgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Budget',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Text('This is the Edit Budget screen'),
    );
  }
}
