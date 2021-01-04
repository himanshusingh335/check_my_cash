import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'transactions.dart';

class DatabaseServices {
  Database database;

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "transactions_table.db";
    database = await openDatabase(path, version: 1, onCreate: createDb);
    return database;
  }

  void createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE transactions(id INTEGER PRIMARY KEY, date TEXT, amount INTEGER, reason TEXT)");
  }

  Future<void> addTransaction(Transactions transaction) async {
    // Get a reference to the database.
    if (database == null) {
      createDb(database, 1);
    }
    final Database db = database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    if (db == null) {
      print(
          "AAAAAAAAAAAAAAAAAAA NO DATABASE HAS BEEN MADE AAAAAAAAAAAAAAAAAAAA");
    }
    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Transactions>> getTransactions() async {
    // Get a reference to the database.
    final Database db = database;

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
    final db = database;

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
    final db = database;

    // Remove the Transaction from the Database.
    await db.delete(
      'transactions',
      // Use a `where` clause to delete a specific transaction.
      where: "id = ?",
      // Pass the Transactions's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
