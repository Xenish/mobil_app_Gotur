import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class FullAddress {
  static String? fullAddress;
  static Database? _database;

  static Future<void> _initDatabase() async {
    final dbPath = await getDatabasesPath(); // 'getDatabasesPath' direkt kullanılıyor
    final fullPath = path.join(dbPath, 'full_address.db');

    _database = await openDatabase(
      fullPath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE full_address (id INTEGER PRIMARY KEY, address TEXT)',
        );
      },
    );
  }

  static Future<void> loadFromDatabase() async {
    if (_database == null) await _initDatabase();

    final result = await _database!.query('full_address', limit: 1);
    if (result.isNotEmpty) {
      fullAddress = result[0]['address'] as String?;
    }
  }

  static Future<void> saveToDatabase(List<String> addressParts) async {
    if (_database == null) await _initDatabase();

    final address = addressParts.join(', ');
    await _database!.delete('full_address');
    await _database!.insert('full_address', {'address': address});

    fullAddress = address;
  }

  static Future<void> clear() async {
    if (_database == null) await _initDatabase();

    await _database!.delete('full_address');
    fullAddress = null;
  }
}
