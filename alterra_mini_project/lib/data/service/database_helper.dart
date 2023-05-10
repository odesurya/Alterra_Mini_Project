import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:alterra_mini_project/model/base_model.dart';

class CartDatabase {
  static final CartDatabase instance = CartDatabase._init();

  static Database? _database;

  CartDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart_items (
        id INTEGER PRIMARY KEY,
        imageUrl TEXT NOT NULL,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        review REAL NOT NULL,
        star REAL NOT NULL,
        value INTEGER NOT NULL,
        size TEXT NOT NULL,
        newSize TEXT NOT NULL,
        selectedColor INTEGER NOT NULL
      )
    ''');
  }

  Future<List<BaseModel>> getAllCartItems() async {
    final db = await instance.database;
    final result = await db.query("cart_items");
    return result.map((json) => BaseModel.fromJson(json)).toList();
  }

  Future<void> addToCart(BaseModel item) async {
    final db = await instance.database;

    await db.insert(
      'cart_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCartItem(BaseModel item) async {
    final db = await instance.database;

    await db.update(
      'cart_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deleteCartItem(BaseModel item) async {
    final db = await instance.database;

    await db.delete(
      'cart_items',
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> clearCart() async {
    final db = await instance.database;

    await db.delete('cart_items');
  }
}
