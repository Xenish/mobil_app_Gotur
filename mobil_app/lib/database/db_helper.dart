import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE user_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE full_address (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            full_address TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertUser(String username, String password) async {
    final db = await database;
    return await db.insert('user_data', {'username': username, 'password': password});
  }

  Future<int> insertAddress(String address) async {
    final db = await database;
    return await db.insert('full_address', {'full_address': address});
  }

  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final result = await db.query('user_data', limit: 1);
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> getAddress() async {
    final db = await database;
    final result = await db.query('full_address', limit: 1);
    return result.isNotEmpty ? result.first : null;
  }
}
