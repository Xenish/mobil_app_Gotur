import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserData {
  static String? username;
  static String? password;

  // Veritabanı referansı
  static Database? _database;

  // Veritabanını başlat
  static Future<void> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_data.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_data (id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
        );
      },
    );
  }

  // Veritabanını başlat ve kullanıcı verilerini yükle
  static Future<void> loadFromDatabase() async {
    if (_database == null) await _initDatabase();

    final result = await _database!.query('user_data', limit: 1);
    if (result.isNotEmpty) {
      username = result[0]['username'] as String?;
      password = result[0]['password'] as String?;
    }
  }

  // Kullanıcı adını ve şifresini veritabanına kaydet
  static Future<void> saveToDatabase(String newUsername, String newPassword) async {
    if (_database == null) await _initDatabase();

    // Daha önce kayıt varsa sil
    await _database!.delete('user_data');

    // Yeni kayıt ekle
    await _database!.insert('user_data', {
      'username': newUsername,
      'password': newPassword,
    });

    // Bellekteki verileri güncelle
    username = newUsername;
    password = newPassword;
  }

  // Kullanıcı bilgilerini kontrol eden bir metot
  static bool validateCredentials(String inputUsername, String inputPassword) {
    return username == inputUsername && password == inputPassword;
  }

  // Kullanıcı bilgilerini temizleyen bir metot
  static Future<void> clear() async {
    if (_database == null) await _initDatabase();

    // Veritabanını temizle
    await _database!.delete('user_data');
    username = null;
    password = null;
  }
}
