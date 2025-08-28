import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ExpenseDb {
  Database? _database;

  ExpenseDb() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    {
      _database = await _initializeDB();
      return _database!;
    }
  }

  Future<Database> _initializeDB() async {
    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      final dbPath = await databaseFactory.getDatabasesPath();
      final path = join(dbPath, 'local db');

      return await databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          email TEXT,
          password TEXT
        )
      ''');

            await db.execute('''
          CREATE TABLE expenses (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER,
          title TEXT,
          amount REAL,
          category TEXT,
          date TEXT,
          FOREIGN KEY (user_id) REFERENCES users (id)
        )
              ''');
          },
        ),
      );
    } else {
      final dbPath = await databaseFactory.getDatabasesPath();
      final path = join(dbPath, 'local db');

      return await databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          email TEXT,
          password TEXT
        )
      ''');

            await db.execute('''
          CREATE TABLE expenses (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER,
          title TEXT,
          amount REAL,
          category TEXT,
          date TEXT,
          FOREIGN KEY (user_id) REFERENCES users (id)
        )
              ''');
          },
        ),
      );
    }
  }

  Future<int> registerUers(
    String username,
    String email,
    String password,
  ) async {
    final db = await ExpenseDb().database;
    return await db.insert("users", {
      "username": username,
      "email": email,
      "password": password,
    });
  }

  Future<Map<String, dynamic>?> getUsers(String email, String password) async {
    final db = await ExpenseDb().database;
    final result = await db.query(
      "users",
      where: "email = ? AND password = ?",
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> insertExpense(int userId, String title, double amount, String category, String date) async {
  final db = await ExpenseDb().database;
  return await db.insert("expenses", {
    "user_id": userId,
    "title": title,
    "amount": amount,
    "category": category,
    "date": date
  });
}

Future<List<Map<String, dynamic>>> getExpenses(int userId) async {
  final db = await ExpenseDb().database;
  return await db.query("expenses", where: "user_id = ?", whereArgs: [userId]);
}

Future<int> deleteExpense(int expenseId) async {
  final db = await ExpenseDb().database;
  return await db.delete("expenses", where: "id = ?", whereArgs: [expenseId]);
}

}
