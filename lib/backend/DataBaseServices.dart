import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'transactions.dart';

class DatabaseServices extends ChangeNotifier {
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDb();
    }
    return _database;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "/transactions_table.db";
    _database = await openDatabase(path, version: 1, onCreate: createDb);
    return _database;
  }

  void createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE transactions(id INTEGER PRIMARY KEY, date TEXT, amount INTEGER, reason TEXT)");
  }

  Future<void> addTransaction(Transactions transaction) async {
    // Get a reference to the database
    final Database db = await database;

    // Insert the Transactions into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<List<Transactions>> getTransactionsByDate(String date) async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Transactions.
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM transactions WHERE date='$date'");
    // Convert the List<Map<String, dynamic> into a List<Transactions>.
    return List.generate(maps.length, (i) {
      return Transactions(
        id: maps[i]['id'],
        transactionDate: maps[i]['date'],
        transactionAmnt: maps[i]['amount'],
        reason: maps[i]['reason'],
      );
    });
  }

  Future<void> deleteTransaction(int id) async {
    // Get a reference to the database.
    final Database db = await database;

    // Remove the Transaction from the Database.
    await db.delete(
      'transactions',
      // Use a `where` clause to delete a specific transaction.
      where: "id = ?",
      // Pass the Transactions's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> deleteAllTransactions() async {
    // Get a reference to the database.
    final Database db = await database;

    // Remove the Transaction from the Database.
    await db.delete(
      'transactions',
    );
    notifyListeners();
  }

  Future<String> calculateBalance() async {
    final Database db = await database;

    var balance = await db.rawQuery("SELECT SUM(amount) FROM transactions");
    if (balance[0].values.toString() == '(null)') {
      return '0.00';
    } else
      return balance[0].values.toString();
  }

  Future<String> calculateTotalCredit() async {
    final Database db = await database;

    var credit = await db
        .rawQuery("SELECT SUM(amount) FROM transactions WHERE amount>0");
    if (credit[0].values.toString() == '(null)') {
      return '0.00';
    } else
      return credit[0].values.toString();
  }

  Future<String> calculateTotalDebit() async {
    final Database db = await database;

    var debit = await db
        .rawQuery("SELECT SUM(amount) FROM transactions WHERE amount<0");
    if (debit[0].values.toString() == '(null)') {
      return '0.00';
    } else
      return debit[0].values.toString();
  }
  
  Future<List> getSummary() async {
    final minCredit = await _getMinCredit();
    final maxCredit = await _getMaxCredit();
    final minDebit = await _getMinDebit();
    final maxDebit = await _getMaxDebit();
    return [minCredit, maxCredit, minDebit, maxDebit];
  }

  Future<double> _getMinCredit() async {
    final Database db = await database;
    var debit = await db.rawQuery("SELECT min(amount) FROM transactions WHERE amount > 0");
    if (debit[0].values.toString() == '(null)') {
      return 0;
    } else {
      return double.parse(debit[0].values.toString().replaceAll('(', '').replaceAll(')', ''));
    }
  }

  Future<double> _getMaxCredit() async {
    final Database db = await database;
    var debit = await db.rawQuery("SELECT max(amount) FROM transactions WHERE amount > 0");
    if (debit[0].values.toString() == '(null)') {
      return 0;
    } else {
      return double.parse(debit[0].values.toString().replaceAll('(', '').replaceAll(')', ''));
    }
  }

  Future<double> _getMinDebit() async {
    final Database db = await database;
    var debit = await db.rawQuery("SELECT max(amount) FROM transactions WHERE amount < 0");
    if (debit[0].values.toString() == '(null)') {
      return 0;
    } else {
      return double.parse(debit[0].values.toString().replaceAll('(', '').replaceAll(')', ''));
    }
  }

  Future<double> _getMaxDebit() async {
    final Database db = await database;
    var debit = await db.rawQuery("SELECT min(amount) FROM transactions WHERE amount < 0");
    if (debit[0].values.toString() == '(null)') {
      return 0;
    } else {
      return double.parse(debit[0].values.toString().replaceAll('(', '').replaceAll(')', ''));
    }
  }

  Future<String> calculateMonthlyCredit(String date) async {
    final Database db = await database;

    var credit = await db.rawQuery(
        "SELECT SUM(amount) FROM transactions WHERE amount>0 AND date LIKE '%$date'");
    if (credit[0].values.toString() == '(null)') {
      return '0.00';
    } else
      return credit[0].values.toString();
  }

  Future<String> calculateMonthlyDebit(String date) async {
    final Database db = await database;

    var debit = await db.rawQuery(
        "SELECT SUM(amount) FROM transactions WHERE amount<0 AND date LIKE '%$date'");
    if (debit[0].values.toString() == '(null)') {
      return '0.00';
    } else
      return debit[0].values.toString();
  }

  Future getOverViewValues() async {
    var values = [];
    values.add(await calculateBalance());
    values.add(await calculateTotalCredit());
    values.add(await calculateTotalDebit());
    values.add(await calculateMonthlyCredit(DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString()));
    values.add(await calculateMonthlyDebit(DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString()));
    values.add(await calculateMonthlyCredit(
        (DateTime.now().month - 1).toString() +
            '/' +
            DateTime.now().year.toString()));
    values.add(await calculateMonthlyDebit(
        (DateTime.now().month - 1).toString() +
            '/' +
            DateTime.now().year.toString()));
    return values;
  }

  Future<String> calculateDailyCredit(String date) async {
    final Database db = await database;

    var credit = await db.rawQuery(
        "SELECT SUM(amount) FROM transactions WHERE amount>0 AND date='$date'");
    if (credit[0].values.toString() == '(null)') {
      return '0.00';
    } else
      return credit[0].values.toString();
  }

  Future<String> calculateDailyDebit(String date) async {
    final Database db = await database;

    var debit = await db.rawQuery(
        "SELECT SUM(amount) FROM transactions WHERE amount<0 AND date='$date'");
    if (debit[0].values.toString() == '(null)') {
      return '0.00';
    } else
      return debit[0].values.toString();
  }

  Future getDailyValues(String date) async {
    var values = [];
    values.add(await calculateBalance());
    values.add(await calculateDailyCredit(date));
    values.add(await calculateDailyDebit(date));
    return values;
  }
}
