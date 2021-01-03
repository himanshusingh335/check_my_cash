import 'package:check_my_cash/screens/Edit_Budget.dart';
import 'package:check_my_cash/screens/Home_Screen.dart';
import 'package:check_my_cash/screens/New_Spending.dart';
import 'package:check_my_cash/screens/Transaction_History.dart';
import 'package:check_my_cash/screens/settings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CheckMyCash());
}

class CheckMyCash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      title: "Check My Cash",
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/new': (context) => NewSpendingScreen(),
        '/history': (context) => TransactionHistoryScreen(),
        '/edit': (context) => EditBudgetScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
