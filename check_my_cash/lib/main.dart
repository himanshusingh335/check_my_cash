import 'package:check_my_cash/backend/DataBaseServices.dart';
import 'package:check_my_cash/screens/Home_Screen.dart';
import 'package:check_my_cash/screens/New_Transaction.dart';
import 'package:check_my_cash/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    CheckMyCash(),
  );
}

class CheckMyCash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DatabaseServices(),
      child: MaterialApp(
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
          '/new': (context) => NewTransactionScreen(),
          '/settings': (context) => SettingsScreen(),
        },
      ),
    );
  }
}
