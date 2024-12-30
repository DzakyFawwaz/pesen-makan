import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'pemesanan.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        quantity INTEGER,
        price REAL,
        image TEXT
      )
    ''');
  }

  Future<int> insertCart(Map<String, dynamic> cart) async {
    Database db = await database;
    return await db.insert('cart', cart);
  }

  Future<List<Map<String, dynamic>>> getCart() async {
    Database db = await database;
    return await db.query('cart');
  }

  Future<int> updateCart(Map<String, dynamic> cart, int id) async {
    Database db = await database;
    return await db.update('cart', cart, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCart(int id) async {
    Database db = await database;
    return await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCart() async {
    Database db = await database;
    await db.delete('cart');
  }
}
