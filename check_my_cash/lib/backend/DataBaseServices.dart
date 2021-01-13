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
    String path = dir.path + "transactions_table.db";
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
  }

  Future<List<Transactions>> getTransactions() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Transactions.
    final List<Map<String, dynamic>> maps = await db.query('transactions');
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

  Future<void> updateTransaction(Transactions transaction) async {
    // Get a reference to the database.
    final Database db = await database;

    // Update the given Transaction.
    await db.update(
      'transactions',
      transaction.toMap(),
      // Ensure that the Transaction has a matching id.
      where: "id = ?",
      // Pass the Transaction's id as a whereArg to prevent SQL injection.
      whereArgs: [transaction.id],
    );
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
  }

  Future<String> calculateBalance() async {
    final Database db = await database;

    var balance = await db.rawQuery("SELECT SUM(amount) FROM transactions");
    //notifyListeners();
    return balance[0].values.toString();
  }

  Future<String> calculateCredit() async {
    final Database db = await database;

    var credit = await db
        .rawQuery("SELECT SUM(amount) FROM transactions WHERE amount>0");
    //notifyListeners();

    return credit[0].values.toString();
  }

  Future<String> calculateDebit() async {
    final Database db = await database;

    var debit = await db
        .rawQuery("SELECT SUM(amount) FROM transactions WHERE amount<0");
    //notifyListeners();

    return debit[0].values.toString();
  }

  Future getHomePageValues() async {
    var values = new List();
    values.add(await calculateBalance());
    values.add(await calculateCredit());
    values.add(await calculateDebit());
    notifyListeners();
    return values;
  }
}
